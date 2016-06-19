library IEEE;
use IEEE.STD_LOGIC_1164.all; 


entity seq is
	generic (N : INTEGER:=8);
	port(clk : in std_logic;
	reset : in std_logic;
	first : in std_logic;
	num_in: in std_logic_VECTOR (N-1 downto 0); 
	unlock: out std_logic;
	warning: out std_logic
	);
end seq;

architecture process_0 of seq is
	type state_type is (S0, S1, S2, S3, S4, SW, SL, SU);	--stati disponibili
	signal state : state_type;	 --registro di stato
	signal count : integer range 0 to 3; --contatore dei fallimenti di riconoscimento ==> per 3 fail si va nello stato di blocco SL
	signal wrng: std_logic;	   --flag che indica se c'è stato un errore di riconoscimento nella sequenza
	
	
	begin
		
		
		Seq_rec: process (reset,clk) --processo che viene richiamato quando si verifica una variazione in reset o clk
		begin 
			if (reset='1') then count <=0; state <=S0; wrng<='0';unlock<='0';warning<='0'; 	--azzero tutte le uscite e i registri
				
			elsif (clk'EVENT and clk='1') then  --cnt<=count;--campiona sul fronte di salita
				
			
			case state is  
				
				--Stato S0 --
				when S0 => unlock<='0';warning<='0';
				if (num_in="00100100" and first='1') then state<=S1;   --00100100 == 36	  --Al prossimo ciclo di clock si passa llo stato S1
				elsif ((num_in>"00100100" or num_in<"00100100" ) and first='1' ) then state <=S1 ; wrng<='1';
				else state<=SL;
				end if;
				
				--Stato S1 --
				when S1 => state <=S2; unlock<='0';warning<='0';
				if (num_in="00010011" and first='0') then state <=S2;		 --00010011==19
				else state <=S2 ;  wrng<='1';
				end if;	
				
				if(first='1') then state<=SL;warning<='1'; end if; --se ho ancora il pin first attivo alto mi blocco sullo stato locked SL al prossimo ciclo di clock
				
				--Stato S2 --
				when S2 => unlock<='0';warning<='0';
				if (num_in="00111000" and first='0') then state <=S3;	 --00111000==56
				else state<=S3 ;  wrng<='1';
				end if;	
				
				if(first='1') then state<=SL;warning<='1'; end if;
				
				--Stato S3 --
				when S3 =>unlock<='0';warning<='0';
				if (num_in="01100101" and first='0') then state <=S4;	 --01100101==101
				else state <= S4 ;  wrng<='1';
				end if;	 
				
				if(first='1') then state<=SL;warning<='1'; end if;
				
				--Stato S4 --
				when S4 => unlock<='0';warning<='0';
				if (num_in="01001001" and first='0' and wrng='0') then state <=SU; unlock<='1';warning<='0';	 --01001001==73	
				else state <= SW;unlock<='0';warning<='1';	 
				end if;	 
				
				if(first='1') then state<=SL;warning<='1'; end if;
				
				--Stato SU => Unlocked --
				when SU => unlock<='0';warning<='0';
				if (num_in="00100100" and first='1') then state <=S1; --passo alla campionazione della prossima sequenza
				elsif ((num_in>"00100100" or num_in<"00100100" ) and first='1') then state <= S1 ;wrng<='1';	
				else state<=SL;warning<='1'; --se il bit di first non è a 1 mi blocco	
				end if;	
				
				--Stato SW => Warning --	
				when SW=> unlock<='0';warning<='0';	
				case count is 	 
				
					when 0 to 2 =>
					if (num_in="00100100" and first='1') then state<=S1;count<=count+1;
					elsif((num_in>"00100100" or num_in<"00100100" ) and first='1')  then state<=S1;wrng<='1'; count<=count+1;
					else state<=SL;warning<='1';	 --se il bit di first non è a 1 mi blocco
					end if;
					
					when others => unlock<='0';warning<='1';	 state<=SL;	
					
				end case;	
				
				
				--Stato SL => Locked --
				when SL => state <=SL; unlock<='0';warning<='1';--mi blocco sullo stato SL fin quando il pin reset non diventa attivo alto
				 
				
			end case; 
			end if;
		end process;
		
		
	end;