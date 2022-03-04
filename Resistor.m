function Resistor(np,nn,value)
% np: positive node
% nn: negative node
% value: resistance

global G

% Updating G matrix
if np ~= 0
    G(np,np) = G(np,np) + 1/value;
end
if nn ~= 0
    G(nn,nn) = G(nn,nn) + 1/value;
end
if (np ~= 0) && (nn ~= 0)
    G(np,nn) = G(np,nn) - 1/value;
    G(nn,np) = G(nn,np) - 1/value;
end

end