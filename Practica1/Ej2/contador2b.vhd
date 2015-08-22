library IEEE;
use IEEE.std_logic_1164.all;

entity contador2b is
	port(
		clk: in std_logic;
		rst: in std_logic;
		Q0: out std_logic;
		Q1: out std_logic
	);
	
end contador2b;

architecture contador2b_arq of contador2b is
	signal D0, D1, Q0_aux, Q1_aux: std_logic;
	component FFD is
		port(
			clk: in std_logic;
			rst: in std_logic;
			ena: in std_logic;
			D: in std_logic;
			Q: out std_logic
		);
	end component;
	
begin
	FFD0: FFD port map(
		clk => clk,
		rst => rst,
		ena => '1',
		D  => D0,
		Q  => Q0_aux
	);
	FFD1: FFD port map(
		clk => clk,
		rst => rst,
		ena => '1',
		D => D1,
		Q => Q1_aux
	);
	D0 <= not Q0_aux;
	D1 <= Q1_aux xor Q0_aux;
	Q0 <= Q0_aux;
	Q1 <= Q1_aux;
end contador2b_arq;
