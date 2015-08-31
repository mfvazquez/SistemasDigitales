library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_GenEna is
end;

architecture test_GenEna1 of test_GenEna is
	signal clk_t: std_logic := '0';
	signal cuenta_t: std_logic_vector(25 downto 0);
	signal en_t: std_logic;
	
	component GenEna is
		port (
		clk: in std_logic;
		cuenta_aux: out std_logic_vector(25 downto 0);
		en: out std_logic
		);
	end component;

begin
	inst_GenEna: GenEna
		port map(
			clk => clk_t,
			cuenta_aux => cuenta_t,
			en => en_t
		);
	clk_t <= not clk_t after 10 ns;
end;