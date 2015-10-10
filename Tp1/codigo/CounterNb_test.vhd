library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_CounterNb is
end;

architecture beh of test_CounterNb is
	signal clk_t: std_logic := '0';
	signal en_t: std_logic := '1';
	signal cuenta_t: std_logic_vector(3 downto 0);	
	
	component CounterNb is
		generic(
			N: natural := 2
		);
		port (
			clk: in std_logic;
			en: in std_logic;
			cuenta: out std_logic_vector(N-1 downto 0)
		);
	end component;

begin
	inst_CounterNb: CounterNb
		generic map(
			N => 4
		)
		port map(
			clk => clk_t,
			en => en_t,
			cuenta => cuenta_t
		);
	clk_t <= not clk_t after 10 ns;
end;
