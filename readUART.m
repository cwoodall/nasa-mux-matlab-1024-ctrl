function [ msg ] = readUART( s )
%READCHANNEL Summary of this function goes here
%   Detailed explanation goes here
    c = 0;
    msg = [];
    while c ~= 130 
        c =fread(s,1,'uint8');
        msg = [msg c];
    end
end

