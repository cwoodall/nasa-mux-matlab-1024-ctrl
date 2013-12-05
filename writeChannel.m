function err = writeChannel( s, ch, voltage, vref)
%WRITECHANNEL Summary of this function goes here
%   Detailed explanation goes here
    % Change COM port as needed 
    % (look in Device Manager).
    resolution = 12;
    code = uint16(((2^resolution)*voltage/vref));
    ch = uint16(ch);
    lchar = bitand(255, code);
    hchar = bitand(255, bitsrl(code, 8));
%    
    laddr = bitand(255, uint16(ch));
    haddr = bitand(255, bitsrl(uint16(ch),8));

    %value = input('What value do you want the AD5504 to be? (hex value)', 's');
    fwrite(s, 129, 'uint8');
    fwrite(s, 133, 'uint8'); 
    if (haddr == 128) ||(haddr == 129)||(haddr == 130)
        fwrite(s, 128, 'uint8');
    end
    fwrite(s, haddr,  'uint8') 
    
    if (laddr == 128) ||(laddr == 129)||(laddr == 130)
        fwrite(s, 128, 'uint8');
    end
    fwrite(s, laddr, 'uint8')

    if (hchar == 128) ||(hchar == 129)||(hchar == 130)
        fwrite(s, 128, 'uint8');
    end
    fwrite(s, hchar,  'uint8') 

    if (lchar == 128) ||(lchar == 129)||(lchar == 130)
        fwrite(s, 128, 'uint8');
    end
    fwrite(s, lchar, 'uint8')

    fwrite(s, 0, 'uint8');
    fwrite(s, 0, 'uint8');
    fwrite(s, 130, 'uint8');
    
    msg = readUART(s);
  %  fprintf(s,[char(129) char(240) char(191) char(4) char(130)]);
    if msg(2) == 131
        err = 0;
    else
        err = -1;
    end
end

