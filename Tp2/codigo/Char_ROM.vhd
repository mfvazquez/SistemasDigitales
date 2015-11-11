library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Char_ROM is
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
end;

architecture p of Char_ROM is
	subtype tipoLinea is std_logic_vector(0 to W-1);

	type char is array(0 to W-1) of tipoLinea;
	constant Cero: char:= (
								"00011100",
								"00110110",
								"01100011",
								"01101011",
								"01100011",
								"00110110",
								"00011100",
								"00000000"
						);
	constant Uno: char:= (
								"00001100",
								"00111100",
								"00001100",
								"00001100",
								"00001100",
								"00001100",
								"00111111",
								"00000000"
						);
	constant Dos: char:= (
								"00111110",
								"01100011",
								"00000110",
								"00001100",
								"00011000",
								"00110000",
								"01111111",
								"00000000"
						);

	constant Tres: char:= (
								"01111111",
								"00000110",
								"00001100",
								"00000110",
								"00000011",
								"01100110",
								"00111100",
								"00000000"
						);
	constant Cuatro: char:= (
								"00000110",
								"00001110",
								"00010110",
								"00100110",
								"01111111",
								"00000110",
								"00000110",
								"00000000"
						);
	constant Cinco: char:= (
								"01111111",
								"01100000",
								"01111110",
								"00000011",
								"00000011",
								"01100110",
								"00111100",
								"00000000"
						);
	constant Seis: char:= (
								"00000110",
								"00001100",
								"00110000",
								"01100000",
								"01111110",
								"01000011",
								"00111100",
								"00000000"
						);
	constant Siete: char:= (
								"01111111",
								"00000110",
								"00001100",
								"00011000",
								"00110000",
								"01100000",
								"01100000",
								"00000000"
						);
	constant Ocho: char:= (
								"00111110",
								"01100011",
								"01100011",
								"01111111",
								"01100011",
								"01100011",
								"00111110",
								"00000000"
						);
	constant Nueve: char:= (
								"00111110",
								"01100011",
								"00111110",
								"00000110",
								"00000110",
								"00011000",
								"01100000",
								"00000000"
						);
	constant Punto: char:= (
								"00000000",
								"00000000",
								"00000000",
								"00000000",
								"00000000",
								"00011000",
								"00011000",
								"00000000"
						);
	constant V: char:= (
								"10000001",
								"10000001",
								"01000010",
								"01000010",
								"00100100",
								"00100100",
								"00011000",
								"00000000"
						);					
	constant Espacio: char:= (
								"00000000",
								"00000000",
								"00000000",
								"00000000",
								"00000000",
								"00000000",
								"00000000",
								"00000000"
						);	

	type memo is array(0 to 255) of tipoLinea;
	signal RAM: memo:= (
								0 => Cero(0), 1 => Cero(1), 2 => Cero(2), 3 => Cero(3), 4 => Cero(4), 5 => Cero(5), 6 => Cero(6), 7 => Cero(7),
								8 => Uno(0), 9 => Uno(1), 10 => Uno(2), 11 => Uno(3), 12 => Uno(4), 13 => Uno(5), 14 => Uno(6), 15 => Uno(7),
								16 => Dos(0), 17 => Dos(1), 18 => Dos(2), 19 => Dos(3), 20 => Dos(4), 21 => Dos(5), 22 => Dos(6), 23 => Dos(7),
								24 => Tres(0), 25 => Tres(1), 26 => Tres(2), 27 => Tres(3), 28 => Tres(4), 29 => Tres(5), 30 => Tres(6), 31 => Tres(7),
								32 => Cuatro(0), 33 => Cuatro(1), 34 => Cuatro(2), 35 => Cuatro(3), 36 => Cuatro(4), 37 => Cuatro(5), 38 => Cuatro(6), 39 => Cuatro(7),
								40 => Cinco(0), 41 => Cinco(1), 42 => Cinco(2), 43 => Cinco(3), 44 => Cinco(4), 45 => Cinco(5), 46 => Cinco(6), 47 => Cinco(7),
								48 => Seis(0), 49 => Seis(1), 50 => Seis(2), 51 => Seis(3), 52 => Seis(4), 53 => Seis(5), 54 => Seis(6), 55 => Seis(7),
								56 => Siete(0), 57 => Siete(1), 58 => Siete(2), 59 => Siete(3), 60 => Siete(4), 61 => Siete(5), 62 => Siete(6), 63 => Siete(7),
								64 => Ocho(0), 65 => Ocho(1), 66 => Ocho(2), 67 => Ocho(3), 68 => Ocho(4), 69 => Ocho(5), 70 => Ocho(6), 71 => Ocho(7),
								72 => Nueve(0), 73 => Nueve(1), 74 => Nueve(2), 75 => Nueve(3), 76 => Nueve(4), 77 => Nueve(5), 78 => Nueve(6), 79 => Nueve(7),
								80 => Punto(0), 81 => Punto(1), 82 => Punto(2), 83 => Punto(3), 84 => Punto(4), 85 => Punto(5), 86 => Punto(6), 87 => Punto(7),
								88 => V(0), 89 => V(1), 90 => V(2), 91 => V(3), 92 => V(4), 93 => V(5), 94 => V(6), 95 => V(7),
								96 => Espacio(0), 97 => Espacio(1), 98 => Espacio(2), 99 => Espacio(3), 100 => Espacio(4), 101 => Espacio(5), 102 => Espacio(6), 103 => Espacio(7),
								104 to 255 => "00000000"
							);

	signal char_addr_aux: std_logic_vector(8 downto 0);
	
begin

	char_addr_aux <= char_address & font_row;
	rom_out <= RAM(conv_integer(char_addr_aux))(conv_integer(font_col));

end;