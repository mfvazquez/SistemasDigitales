library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VGA_volt is
	port(
		mclk: in std_logic;
		input: in std_logic_vector(23 downto 0); 
		hs: out std_logic;
		vs: out std_logic;
		red_o: out std_logic_vector(2 downto 0);
		grn_o: out std_logic_vector(2 downto 0);
		blu_o: out std_logic_vector(1 downto 0)
	);	
end;

architecture Beh of VGA_volt is
		
		signal mclk_aux: std_logic;
		signal hs_aux: std_logic;
		signal vs_aux: std_logic;
		signal red_o_aux: std_logic_vector(2 downto 0);
		signal grn_o_aux: std_logic_vector(2 downto 0);
		signal blu_o_aux: std_logic_vector(1 downto 0);
		signal pixel_row_aux: std_logic_vector(9 downto 0);
		signal pixel_col_aux: std_logic_vector(9 downto 0);
		
		signal char_address_aux: std_logic_vector(5 downto 0);
		signal font_row_aux, font_col_aux: std_logic_vector(2 downto 0);
		signal rom_out_aux: std_logic;

		signal input_aux: std_logic_vector(23 downto 0); 
		signal sel_aux: std_logic_vector(2 downto 0);		
		
		
	component vga_ctrl is
		port (
			mclk: in std_logic;
			red_i: in std_logic;
			grn_i: in std_logic;
			blu_i: in std_logic;
			hs: out std_logic;
			vs: out std_logic;
			red_o: out std_logic_vector(2 downto 0);
			grn_o: out std_logic_vector(2 downto 0);
			blu_o: out std_logic_vector(1 downto 0);
			pixel_row: out std_logic_vector(9 downto 0);
			pixel_col: out std_logic_vector(9 downto 0)
		);
	end component;
		
	component Mux is
		port(
			input: in std_logic_vector(23 downto 0); 
			sel: in std_logic_vector(2 downto 0);		
			output: out std_logic_vector(5 downto 0)
		);
	end component;
	
	component Logic is
		port(
			pixel_row, pixel_col: in std_logic_vector(9 downto 0);
			font_row, font_col: out std_logic_vector(2 downto 0);
			sel: out std_logic_vector(2 downto 0)
		);
	end component;
		

	component Char_ROM is
	generic(
		N: integer:= 6;
		M: integer:= 3;
		W: integer:= 8
	);
	port(
		char_address: in std_logic_vector(5 downto 0);
		font_row, font_col: in std_logic_vector(M-1 downto 0);
		rom_out: out std_logic
	);
	end component;
		
begin
	
	input_aux <= input;
	hs <= hs_aux;
	vs <= vs_aux;
	red_o <= red_o_aux;
	grn_o <= grn_o_aux;
	blu_o <= blu_o_aux;
	mclk_aux <= mclk;
	
	inst_vga_ctrl: vga_ctrl
		port map (
			mclk => mclk_aux,
			red_i => rom_out_aux,
			grn_i => rom_out_aux,
			blu_i => '1',
			hs => hs_aux,
			vs => vs_aux,
			red_o => red_o_aux,
			grn_o => grn_o_aux,
			blu_o => blu_o_aux,
			pixel_row => pixel_row_aux,
			pixel_col => pixel_col_aux
		);
		
	inst_Mux: Mux
		port map(
			input => input_aux, 
			sel => sel_aux,		
			output => char_address_aux
		);

	inst_Logic: Logic
		port map(
			pixel_row => pixel_row_aux,
			pixel_col => pixel_col_aux,
			font_row => font_row_aux,
			font_col => font_col_aux,
			sel => sel_aux
		);
	
	inst_Char_ROM: Char_ROM
	port map(
		char_address => char_address_aux,
		font_row => font_row_aux,
		font_col => font_col_aux,
		rom_out => rom_out_aux
	);
	
end;
