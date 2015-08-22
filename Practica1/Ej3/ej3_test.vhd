library IEEE;
use IEEE.std_logic_1164.all;

entity test is
end;

architecture test1 of test is
	signal X1_t: std_logic := '0';
	signal X2_t: std_logic := '0';
	signal X3_t: std_logic := '0';
	signal X4_t: std_logic := '0';
	signal Y_t: std_logic;
	
	component ej3 is
		port (
			X1: in std_logic;
			X2: in std_logic;
			X3: in std_logic;
			X4: in std_logic;
			Y: out std_logic
		);
	end component;

begin
	inst_ej3: ej3
		port map(
			X1 => X1_t,
			X2 => X2_t,
			X3 => X3_t,
			X4 => X4_t,
			Y => Y_t
		);
	X1_t <= not X1_t after 10 ns;
	X2_t <= not X2_t after 20 ns;
	X3_t <= not X3_t after 40 ns;
	X4_t <= not X4_t after 80 ns;	
end;