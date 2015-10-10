library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter is
	port(
		clk: in std_logic;
		rst: in std_logic;
		sel_display: out std_logic_vector(3 downto 0);
		display: out std_logic_vector(7 downto 0)
	);
	
	attribute loc: string;
	
	attribute loc of clk:	signal is "B8";
	attribute loc of rst:	signal is "B18";
	attribute loc of sel_display: signal is "F15 C18 H17 F17";
	attribute loc of display:	signal is "C17 H14 J17 G14 D16 D17 F18 L18";
	
end;

architecture Beh of Counter is
	signal	clk_aux: std_logic;
	signal	rst_aux: std_logic;
	signal  en_aux: std_logic_vector(4 downto 0);
	signal  bcd_aux: std_logic_vector(15 downto 0);
	signal  sel_display_aux: std_logic_vector(3 downto 0);
	signal	display_aux: std_logic_vector(7 downto 0);

	component BCD is
		port(
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic;
			cuenta: out std_logic_vector(3 downto 0);
			flag: out std_logic
		);	
	end component;

	component DisplayController is
		port(
			clk: in std_logic;
			bcd: in std_logic_vector(15 downto 0);
			sel_display: out std_logic_vector(3 downto 0);
			display: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component GenEna is
	generic(
		N: natural := 25;
		M: natural := 2
	);
	port(
		clk: in std_logic;
		en: out std_logic
	);
	end component;

begin
	clk_aux <= clk;
	rst_aux <= rst;
	display <= display_aux;
	sel_display <= sel_display_aux;
	
	inst_GenEna: GenEna
		port map(
			clk => clk_aux,
			en => en_aux(0)
		);
	
	bcd_i : 
	for i in 0 to 3 generate
       	
       	inst_BCD: BCD
		port map(
			clk => clk_aux,
			rst => rst_aux,
			en => en_aux(i),
			cuenta => bcd_aux(i*4+3 downto i*4),
			flag => en_aux(i+1)
		);
		
    end generate;

	inst_DisplayController: DisplayController
		port map(
			clk => clk_aux,
			bcd => bcd_aux,
			sel_display => sel_display_aux,
			display => display_aux
		);

end;
