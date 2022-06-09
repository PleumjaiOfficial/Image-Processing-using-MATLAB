% Input image 
img = rgb2gray(imread('picture.bmp'));

% STEP1: Select first 8x8 block of image 
block = img(1:8, 1:8);

% STEP2: Shift block(-128)
block_Shifted = double(block) - 128;

% Assign Normalized Matrix
Q = [ 16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62; 
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];

% STEP3: Assume constant to multiply with matrix Q
% constanty = 5
Q1 = round(Q.*(ones(8)*(5)));
% Quality = 10
Q2 = round(Q.*(ones(8)*(10)));
% Quality = 15
Q3 = round(Q.*(ones(8)*15));

% STEP4: DCT
DCT_block_Shifted = dct2(block_Shifted);

% STEP5: DCT value dividing by Normalized Matrix
output = round(DCT_block_Shifted./Q);
output1 = round(DCT_block_Shifted./Q1);
output2 = round(DCT_block_Shifted./Q2);
output3 = round(DCT_block_Shifted./Q3);

Vector_Q = ZigZagscan(output);
Vector_Q1 = ZigZagscan(output1);
Vector_Q2 = ZigZagscan(output2);
Vector_Q3 = ZigZagscan(output3);


%**************************************************************************
% ZigZagscan Transform an matrix to a vector using Zig Zag Scan.
% Autors : Said BOUREZG   
% Engineer on Electronics  option: Communication
%**************************************************************************
function Vect=ZigZagscan(X)
[~, N]=size(X);
Vect=zeros(1,N*N);
Vect(1)=X(1,1);
v=1;
for k=1:2*N-1
    if k<=N
        if mod(k,2)==0
        j=k;
        for i=1:k
        Vect(v)=X(i,j);
        v=v+1;j=j-1;    
        end
        else
        i=k;
        for j=1:k   
        Vect(v)=X(i,j);
        v=v+1;i=i-1; 
        end
        end
    else
        if mod(k,2)==0
        p=mod(k,N); j=N;
        for i=p+1:N
        Vect(v)=X(i,j);
        v=v+1;j=j-1;    
        end
        else
        p=mod(k,N);i=N;
        for j=p+1:N   
        Vect(v)=X(i,j);
        v=v+1;i=i-1; 
        end
        end
    end
end
end

