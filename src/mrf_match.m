function [correspondence energy type image_decriptor best_frame_descriptor] = mrf_match(image, best_frame, flags)
% Compute the correspondences by MRF matching.

addpath(fullfile('utils',  'TimeLapse'));
image=double(image);
best_frame=double(best_frame);

[candidates energy type] = k_candidates(image, best_frame, flags);
patch_size=flags.mrf.patch_size;
overlap_size=flags.mrf.overlap_size;

[Patches,Mask] = extractPatches(image, patch_size,overlap_size, patch_size);
CM_h=[];
CM_v=[];
best_frame_patches = im2patchesN(best_frame, patch_size);
CO = ComputeEvidence(Patches, candidates, best_frame_patches, flags.mrf);
total_frame_num=flags.mrf_match.total_frame_num;
examplar_video=VideoReader(flags.video_path);
sample_rate=examplar_video.NumberOfFrames/total_frame_num;

frames=[];
for k=1:total_frame_num
    frame_id=max(floor(sample_rate*k),1);
    frame=read(examplar_video, frame_id);
    if flags.resize_example_image
        height_width_ratio=size(frame, 1)/size(frame, 2);
        frame=imresize(frame,flags.example_image_width*[height_width_ratio 1]);
    end
    frames(:,:,:,k)=frame;
    fprintf('Read frames.... Progress: %d/%d  \r', k, total_frame_num);
end

fprintf('Check start\n')
for k=1:total_frame_num
    frame=frames(:,:,:,k);
    all_patches = im2patchesN(frame, patch_size);
    [CM_h_t(:,:,:,:,k) CM_v_t(:,:,:,:,k)] = ComputeCompatibility(all_patches, candidates, flags.mrf);
    fprintf('Iteration.... Progress: %d/%d \n',k,total_frame_num);
end
num_norm=flags.mrf.num_norm;
if num_norm == Inf
    CM_h = max(CM_h_t, [], 5).^2;
    CM_v = max(CM_v_t, [], 5).^2;
else
    CM_h = sum(CM_h_t,5).^(2/num_norm)/total_frame_num;
    CM_v = sum(CM_v_t,5).^(2/num_norm)/total_frame_num;
end

%% Run belief propagation
alpha = 3;
num_iterations=flags.mrf.belief_propagation.num_iterations;
[IDX,En] = immaxproduct(CO,CM_h*alpha,CM_v*alpha,num_iterations,0.5);
[dim,h,w]=size(Patches);
for i=1:h
    for j=1:w
        candidates(i,j).optimal_idx=IDX(i,j);
    end
end
correspondence=candidates;

function im_laplacian = GetDetails(im)
[height,width,nchannels]=size(im);
im_Low = imresize(imfilter(im,fspecial('gaussian',25,1),'same','replicate'),0.25,'bicubic');
im_low = imresize(im_Low,[height,width],'bicubic');
im_laplacian = im - im_low;
