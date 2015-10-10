library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux is
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
	
end;

architecture Beh of Mux is
begin
	process(sel, input)
	variable sel_aux: unsigned(sel_length-1 downto 0);
	variable fin, inicio: natural;
	begin
		sel_aux := unsigned(sel);
		inicio := to_integer(sel_aux);
		inicio := inicio * data_bus;
		fin := inicio + data_bus - 1;

		output <= input(fin downto inicio);
	end process;
end;
