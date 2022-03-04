function Vsource(np,nn,value)
% np: positive node
% nn: negative node
% value: voltage

global G B C

% Adding new row (B matrix) and new row + column (G matrix)
nG = size(G,1) + 1;   % new row
B(nG) = 0;
G(nG,nG) = 0; 
C(nG,nG) = 0; 

% Updating G matrix
if np ~= 0
    G(np,nG) = 1;
    G(nG,np) = 1;
end
if nn ~= 0
    G(nn,nG) = -1;
    G(nG,nn) = -1;
    
end

% Updating B matrix
B(nG) = value;

end