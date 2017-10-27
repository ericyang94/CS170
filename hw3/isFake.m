function newPhoto = isFake(photo,pc)

A=imread(photo);
sizeA=size(A);
m=sizeA(1);
n=sizeA(2);

R=reshape(A,m*n,3);
CovR=cov(double(R));
[U,S,V]=svd(CovR);

PC=U(:,1:3);
ThirdPC = PC(:,3);
SecondPC=PC(:,2);
FirstPC = PC(:,1);
if pc == 1
  newPhoto=double(R)*double(FirstPC);
  newPhoto=reshape(newPhoto,m,n);
  imshow(newPhoto, []);
  end
if pc ==2
  newPhoto=double(R)*double(SecondPC);
  newPhoto=reshape(newPhoto,m,n);
  imshow(newPhoto, []);
end
if pc == 3
  newPhoto=double(R)*double(ThirdPC);
  newPhoto=reshape(newPhoto,m,n);
  imshow(newPhoto, []);
end