library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Counter is
end;


architecture test_Counter of test_Counter is
	signal	clk_t: std_logic := '0';
	signal	rst_t: std_logic := '1';
	signal display_t: std_logic_vector(7 downto 0);
	signal sel_display_t: std_logic_vector(3 downto 0);
	
	component Counter is
		port(
			clk: in std_logic;
			rst: in std_logic;
			sel_display: out std_logic_vector(3 downto 0);
			display: out std_logic_vector(7 downto 0)
		);
	end component;

begin
	inst_Counter: Counter
		port map(
			clk => clk_t,
			rst => rst_t,
			sel_display => sel_display_t,
			display => display_t
		);
	rst_t <= '0' after 20 ns;
	clk_t <= not clk_t	after 10 ns;
end;