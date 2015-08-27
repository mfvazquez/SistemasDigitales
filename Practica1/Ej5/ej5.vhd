library IEEE;
use IEEE.std_logic_1164.all;

entity ej5 is
	port(
		x1: in std_logic;
		x2: in std_logic;
		y1: inout std_logic;
		y2: inout std_logic;
		z: out std_logic
	);
end ej5;

architecture ej5_arc of ej5 is
	signal y1_aux, y2_aux: std_logic;
begin
	y1_aux <= (y1 and not x1) or (x1 and y2);
	y2_aux <= (not x1 and x2) or (x1 and y2);
	y1 <= y1_aux;
	y2 <= y2_aux;
	z <= y1_aux;
end;
