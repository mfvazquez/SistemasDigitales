library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity test is
end entity test;

architecture simulacion of test is
	
	signal R: std_logic_vector(31 downto 0);
	
	component sumadorPF is
	generic(	
		N: integer := 23;	--Cantidad de bits
		E: integer := 6	--bits del exponente
	);					
	port(
		A: in std_logic_vector(N-1 downto 0 );
		B: in std_logic_vector(N-1 downto 0 );
		R_out: out std_logic_vector(N-1 downto 0 )
	 );
	end component;
	
begin
		
	sum: sumadorPF
	generic map(	
		N => 32,	--Cantidad de bits
		E => 8		--bits del exponente
	)			
	port map(
		A => "00111110110000000000000000000000",
		B => "01000010110010000000000000000000",
		R_out => R -- el resultado deberia ser 0_10000101_10010001100000000000000
	 );

end architecture simulacion; 
