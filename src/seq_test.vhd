library IEEE;
use IEEE.STD_LOGIC_1164.all;  
USE std.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;	 


entity seq_test is
end seq_test;

--}} End of automatically maintained section

architecture seq_test of seq_test is	  

component seq
		
	  	generic (N : INTEGER:=8);
	port(clk : in std_logic;
	reset : in std_logic;
	first : in std_logic;
	num_in: in std_logic_VECTOR (N-1 downto 0); 
	unlock: out std_logic;
	warning: out std_logic);
end component seq;	 

  ----------------------------------------------------------------------------
   CONSTANT N       :  INTEGER  := 8;       -- Bus Width
   CONSTANT MckPer  :  TIME     := 10 ms;  -- Master Clk period
   CONSTANT TestLen :  INTEGER  := 5000;      -- No. of Count (MckPer/2) for test


-- I N P U T     S I G N A L S

   SIGNAL   clk  : std_logic := '0';
   SIGNAL   first  : std_logic := '0';
   SIGNAL   x    : std_logic_vector(N-1 downto 0):="00000000";	  
   SIGNAL   reset  : std_logic:='0'; 

-- O U T P U T     S I G N A L S

  
   SIGNAL   unlock    : std_logic;
   SIGNAL   warning  : std_logic;
   SIGNAL clk_cycle : INTEGER;
   SIGNAL Testing: Boolean := True;
   SIGNAL unlock_t : std_logic;	
   SIGNAL   warning_t  : std_logic;	
   SIGNAL   test  : std_logic;
   --signal cnt: integer;


begin
		I : Seq PORT MAP(clk,reset,first,x,unlock,warning);
	
			 -- Generates clk

clk     <= NOT clk AFTER MckPer/2 WHEN Testing ELSE '0'; 
	
	
	
	   -- Runs simulation for TestLen cycles;

   Test_Proc: PROCESS(clk)
   VARIABLE count: INTEGER:= 0;
   file vec_file: text is in "test.txt";
   file out_t: text is in "test_out1.txt";
   variable buf_in: line;
   variable out_line: line;
   variable testv: integer;
   variable v_read: std_logic_vector(0 to 9); 
   variable test_out_read: std_logic_vector(0 to 1);
   BEGIN
     
	 -----
        	  clk_cycle <= (count+1)/2;
       
           
       if not endfile (vec_file) then
           		
			
           if (count mod 2)>0 then
			   readline (vec_file, buf_in);	 
			   readline (out_t, out_line);
			   read(buf_in,v_read);	
			   read(out_line,test_out_read);
			   --num_in
			   x(0)<=v_read(7);
			   x(1)<=v_read(6);
			   x(2)<=v_read(5);
			   x(3)<=v_read(4);
			   x(4)<=v_read(3);
			   x(5)<=v_read(2);
			   x(6)<=v_read(1);
			   x(7)<=v_read(0);
			   --reset in
			   reset<=v_read(8);
			   --first in
			   first<=v_read(9);   
			   	unlock_t<=test_out_read(0);
			   	warning_t<=test_out_read(1);   
				   test<= (unlock_t xor unlock) or (warning_t xor warning) or test	;
		   end if;	
		   
		   end if;
            				   
  
	
     CASE count IS
         
		  
          WHEN (TestLen - 1) =>   Testing <= False;
          WHEN OTHERS => NULL;
    END CASE;

     	 count:= count + 1;
   END PROCESS Test_Proc;
	
end seq_test;
