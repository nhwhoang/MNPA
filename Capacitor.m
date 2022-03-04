function Capacitor(np,nn,value)
% np: positive node
% nn: negative node
% value: capacitance

global C 

% Updating C matrix
if np ~= 0
    C(np,np) = C(np,np) + value;
end
if nn ~= 0
    C(nn,nn) = C(nn,nn) + value;
end
if (np ~= 0) && (nn ~= 0)
    C(np,nn) = C(np,nn) - value;
    C(nn,np) = C(nn,np) - value;
end

end