function result = goodOrEvil(image)

evil =
[
'face014.bmp'  ,
'face017.bmp'  ,
'face018.bmp'  ,
'face019.bmp'  ,
'face026.bmp'  ,
'face027.bmp'  ,
'face029.bmp'  ,
'face030.bmp'  ,
'face033.bmp'  ,
'face035.bmp'  ,
'face038.bmp'  ,
'face048.bmp'  ,
'face050.bmp'  ,
'face056.bmp'  ,
'face060.bmp'  ,
'face066.bmp'  ,
'face073.bmp'  ,
'face074.bmp'  ,
'face076.bmp'  ,
'face077.bmp'  ,
'face078.bmp'  ,
'face080.bmp'  ,
'face081.bmp'  ,
'face083.bmp'  ,
'face092.bmp'  ,
'face106.bmp'  ,
'face107.bmp'  ,
'face111.bmp'  ,
'face114.bmp'  ,
'face115.bmp'  ,
'face121.bmp'  ,
'face122.bmp'  ,
'face124.bmp'  ,
'face133.bmp'  ,
'face134.bmp'  ,
'face140.bmp'  ,
'face142.bmp'  ,
'face144.bmp'  ,
'face146.bmp'  ,
'face149.bmp'  ,
'face154.bmp'  ,
'face157.bmp'  ,
'face162.bmp'  ,
'face164.bmp'  ,
'face165.bmp'  ,
'face167.bmp'  ,
'face175.bmp'  
];

good =
[
'face000.bmp'   ,
'face001.bmp'   ,
'face002.bmp'   ,
'face003.bmp'   ,
'face004.bmp'   ,
'face005.bmp'   ,
'face006.bmp'   ,
'face007.bmp'   ,
'face008.bmp'   ,
'face009.bmp'   ,
'face010.bmp'   ,
'face012.bmp'   ,
'face013.bmp'   ,
'face015.bmp'   ,
'face016.bmp'   ,
'face020.bmp'   ,
'face022.bmp'   ,
'face023.bmp'   ,
'face025.bmp'   ,
'face028.bmp'   ,
'face031.bmp'   ,
'face032.bmp'   ,
'face034.bmp'   ,
'face036.bmp'   ,
'face037.bmp'   ,
'face039.bmp'   ,
'face040.bmp'   ,
'face041.bmp'   ,
'face042.bmp'   ,
'face043.bmp'   ,
'face044.bmp'   ,
'face045.bmp'   ,
'face046.bmp'   ,
'face047.bmp'   ,
'face049.bmp'   ,
'face051.bmp'   ,
'face052.bmp'   ,
'face053.bmp'   ,
'face054.bmp'   ,
'face055.bmp'   ,
'face057.bmp'   ,
'face058.bmp'   ,
'face059.bmp'   ,
'face061.bmp'   ,
'face062.bmp'   ,
'face063.bmp'   ,
'face064.bmp'   ,
'face065.bmp'   ,
'face067.bmp'   ,
'face068.bmp'   ,
'face069.bmp'   ,
'face070.bmp'   ,
'face071.bmp'   ,
'face072.bmp'   ,
'face075.bmp'   ,
'face079.bmp'   ,
'face082.bmp'   ,
'face084.bmp'   ,
'face085.bmp'   ,
'face086.bmp'   ,
'face087.bmp'   ,
'face088.bmp'   ,
'face089.bmp'   ,
'face090.bmp'   ,
'face091.bmp'   ,
'face093.bmp'   ,
'face095.bmp'   ,
'face096.bmp'   ,
'face097.bmp'   ,
'face098.bmp'   ,
'face099.bmp'   ,
'face100.bmp'   ,
'face101.bmp'   ,
'face102.bmp'   ,
'face103.bmp'   ,
'face104.bmp'   ,
'face105.bmp'   ,
'face108.bmp'   ,
'face109.bmp'   ,
'face110.bmp'   ,
'face112.bmp'   ,
'face113.bmp'   ,
'face116.bmp'   ,
'face117.bmp'   ,
'face118.bmp'   ,
'face119.bmp'   ,
'face120.bmp'   ,
'face123.bmp'   ,
'face125.bmp'   ,
'face126.bmp'   ,
'face129.bmp'   ,
'face130.bmp'   ,
'face131.bmp'   ,
'face132.bmp'   ,
'face136.bmp'   ,
'face137.bmp'   ,
'face138.bmp'   ,
'face139.bmp'   ,
'face141.bmp'   ,
'face143.bmp'   ,
'face145.bmp'   ,
'face148.bmp'   ,
'face151.bmp'   ,
'face152.bmp'   ,
'face153.bmp'   ,
'face155.bmp'   ,
'face156.bmp'   ,
'face158.bmp'   ,
'face159.bmp'   ,
'face160.bmp'   ,
'face161.bmp'   ,
'face163.bmp'   ,
'face166.bmp'   ,
'face168.bmp'   ,
'face169.bmp'   ,
'face170.bmp'   ,
'face171.bmp'   ,
'face172.bmp'   ,
'face173.bmp'   ,
'face174.bmp'   ,
'face176.bmp'   ,
'face177.bmp'
];


row = 64;
col = 64;
image_vector = @(Bitmap) double(reshape(Bitmap,1,row*col));
vector_image = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);
vector_render = @(Vec) imshow(vector_image(Vec));

for i = 1:122
    image = char(good(i)); 
    matrix = imread(image);
    faces(i,:) = image_vector(matrix);
end

vector_render(mean(faces)');
means = ones(n,1) * mean(faces);
X = (faces-means);

[U, S, V] = svds(cov(X), 30);
f0 = V;

for i = 1:47
    image = char(evil(i)); 
    matrix = imread(image);
    faces(i,:) = image_vector(matrix);
end

vector_render(mean(faces)');
means = ones(n,1) * mean(faces);
X = (faces-means);

[U, S, V] = svds(cov(X), 30);
f1 = V;

row = 64;
col = 64;
image_vector = @(Bitmap) double(reshape(Bitmap,1,row*col));
vector_image = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);
vector_render = @(Vec) imshow(vector_image(Vec));

matrix = imread(image);
f=double(matrix);
good = (f-f0);
evil = (f-f1);
result = (norm(evil) <= norm(good));
