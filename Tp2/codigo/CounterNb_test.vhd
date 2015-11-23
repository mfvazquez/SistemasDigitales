library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_CounterNb is
end;

architecture beh of test_CounterNb is
	signal clk_t: std_logic := '0';
	signal out1_t: std_logic;
	signal out2_t: std_logic;
	
	component CounterNb is
		port(
			clk: in std_logic;
			out1: out std_logic := '0';
			out2: out std_logic := '0'
		);
	end component;

begin
	inst_CounterNb: CounterNb
		port map(
			clk => clk_t,
			out1 => out1_t,
			out2 => out2_t
		);
	clk_t <= not clk_t after 10 ns;
end;
