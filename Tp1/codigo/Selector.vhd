library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Selector is
	generic(
		N: natural := 2;
		M: natural := 4
	);
	port(
		sel: in std_logic_vector(N-1 downto 0);
		output: out std_logic_vector(M-1 downto 0)
	);
end;

architecture Beh of Selector is
begin
	process(sel)
		variable sel_aux: natural;
	begin
		sel_aux := to_integer(unsigned(sel));
		output <= (others => '1');
		output(sel_aux) <= '0';		
	end process;
end;
