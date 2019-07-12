%% cvpr_computedescriptors.m
%% Skeleton code provided as part of the coursework assessment
%% This code will iterate through every image in the MSRCv2 dataset
%% and call a function 'extractRandom' to extract a descriptor from the
%% image.  Currently that function returns just a random vector so should
%% be changed as part of the coursework exercise.
%%
close all;
clear all;

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER ='N:\×ÀÃæ\CVML\Sem1-Computer Vision and Pattern Recognition\Coursework-Nov 20 TUESDAY\MSRC_ObjCategImageDatabase_v2';

%% Create a folder to hold the results...
OUT_FOLDER = 'N:\×ÀÃæ\CVML\Sem1-Computer Vision and Pattern Recognition\Coursework-Nov 20 TUESDAY\descriptors';
%% and within that folder, create another folder to hold these descriptors
%% the idea is all your descriptors are in individual folders - within
%% the folder specified as 'OUT_FOLDER'.
OUT_SUBFOLDER='globalRGBhisto';


allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./256;
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
 %% Control
    M = 8; % General M
    A = 8; % Angular quatization
 %% Grid Mean Colour
    %F = Grid_MeanColour(img,M); %grid descriptor
 
 %% Global Colour Histogram
  % F = GlobalColourHistogram(img,M); % RGB Histogram Descriptor
 
 %% Grid Edge Orientation Histogram
  F = Grid_EdgeOrientationHistogram(img,M,A); % Edge Orientation Descriptor

  %% Combination Grid Mean Colour & Grid Edge Orientation Histogram
%       F1 = Grid_MeanColour(img,M); 
%       F2 = Grid_EdgeOrientationHistogram(img,M,A); 
%       F = Grid_Edge_MeanColour_Histogram(F1,F2,M); % Grid & Edge Orientation Descriptor

%%  Save Extracted Features    
    save(fout,'F');
    
    toc
end
