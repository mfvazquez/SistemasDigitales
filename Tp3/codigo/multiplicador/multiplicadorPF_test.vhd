library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplicadorPF_test is
end multiplicadorPF_test;

architecture multiplicadorPF_test_arch of multiplicadorPF_test is
	component multiplicadorPF is
     generic(
	 	N: integer := 23;	--Cantidad de bits
		E: integer := 6	--bits del exponente
	);					
     port(
		A: in std_logic_vector(N-1 downto 0 );
		B: in std_logic_vector(N-1 downto 0 );
		R: out std_logic_vector(N-1 downto 0 )
     );
	end component;
	
	signal A_t: std_logic_vector( 22 downto 0 ) := B"1_111110_1111111111001010";
	signal B_t: std_logic_vector( 22 downto 0 ) := B"0_011111_0000011011011100"; 
	signal R_t: std_logic_vector( 22 downto 0 ); 
	
	begin										
		inst_multiplicadorPF: multiplicadorPF 
			generic map(
				N => 23,
				E => 6
			) 
			port map(
				A => A_t,
				B => B_t,
				R => R_t
			 );
		
end multiplicadorPF_test_arch;