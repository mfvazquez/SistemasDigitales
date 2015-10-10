library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Serializer is
end;

architecture test_Serializer of test_Serializer is
	signal	input_t: std_logic_vector(3 downto 0) := "0000";
	signal	display_t: std_logic_vector(7 downto 0);
	
	
	component Serializer is
		port (
			input: in std_logic_vector(3 downto 0);
			display: out std_logic_vector(7 downto 0)
		);
	end component;

begin
	inst_Serializer: Serializer
		port map(
			input => input_t,
			display => display_t
		);
	input_t(0) <= not input_t(0) after 10 ns;
	input_t(1) <= not input_t(1) after 20 ns;
	input_t(2) <= not input_t(2) after 40 ns;
	input_t(3) <= not input_t(3) after 80 ns;
end;