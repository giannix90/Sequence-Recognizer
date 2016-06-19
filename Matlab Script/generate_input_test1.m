function generate_inpute_test1()
	mkdir('C:\My_Designs\seq_recognizer\seq_rec\src'); %creo la cartella log
    id=fopen('C:\My_Designs\seq_recognizer\seq_rec\src\test.txt' , 'wt'); %apro il file test.txt e se non presente lo creo, ritorno il suo file descriptor in id
	number_it=2500;
	count=0;
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010010000');
	fprintf(id,'%s \n','0010010000');
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010010000');
	fprintf(id,'%s \n','0010010000');
	%%
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010000001');
	fprintf(id,'%s \n','0010010000');
	%%
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0010010000');
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0000001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010000001');
	fprintf(id,'%s \n','0010010000');
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0000001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010000000');
	fprintf(id,'%s \n','0010010000');
	
	%%
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001101');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010010000');
	fprintf(id,'%s \n','0010010000');
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001100');
	fprintf(id,'%s \n','0011100001');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010010000');
	fprintf(id,'%s \n','0010010000');
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010101');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010010000');
	fprintf(id,'%s \n','0010010000');
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100101');
	fprintf(id,'%s \n','0010010000');
	fprintf(id,'%s \n','0010010000');
	
	fprintf(id,'%s \n','0010010010');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0001001100');
	fprintf(id,'%s \n','0011100000');
	fprintf(id,'%s \n','0110010100');
	fprintf(id,'%s \n','0100100100');
	fprintf(id,'%s \n','0010010001');
	fprintf(id,'%s \n','0010010000');
	
	fprintf(id,'%s%s \n',dec2bin(round(rand(1)*255),8),'10');
	
	c=round(rand(1)*255);
	str = dec2bin(c,8);
	fprintf(id,'%s%s \n',dec2bin(round(rand(1)*255),8),'01');
	
	for i = 1:number_it
	
	if (mod(i,22)==0) fprintf(id,'%s%s \n',dec2bin(round(rand(1)*255),8),'10'); fprintf(id,'%s%s \n',dec2bin(round(rand(1)*255),8),'01');count=count+2;
	elseif (mod(i-count,5)==0) fprintf(id,'%s%s \n',dec2bin(round(rand(1)*255),8),'01');
	else fprintf(id,'%s%s \n',dec2bin(round(rand(1)*255),8),'00');
	end
	end
	
	end