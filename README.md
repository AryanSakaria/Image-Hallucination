# Data-driven Hallucination of Different Times of Day from a Single Outdoor Photo Research Paper Implementation

Coded by:
*Prajwal Krishna*

*Faizan Khan*

*Aryan Sakaria*

This *README* file contains :
 1. Overview of The Paper
 2. Instructions for running the program

----------


About The Paper
-------------

>Given a single input image, this approach hallucinates the same scene at a different time of day. This approach uses a database of time-lapse videos to infer the transformation for hallucinating a new time of day. First, we find a time-lapse video with a scene that resembles the input. Then, we locate a frame at the same time of day as the input and another frame at the desired output time. Finally, example-based color transfer technique based on local affine transforms is applied.

For more information click [here](http://portal.acm.org/ft_gateway.cfm?id=2508419&type=pdf).

----------

## Running the program

- git clone https://github.com/PK1210/Image-Hallucination
- Install mexOpenCV for matlab 
- Do pip install -r requirements.txt
- Add path of mexOpenCV in addpath in libs/Timelapse/SearchCandidates.m 
- Download timelpaseHOG.pickle from the same drive link and put it in src
-Download the dataset from this link: https://drive.google.com/open?id=169AH1CZ9jSlBNGaIyiKwh9ZuIOxCf0MT
  in the main folder of the repository
- First run the jupyter notebook src/"selecting best videos.ipynb" <video path> <frame number>
-  Do matlab -nojvm 
-  Edit src/config.m , Set there desired image path, video path, approximate output frame number 
-  Do run_exp config
-  Check the results in results folder





*Note:* The development was done on a linux environment

_____
