s = serial('COM8', 'BAUD', 9600); 
fopen(s);

%%
vref = 2.9; % Reference voltage on the ADC
desiredV = 0.5*vref;
startAddr = hex2dec('1000');
endAddr = startAddr +255;

err = disableCRC(s);
if err < 0
    disp('Error')
end

for dacAddr = startAddr:endAddr
    %fread(s,7)
    err = writeChannel( s, dacAddr , desiredV, vref);
    if err < 0
        disp('Error')
    %else 
   %     disp(sprintf('Success on channel %4x', dacAddr-startAddr))
    end
end
%%
fclose(s);
delete(s);