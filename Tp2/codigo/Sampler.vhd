library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Sampler is
	port(
		en: in std_logic;
		clk: in std_logic;
		out_aux: out std_logic_vector(11 downto 0);
		output: out std_logic_vector(11 downto 0)
	);
end;

architecture Beh of Sampler is
	signal out1_aux: std_logic;
	signal out2_aux: std_logic;
	signal clk_aux: std_logic;
	signal en_aux: std_logic;
	signal input_aux: std_logic_vector(11 downto 0);
	signal output_aux: std_logic_vector(11 downto 0);

	component BCD3 is
		port(
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic;
			cuenta: out std_logic_vector(11 downto 0)
		);	
	end component;

	component Reg is
		port(
			clk: in std_logic;
			en: in std_logic;
			input: in std_logic_vector(11 downto 0);
			output: out std_logic_vector(11 downto 0)
		);	
	end component; 
	
	component CounterNb is
	port(
		clk: in std_logic;
		out1: out std_logic;
		out2: out std_logic
	);
	end component;
	
begin
	clk_aux <= clk;
	en_aux <= en;
	output <= output_aux;
	out_aux <= input_aux;
	
	inst_CounterNb: CounterNb
		port map(
			clk => clk_aux,
			out1 => out1_aux,
			out2 => out2_aux
	);
		
	inst_BCD3: BCD3
	port map(
		clk => clk_aux,
		rst => out2_aux,
		en => en_aux,
		cuenta => input_aux
	);
	
	inst_Reg: Reg
	port map(
			clk => clk_aux,
			en => out1_aux,
			input => input_aux,
			output => output_aux
	);
	
end;
