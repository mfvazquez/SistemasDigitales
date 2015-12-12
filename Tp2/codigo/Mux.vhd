library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux is
	port(
		input: in std_logic_vector(23 downto 0); 
		sel: in std_logic_vector(2 downto 0);		
		output: out std_logic_vector(5 downto 0)
	);
	
end;

architecture Beh of Mux is

	signal	sel_aux: std_logic_vector(2 downto 0);
	signal	input_aux: std_logic_vector(23 downto 0);
	signal	output_aux: std_logic_vector(5 downto 0);
	
	component Mux_gen is
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

	inst_Mux_gen: Mux_gen
		generic map(
			inputs => 24,
			data_bus => 4,
			sel_length => 3
		)
		port map(
			input => input_aux,
			sel => sel_aux,		
			output => output_aux(3 downto 0)
		);
	
	output_aux(5 downto 4) <= "00";
	output <= output_aux;
	input_aux <= input;
	sel_aux <= sel;

end;
