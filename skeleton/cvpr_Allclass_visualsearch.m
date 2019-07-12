%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.



close all;
clear all;

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = 'C:\Users\jiang\Desktop\CVML\Sem1-Computer Vision and Pattern Recognition\Coursework-Nov 20 TUESDAY\MSRC_ObjCategImageDatabase_v2';

%% Folder that holds the results...
DESCRIPTOR_FOLDER = 'C:\Users\jiang\Desktop\CVML\Sem1-Computer Vision and Pattern Recognition\Coursework-Nov 20 TUESDAY\descriptors';
%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER='globalRGBhisto';


%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)
ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./256;
    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    ctr=ctr+1;
end
%% (Additionally) Single images test & All class test
 for w=1:1:20 % 20 class images
 NIMG=size(ALLFEAT,1);           % number of images in collection
q = [11 43 73 107 137 167 191 221 251 281 311......
    341 362 392 422 452 482 512 542 572];  % first image of each class
t = {'10.flower','11.sign','12.bird','13.book','14.chair','15.cat','16.dog','17.building'......
    '18.water1 etc.','19.people','1.grass etc.','20.water2 etc.','2.tree','3.house'......
    '4.aircraft','5.cow','6.face','7.car','8.bike','9.sheep'};

% queryimg=572;  %for single image class test
queryimg = q(w); % for all class image test

%% 2) Pick an image at random to be the query
% NIMG=size(ALLFEAT,1);           % number of images in collection
% queryimg=floor(rand()*NIMG);    % index of a random image

%% (Additionally) PCA
%[Eigenvalue, PCA_ALLFEAT] = PCA(ALLFEAT);

%% 3) Compute the distance of image to the query
dst=[];
for i=1:NIMG
%%%%%%%%%%%%%%%%%%%%%%%%%% Distance exclude Mahalanobis distance
%%%%%%%%%%%%%%%%%%%%%%%%%% 

    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryimg,:);    
    thedst=cvpr_compare(query,candidate);
    dst=[dst ; [thedst i]];

%%%%%%%%%%%%%%%%%%%%%%%%%% Compute Mahalanobis distance
%%%%%%%%%%%%%%%%%%%%%%%%%% 
%     candidate = PCA_ALLFEAT(i,:);
%     query = PCA_ALLFEAT(queryimg,:);
%     thedst = cvpr_compare(query,candidate,Eigenvalue.val'); % Compute Mahalanobis distance
%     dst=[dst ; [thedst i]];
end

dst=sortrows(dst,1);  % sort the results
%% Additionally) PR Cruve

[R,P] = PR_Curve(allfiles,dst);
figure(1);
subplot(4,5,w);% All class images test
plot(R,P);
title(t(w));   % All class images test
hold on        % All class images test

%title('Precision-Recall Curve'); xlabel('Recall'); ylabel('Precision');
%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=20; % Show top 20 results
dst=dst(1:SHOW,:);
outdisplay=[];
%figure
%imshow(imread(ALLFILES{queryimg}));
%title('Querying image');
for i=1:size(dst,1)
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end
%  figure(2)
%  imgshow(outdisplay);
%  axis off;
 end  %All class images test
