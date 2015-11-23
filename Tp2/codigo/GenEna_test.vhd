library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_GenEna is
end;

architecture Beh of test_GenEna is
	signal clk_t: std_logic := '0';
	signal en_t: std_logic;
	
	component GenEna is
		generic (
			N: natural := 25;
			M: natural := 2
		);
		port (
		clk: in std_logic;
		en: out std_logic
		);
	end component;

begin
	inst_GenEna: GenEna
		generic map(
			N => 2,
			M => 1
		)
		port map(
			clk => clk_t,
			en => en_t
		);
	clk_t <= not clk_t after 10 ns;
end;
