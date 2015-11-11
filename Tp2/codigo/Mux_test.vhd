library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Mux is
end;

architecture Beh of test_Mux is
	signal	sel_t: std_logic_vector(2 downto 0) := "000";
	signal	input_t: std_logic_vector(23 downto 0) := B"0000_0000_1000_0100_0010_0001";
	signal	output_t: std_logic_vector(5 downto 0);
	
	component Mux is
		port(
			input: in std_logic_vector(23 downto 0); 
			sel: in std_logic_vector(2 downto 0);		
			output: out std_logic_vector(5 downto 0)
		);
	end component;

begin
	
	inst_Mux: Mux
		port map(
			input => input_t,
			sel => sel_t,		
			output => output_t
		);
	sel_t(0) <= not sel_t(0) after 10 ns;
	sel_t(1) <= not sel_t(1) after 20 ns;
end;
