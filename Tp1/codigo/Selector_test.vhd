library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Selector is
end;

architecture test_SelDisplay of test_Selector is
	signal	sel_t: std_logic_vector(1 downto 0) := "00";
	signal	output_t: std_logic_vector(3 downto 0);
	
	
	component Selector is
		generic(
			N: natural := 2;
			M: natural := 4
		);
		port(
			sel: in std_logic_vector(N-1 downto 0);
			output: out std_logic_vector(M-1 downto 0)
		);
	end component;

begin
	inst_Selector: Selector
		port map(
			sel => sel_t,
			output => output_t
		);
	sel_t(0) <= not sel_t(0) after 10 ns;
	sel_t(1) <= not sel_t(1) after 20 ns;
end;
