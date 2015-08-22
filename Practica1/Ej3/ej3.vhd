library IEEE;
use IEEE.std_logic_1164.all;

entity ej3 is
	port(
		X1: in std_logic;
		X2: in std_logic;
		X3: in std_logic;
		X4: in std_logic;
		Y: out std_logic
	);
end ej3;

architecture ej3_arq of ej3 is
begin
	Y <= (X2 and not X3 and not X4) or (not X1 and not X3 and X4) or (X1 and not X2 and X3) or (not X2 and X3 and not X4);
end;
