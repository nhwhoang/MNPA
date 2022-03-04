function VCVSource(np,nn,ncp,ncn,value)
% implicit linear

% np: positive output node
% nn: negative output node
% ncp: positive control node
% ncn: negative control node
% value: gain

global G B C

% Adding new row (B matrix) and new row + column (G matrix) 
nG = size(G,1) + 1;     % new row
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

if ncp ~= 0
    G(nG,ncp) = G(nG,ncp) - value;
end
if ncn ~= 0
    G(nG,ncn) = G(nG,ncn) + value;
end 

end