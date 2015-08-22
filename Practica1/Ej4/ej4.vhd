library IEEE;
use IEEE.std_logic_1164.all;

entity ej4 is
	port (
		X: in bit_vector(0 to 3);
		Z: out bit
	);
end;

architecture beh of ej4 is
	signal W1, W2, W3, W4: bit;
begin
	W1 <= X(0);
	W2 <= X(1);
	W3 <= X(2);
	W4 <= X(3);
	process(W1, W2, W3, W4)
	begin
		if (W2 = '1') and (W3 = '0') and (W4 = '0') then
			Z <= '1';
		elsif (W1 = '0') and (W2 = '1') and (W3 = '0') then
			Z <= '1';
		elsif (W1 = '1') and (W2 = '0') and (W3 = '1') then
			Z <= '1';
		elsif (W2 = '0') and (W3 = '1') and (W4 = '0') then
			Z <= '1';
		else
			Z <= '0';
		end if;
	end process;
end;