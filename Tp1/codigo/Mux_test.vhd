library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Mux is
end;

architecture Beh of test_Mux is
	signal	sel_t: std_logic_vector(1 downto 0) := "00";
	signal	input_t: std_logic_vector(15 downto 0) := B"1000_0100_0010_0001";
	signal	output_t: std_logic_vector(3 downto 0);
	
	component Mux is
		generic(
			inputs: natural := 16;
			data_bus: natural := 4;
			sel_length: natural := 2
		);
		port(
			input: in std_logic_vector(inputs-1 downto 0); 
			sel: in std_logic_vector(sel_length-1 downto 0);		
			output: out std_logic_vector(data_bus-1 downto 0)
		);
	end component;

begin
	
	inst_Mux: Mux
		generic map(
			inputs => 16,
			data_bus => 4,
			sel_length => 2
		)
		port map(
			input => input_t,
			sel => sel_t,		
			output => output_t
		);
	sel_t(0) <= not sel_t(0) after 10 ns;
	sel_t(1) <= not sel_t(1) after 20 ns;
end;
