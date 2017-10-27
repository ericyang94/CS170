function A = Build()
  A = [];
  for i=[1:13]
    I = imread (["./faces/basis/f" num2str(i) ".jpg"]);
    IVec = reshape(I, 148*100, 1);
    IVec = double(IVec);
    IVec = IVec / norm(double(IVec));
    A=[A IVec];
  endfor
endfunction
