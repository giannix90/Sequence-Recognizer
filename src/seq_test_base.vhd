library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity seq_test_base is
end seq_test_base;
--}} End of automatically maintained section
architecture seq_test_base of seq_test_base is
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
CONSTANT N : INTEGER := 8; -- Bus Width
CONSTANT MckPer : TIME := 10 ms; -- Master Clk period
CONSTANT TestLen : INTEGER := 340; -- No. of Count (MckPer/2) for test
-- I N P U T S I G N A L S
SIGNAL clk : std_logic := '0';
SIGNAL first : std_logic := '0';
SIGNAL x : std_logic_vector(N-1 downto 0):="00000000";
SIGNAL reset : std_logic:='0';
-- O U T P U T S I G N A L S
SIGNAL unlock : std_logic;
SIGNAL warning : std_logic;
SIGNAL clk_cycle : INTEGER;
SIGNAL Testing: Boolean := True;
--signal cnt: integer;
begin
I : Seq PORT MAP(clk,reset,first,x,unlock,warning);
-- Generates clk
clk <= NOT clk AFTER MckPer/2 WHEN Testing ELSE '0';
-- Runs simulation for TestLen cycles;
Test_Proc: PROCESS(clk)
VARIABLE count: INTEGER:= 0;
BEGIN
clk_cycle <= (count+1)/2;
CASE count IS
WHEN 3 => reset <= '1'; x<="00100100";
WHEN 5 => reset <= '0'; x<="00100100";first<='1';
WHEN 7 => reset <= '0'; x<="00010011";first<='0';
WHEN 9 => reset <= '0'; x<="00111000";first<='1';
WHEN 11 => reset <= '0'; x<="01100101";first<='0';
WHEN 13 => reset <= '0'; x<="01001001";first<='0';
--2° round
WHEN 15 => reset <= '0'; x<="00100100";first<='1';
WHEN 17 => reset <= '0'; x<="00110000";first<='0';
WHEN 19 => reset <= '0'; x<="00100101";first<='0';
WHEN 21 => reset <= '0'; x<="00110011";first<='0';
WHEN 23 => reset <= '0'; x<="00111001";first<='0';
WHEN 25 => reset <= '0'; x<="01100100";first<='1';
WHEN 27 => reset <= '0'; x<="01001010";first<='0';
WHEN 29 => reset <= '0'; x<="01101000";first<='0';
WHEN 31 => reset <= '0'; x<="11001000";first<='0';
WHEN 33 => reset <= '0'; x<="11001000";first<='0';
WHEN 35 => reset <= '0'; x<="11001000";first<='1';
WHEN 37 => reset <= '0'; x<="11001000";first<='0';
WHEN 39 => reset <= '0'; x<="11001000";first<='0';
WHEN 41 => reset <= '0'; x<="11001000";first<='0';
WHEN 43 => reset <= '0'; x<="11001000";first<='0';
WHEN 45 => reset <= '0'; x<="11001000";first<='1';
WHEN 47 => reset <= '0'; x<="11001000";first<='0';
WHEN 49 => reset <= '0'; x<="11001000";first<='0';
WHEN (TestLen - 1) => Testing <= False;
WHEN OTHERS => NULL;
END CASE;
count:= count + 1;
END PROCESS Test_Proc;
end seq_test_base;