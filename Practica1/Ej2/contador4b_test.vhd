library IEEE;
use IEEE.std_logic_1164.all;

entity test is
end;

architecture test1 of test is
	signal clk_t: std_logic := '0';
	signal rst_t: std_logic := '1';
	signal Q0_t: std_logic;
	signal Q1_t: std_logic;
	signal Q2_t: std_logic;
	signal Q3_t: std_logic;
	
	component contador4b is
		port (
			clk: in std_logic;
			rst: in std_logic;
			Q0: out std_logic;
			Q1: out std_logic;
			Q2: out std_logic;
			Q3: out std_logic
		);
	end component;

begin
	inst_contador: contador4b
		port map(
			clk => clk_t,
			rst => rst_t,
			Q0 => Q0_t,
			Q1 => Q1_t,
			Q2 => Q2_t,
			Q3 => Q3_t
		);
	clk_t <= not clk_t after 10 ns;
	rst_t <= '1', '0' after 100 ns;
end;