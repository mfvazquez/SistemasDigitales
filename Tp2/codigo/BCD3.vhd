library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity BCD3 is
	port(
		clk: in std_logic;
		rst: in std_logic;
		en: in std_logic;
		cuenta: out std_logic_vector(11 downto 0)
	);	
end;

architecture Beh of BCD3 is
	
	signal clk_aux: std_logic;
	signal rst_aux: std_logic;
	signal en_aux: std_logic_vector(3 downto 0);
	signal bcd_aux: std_logic_vector(11 downto 0);
	
	component BCD is
		port(
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic;
			cuenta: out std_logic_vector(3 downto 0);
			flag: out std_logic
		);	
	end component;
	
begin

	en_aux(0) <= en;
	clk_aux <= clk;
	rst_aux <= rst;
	cuenta <= bcd_aux;

	bcds_3: 
	for i in 0 to 2 generate
       	
       	inst_BCD: BCD
		port map(
			clk => clk_aux,
			rst => rst_aux,
			en => en_aux(i),
			cuenta => bcd_aux(i*4+3 downto i*4),
			flag => en_aux(i+1)
		);
		
    end generate;

end;
