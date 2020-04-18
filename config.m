function flags = exp_001_002(default_flags)
flags=default_flags;

% flags.input_image_name = 'input_images/singapore.jpg';
% flags.video_path = './videos/dubai.avi';
% flags.end_frame = 1512;
% flags.output_frame_sample=387;
% flags.input_image_width=480;
% flags.output_folder='./results/demo_singapore/';

flags.input_image_name = 'input_images/yash.jpg';
flags.video_path = '../videos_h264/04_16_2012_15_58_53.mp4';
flags.end_frame = 2438;
flags.output_frame_sample=850;
flags.input_image_width=350;
flags.output_folder='./results/demo_yash/';

flags.domain_adaptation=true;
flags.time_editing_root='./';

%% Hard-coded default flags
flags.resize_input_image=true;
flags.resize_example_image=true;
flags.example_image_width=flags.input_image_width;
flags.make_video=false;
flags.mrf_match.total_frame_num=50;
flags.k_best_patches.k=1;
flags.k_candidates.patch_size=5; % this is half patchsize
flags.k_candidates.overlap_size=4;
flags.k_candidates.NN=30;
flags.k_candidates.patchDimL=11; % this is the full patch size  (2*patch_size+1)
flags.k_candidates.sigma=8;
flags.k_candidates.half_band=2;

% ------------------------
flags.mrf.patch_size=5;
flags.mrf.overlap_size=4;
flags.mrf.patchDimL=11;
flags.mrf.NN=30;
flags.mrf.num_norm=Inf;
% ------------------------
flags.mrf.solver='belief_propagation';
flags.mrf.belief_propagation.num_iterations=20;
flags.mrf.belief_propagation.alpha=0.5;
flags.mrf.visualization='merge';

flags.regularized_linear_regression.patch_size=5;
flags.regularized_linear_regression.epsilon=0.008;
flags.regularized_linear_regression.gamma=1;
