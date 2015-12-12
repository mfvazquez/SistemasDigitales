library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Logic is
	port(
		pixel_row, pixel_col: in std_logic_vector(9 downto 0);
		font_row, font_col: out std_logic_vector(2 downto 0);
		sel: out std_logic_vector(2 downto 0)
	);
end;

architecture Beh of Logic is 
begin
	process(pixel_row, pixel_col)
		variable col, col_aux, fila, fila_aux, char_col, char_fila: unsigned(9 downto 0);
		variable pixel_col_aux, pixel_fila_aux: unsigned(2 downto 0);
	begin
		col := unsigned(pixel_col);
		fila := unsigned(pixel_row);
		col_aux := col mod 8;
		fila_aux := fila mod 8;
		char_col := col/8;
		char_fila := fila/8;
		
		pixel_col_aux := col_aux(2 downto 0);
		pixel_fila_aux := fila_aux(2 downto 0);
		font_row <= std_logic_vector(pixel_fila_aux);
		font_col <= std_logic_vector(pixel_col_aux);
		
		if char_fila = 30 then
			if char_col = 38 then
				sel <= "000";	-- (0) digito mas significativo
			elsif char_col = 39 then
				sel <= "011";	-- (3) punto
			elsif char_col = 40 then
				sel <= "001";	-- (1) primer decimal
			elsif char_col = 41 then
				sel <= "010";	-- (2) segundo decimal
			elsif char_col = 42 then
				sel <= "100";	-- (4) V
			else
				sel <= "101";	-- (5) espacio
			end if;
		else
			sel <= "101";		-- (5) espacio		
		end if;
	end process;
end;
