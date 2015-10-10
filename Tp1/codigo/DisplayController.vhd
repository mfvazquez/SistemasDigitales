library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DisplayController is
	port(
		clk: in std_logic;
		bcd: in std_logic_vector(15 downto 0);
		sel_display: out std_logic_vector(3 downto 0);
		display: out std_logic_vector(7 downto 0)
	);
end;

architecture Beh of DisplayController is
	signal	clk_aux: std_logic;
	signal 	en_aux: std_logic;
	signal 	sel_aux: std_logic_vector(1 downto 0);
	signal 	bcd_out_aux: std_logic_vector(3 downto 0);
	signal	sel_display_aux: std_logic_vector(3 downto 0);
	signal	display_aux: std_logic_vector(7 downto 0);
	signal  input_mux_aux: std_logic_vector(15 downto 0);
	
	component GenEna is
		generic(
			N: natural := 17;
			M: natural := 1
				);
		port(
			clk: in std_logic;
			en: out std_logic
		);
	end component;
	
	component CounterNb is
		generic(
			N: natural := 2
			);
		port(
			clk: in std_logic;
			en: in std_logic;
			cuenta: out std_logic_vector(N-1 downto 0)
		);
	end component;
	
	component Mux is
		generic(
			inputs: natural := 16;
			data_bus: natural := 4;
			sel_length: natural := 2
		);
		port(
			input: in std_logic_vector(inputs-1 downto 0); 
			sel: in std_logic_vector(sel_length-1 downto 0);		
			output: out std_logic_vector(data_bus-1 downto 0)
		);
	end component;
	
	component Selector is
		generic(
			N: natural := 2;
			M: natural := 4
		);
		port(
			sel: in std_logic_vector(N-1 downto 0);
			output: out std_logic_vector(M-1 downto 0)
		);
	end component;
	
	component Serializer is
		port (
			input: in std_logic_vector(3 downto 0);
			display: out std_logic_vector(7 downto 0)
		);
	end component;

begin
	clk_aux <= clk;
	input_mux_aux <= bcd;
	display <= display_aux;
	sel_display	<= sel_display_aux;
	
	inst_GenEna: GenEna
		generic map(
			N => 17,
			M => 1
		)
		port map(
			clk => clk_aux,
			en => en_aux
		);
	
	inst_CounterNb: CounterNb
		port map(
			clk => clk_aux,
			en => en_aux,
			cuenta => sel_aux
		);
	
	inst_Mux: Mux
		port map(
			input => input_mux_aux,
			sel => sel_aux,		
			output => bcd_out_aux
		);
		
	inst_Selector: Selector
		port map(
			sel => sel_aux,
			output => sel_display_aux
		);

		
	inst_Serializer: Serializer
		port map(
			input => bcd_out_aux,
			display => display_aux
		);
end;
