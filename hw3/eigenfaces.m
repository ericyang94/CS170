function singularValues = eigenfaces(files, k, s)

row = 64;
col = 64;
image_vector = @(Bitmap) double(reshape(Bitmap,1,row*col));
vector_image = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);
vector_render = @(Vec) imshow(vector_image(Vec));


for i = 1:s
    image = char(files(i)); 
    matrix = imread(image);
    faces(i,:) = image_vector(matrix);
end

vector_render(mean(faces)');
means = ones(n,1) * mean(faces);
X = (faces-means);

[U, S, V] = svds(cov(X), k);
singularValues = diag(S);
Eigenfaces = V;

matrix_image = @(A) uint8(round ( (A-min(A))/(max(A)-min(A))*255 ));

x=ceil(sqrt(k)); 
for i=1:k
    subplot(x,x,i)
    vector_render(matrix_image(Eigenfaces(:,i)));
end