library IEEE;
use IEEE.std_logic_1164.all;

entity test is
end;

architecture test1 of test is
	signal X_t: bit_vector(0 to 3) := "0000";
	signal Z_t: bit;
	
	component ej4 is
		port (
			X: in bit_vector(0 to 3);
			Z: out bit
		);
	end component;

begin
	inst_ej4: ej4
	port map(
		X => X_t,
		Z => Z_t
	);
	X_t(0) <= not X_t(0) after 10 ns;
	X_t(1) <= not X_t(1) after 20 ns;
	X_t(2) <= not X_t(2) after 40 ns;
	X_t(3) <= not X_t(3) after 80 ns;
end;