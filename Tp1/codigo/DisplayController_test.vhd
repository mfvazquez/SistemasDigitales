library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_DisplayController is
end;


architecture test_DisplayController of test_DisplayController is
	signal	clk_t: std_logic := '0';
	signal	bcd_t: std_logic_vector(15 downto 0);
	signal display_t: std_logic_vector(7 downto 0);
	signal sel_display_t: std_logic_vector(3 downto 0);
	signal cuenta_aux: unsigned(15 downto 0) := B"0000_0000_0000_0000";
	
	component DisplayController is
		port (
			clk: in std_logic;
			bcd: in std_logic_vector(15 downto 0);
			sel_display: out std_logic_vector(3 downto 0);
			display: out std_logic_vector(7 downto 0)
		);
	end component;

begin
	inst_DisplayController: DisplayController
		port map(
			clk => clk_t,
			bcd => bcd_t,
			sel_display => sel_display_t,
			display => display_t
		);
	clk_t <= not clk_t	after 10 ns;
	bcd_t <= std_logic_vector(cuenta_aux);	
	cuenta_aux <= (cuenta_aux + 1) after 10 ms;
end;
