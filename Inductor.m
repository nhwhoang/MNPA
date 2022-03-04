function Inductor(np,nn,value)
% np: positive node
% nn: negative node
% value: inductance

global G B C

% Adding new row (B matrix) and new row + column (G & C matrices)
nC = size(G,1) + 1;   % new row
B(nC) = 0; 
G(nC,nC) = 0; 
C(nC,nC) = 0; 

% Updating G matrix
if (np ~= 0)
    G(np,nC) = 1;
    G(nC,np) = 1;
end
if (nn ~= 0)
    G(nn,nC) = -1;
    G(nC,nn) = -1;
end

% Updating C matrix
C(nC,nC) = -value;

end