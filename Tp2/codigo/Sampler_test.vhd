library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Sampler is
end;

architecture beh of test_Sampler is
	signal clk_t: std_logic := '0';
	signal en_t: std_logic := '1';
	signal out_t: std_logic_vector(11 downto 0);
		
	component Sampler is
		port(
			en: in std_logic;
			clk: in std_logic;
			output: out std_logic_vector(11 downto 0)
		);
	end component;


begin
	inst_Sampler: Sampler
		port map(
			en => en_t,
			clk => clk_t,
			output => out_t
		);
	clk_t <= not clk_t after 10 ns;
	en_t <= not en_t after 90 ns;
end;
