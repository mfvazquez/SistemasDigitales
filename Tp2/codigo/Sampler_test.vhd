library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Sampler is
end;

architecture beh of test_Sampler is
	signal clk_t: std_logic := '0';
	signal en_t: std_logic;
	signal out_t: std_logic_vector(11 downto 0);
	signal out_aux_t: std_logic_vector(11 downto 0);
		
	component Sampler is
		port(
			en: in std_logic;
			clk: in std_logic;
			out_aux: out std_logic_vector(11 downto 0);
			output: out std_logic_vector(11 downto 0)
		);
	end component;
	
	component GenEna
		generic(
			N: natural := 2;
			M: natural := 1
		);
		port(
			clk: in std_logic;
			en: out std_logic
		);
	end component;


begin
	inst_Sampler: Sampler
		port map(
			en => en_t,
			clk => clk_t,
			out_aux => out_aux_t,
			output => out_t
		);
		
	inst_genEna: GenEna
		generic map(
			N => 2,
			M => 1
		)
		port map(
			clk => clk_t, 
			en => en_t
		);

	clk_t <= not clk_t after 10 ns;
end;
