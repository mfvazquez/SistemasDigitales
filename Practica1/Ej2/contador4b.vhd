library IEEE;
use IEEE.std_logic_1164.all;

entity contador4b is
	port(
		clk: in std_logic;
		rst: in std_logic;
		Q0: out std_logic;
		Q1: out std_logic;
		Q2: out std_logic;
		Q3: out std_logic
	);
	
end contador4b;

architecture contador4b_arq of contador4b is
	signal D2, D3, Q0_aux,Q1_aux, Q2_aux, Q3_aux: std_logic;
	component FFD is
		port(
			clk: in std_logic;
			rst: in std_logic;
			ena: in std_logic;
			D: in std_logic;
			Q: out std_logic
		);
	end component;
	component contador2b is
		port(
			clk: in std_logic;
			rst: in std_logic;
			Q0: out std_logic;
			Q1: out std_logic
		);
	end component;
	
begin
	contador2b0: contador2b port map(
		clk => clk,
		rst => rst,
		Q0 => Q0_aux,
		Q1 => Q1_aux
	);
	
	FFD2: FFD port map(
		clk => clk,
		rst => rst,
		ena => '1',
		D  => D2,
		Q  => Q2_aux
	);
	FFD3: FFD port map(
		clk => clk,
		rst => rst,
		ena => '1',
		D => D3,
		Q => Q3_aux
	);
	D2 <= (Q0_aux and Q1_aux and not Q2_aux) or (not Q0_aux and Q2_aux) or (not Q1_aux and Q2_aux);
	D3 <= (not Q2_aux and Q3_aux) or (not Q0_aux and Q3_aux) or (not Q1_aux and Q3_aux) or (Q0_aux and Q1_aux and Q2_aux and not Q3_aux);
	
	Q0 <= Q0_aux;
	Q1 <= Q1_aux;
	Q2 <= Q2_aux;
	Q3 <= Q3_aux;
end;
