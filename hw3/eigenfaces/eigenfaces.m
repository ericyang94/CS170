function sigma = eigenfaces(fNames, intK, intS) %return k singular values

samplesize = intS; %number of sample faces used to find eigenfaces                          
k = intK;  %number of singular values to use

%Convert between images and vectors
row = 64;
col = 64;
image_vector = @(Bitmap) double(reshape(Bitmap,1,row*col));
vector_image = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);
vector_render = @(Vec) imshow(vector_image(Vec));

%Load all the faces
filenames = fNames;
if(samplesize>0)
    n = min(size(filenames,1),samplesize); %only look at first samplesize # of faces
else
    n=size(filenames,1); %if s is an invalid number, use the entire sample
end
    
for i = 1:n
    Image_File = char(filenames(i)); %convert cell-array of string into regular string
    Face_Matrix = imread(Image_File);
    F(i,:) = image_vector(Face_Matrix); %i-th row of F is i-th image
end

%Find average face
m = mean(F)'; %average of all rows in F
vector_render(m);
title('average face');

sigma = m;