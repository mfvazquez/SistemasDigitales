library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplicadorPF is
     generic(	
		N: integer := 23;	--Cantidad de bits
		E: integer := 6	--bits del exponente
	);					
     port(
		A: in std_logic_vector(N-1 downto 0 );
		B: in std_logic_vector(N-1 downto 0 );
		R: out std_logic_vector(N-1 downto 0 )
     );
end;
		
architecture multiplicadorPF_arch of multiplicadorPF is
	
	constant bias: integer:= 2**(E-1)-1;
	constant M: integer := N - E - 1;
	begin
	
	process( A , B )
		variable mult: unsigned(2*M+1 downto 0);
		variable exp: integer;
		variable Rs: std_logic;
		variable Rm: std_logic_vector(M-1 downto 0);
		begin
		
		Rs := (A(N-1) xor B(N-1));
		
		exp := to_integer(unsigned(A(N-2 downto M))) + to_integer(unsigned(B(N-2 downto M))) - bias;
		
		-- MULTIPLICACION UTILIZANDO *
		mult := unsigned('1'&A(M-1 downto 0 )) * unsigned('1'&B(M-1 downto 0));
		
		-- MULTIPLICACION UTILIZANDO EL MULTIPLICADOR
		
		if(mult(2*M+1) = '1') then
			exp := exp + 1;
			Rm := std_logic_vector(mult(2*M downto M+1));
		else
			Rm := std_logic_vector(mult(2*M-1 downto M));
		end if;
		
		if (exp > 2*bias) then
			exp := 2*bias;
			Rm := (others => '1');
		elsif (exp <= 0) then
			Rs :='0';
			exp := 0;
			Rm := (others => '0');
		end if;
		
		R(N-1) <= Rs;
		R(N-2 downto M) <= std_logic_vector(to_unsigned(exp, E));	
		R(M-1 downto 0) <= Rm;
		
		
	end process;

end multiplicadorPF_arch;
