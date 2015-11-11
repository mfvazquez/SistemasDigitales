library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Process_and_controll is
	port(
		en: in std_logic;
		clk: in std_logic;
		hs: out std_logic;
		vs: out std_logic;
		red_o: out std_logic_vector(2 downto 0);
		grn_o: out std_logic_vector(2 downto 0);
		blu_o: out std_logic_vector(1 downto 0)
	);
end;

architecture Beh of Process_and_controll is

	signal en_aux: std_logic;
	signal clk_aux: std_logic;
	signal output_aux: std_logic_vector(11 downto 0);
	signal input_aux: std_logic_vector(23 downto 0); 
	signal hs_aux: std_logic;
	signal vs_aux: std_logic;
	signal red_o_aux: std_logic_vector(2 downto 0);
	signal grn_o_aux: std_logic_vector(2 downto 0);
	signal blu_o_aux: std_logic_vector(1 downto 0);

	component Sampler is
		port(
			en: in std_logic;
			clk: in std_logic;
			output: out std_logic_vector(11 downto 0)
		);	
	end component;
	
	component VGA_volt is	
		port(
			mclk: in std_logic;
			input: in std_logic_vector(23 downto 0); 
			hs: out std_logic;
			vs: out std_logic;
			red_o: out std_logic_vector(2 downto 0);
			grn_o: out std_logic_vector(2 downto 0);
			blu_o: out std_logic_vector(1 downto 0)
		);
	end component;
	
begin

	en_aux <= en;
	clk_aux <= clk;
	hs <= hs_aux;
	vs <= vs_aux;
	red_o <= red_o_aux;
	grn_o <= grn_o_aux;
	blu_o <= blu_o_aux;
	
	input_aux(11 downto 0) <= output_aux;
	input_aux(15 downto 12) <= "1010"; -- direccion en memoria del caracter: '.' 
	input_aux(19 downto 16) <= "1011"; -- direccion en memoria del caracter: 'V'
	input_aux(23 downto 20) <= "1100"; -- direccion en memoria del caracter: ' '
	
	inst_Sampler: Sampler
		port map(
			en => en_aux,
			clk => clk_aux,
			output => output_aux
		);
		
	inst_VGA_volt: VGA_volt
		port map(
			mclk => clk_aux,
			input => input_aux,
			hs => hs_aux,
			vs => vs_aux,
			red_o => red_o_aux,
			grn_o => grn_o_aux,
			blu_o => blu_o_aux
		);
	
end;
