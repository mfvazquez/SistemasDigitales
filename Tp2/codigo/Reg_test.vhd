library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity test_Reg is
end;

architecture Beh of test_Reg is
	signal clk_t: std_logic := '0';
	signal rst_t: std_logic := '1';
	signal en_t: std_logic := '1';
	signal en_bcd_t: std_logic := '1';
	signal input_t: std_logic_vector(11 downto 0);
	signal output_t: std_logic_vector(11 downto 0);

	component Reg is
		port(
			clk: in std_logic;
			en: in std_logic;
			input: in std_logic_vector(11 downto 0);
			output: out std_logic_vector(11 downto 0)
		);	
	end component;

	
	
	component BCD3 is
		port(
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic;
			cuenta: out std_logic_vector(11 downto 0)
		);	
	end component;

begin
	
	inst_Reg: Reg
	port map(
			clk => clk_t,
			en => en_t,
			input => input_t,
			output => output_t
	);


	inst_BCD3: BCD3
	port map(
		clk => clk_t,
		rst => rst_t,
		en => en_bcd_t,
		cuenta => input_t
	);

	clk_t <= not clk_t after 10 ns;
	rst_t <= '0' after 50 ns;
	en_t <= not en_t after 100 ns;
end;
