function err = disableCRC(s)
%disableCRC disables the crc message from being sent.
%   Sends the message
    fwrite(s, 129, 'uint8');
    fwrite(s, 240, 'uint8');
    fwrite(s, 191, 'uint8');
    fwrite(s, 4,   'uint8');
    fwrite(s, 130, 'uint8');
    msg = readUART(s);
  %  fprintf(s,[char(129) char(240) char(191) char(4) char(130)]);
    if msg(2) == 131
        err = 0;
    else
        err = -1;
    end
end

