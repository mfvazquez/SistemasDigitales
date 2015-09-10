library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Contador2b is
end;

architecture test_Contador2b of test_Contador2b is
	signal clk_t: std_logic := '0';
	signal en_t: std_logic := '1';
	signal cuenta_t: std_logic_vector(1 downto 0);	
	
	component Contador2b is
		port (
		clk: in std_logic;
		en: in std_logic;
		cuenta: out std_logic_vector(1 downto 0)
		);
	end component;

begin
	inst_Contador2b: Contador2b
		port map(
			clk => clk_t,
			en => en_t,
			cuenta => cuenta_t
		);
	clk_t <= not clk_t after 10 ns;
end;