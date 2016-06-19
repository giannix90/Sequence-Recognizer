library IEEE;
use IEEE.STD_LOGIC_1164.all; 


entity wrapper is
	generic (N : INTEGER:=8);
	port(clk_1 : in std_logic;
	reset_1 : in std_logic;
	first_1 : in std_logic;
	num_in_1: in std_logic_VECTOR (N-2 downto 0); 
	unlock_1: out std_logic;
	warning_1: out std_logic
	);
end wrapper;

architecture wrapper of wrapper is

component Seq
	port(clk : in std_logic;
	reset : in std_logic;
	first : in std_logic;
	num_in: in std_logic_VECTOR (N-1 downto 0); 
	unlock: out std_logic;
	warning: out std_logic
	);
end component Seq;

signal not_reset: std_logic;
signal num_in_adapter: std_logic_vector (N-1 downto 0);

begin
	num_in_adapter(7)<='0';
	num_in_adapter(6 downto 0)<=num_in_1(6 downto 0);
	not_reset<= not reset_1;
	L1: Seq port map(clk_1,not_reset,first_1,num_in_adapter,unlock_1,warning_1);  
	
end wrapper;
