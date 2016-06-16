library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sumadorPF is
     generic(	
		N: integer := 23;	--Cantidad de bits
		E: integer := 6	--bits del exponente
	);					
     port(
		A: in std_logic_vector(N-1 downto 0 );
		B: in std_logic_vector(N-1 downto 0 );
		R_out: out std_logic_vector(N-1 downto 0 )
     );
end;
		
architecture sumadorPF_arch of sumadorPF is
	
	constant bias: integer:= 2**(E-1)-1;
	constant M: integer := N - E - 1;
	begin
	
	process( A , B )
		variable As, Bs, Rs, Cout, g, r, s: std_logic;
		variable Swap, Compl: std_logic;
		variable Ae, Be, Re, c: integer;
		variable Am, Bm, Rm, Sp: unsigned(M downto 0);
		variable Sp_aux: unsigned(M+1 downto 0);
		-- Las variables R es donde guardaré el resultado en el ultimo paso, 
		-- en los anteriores son usados como variables auxiliares
	begin
		
		-- obtengo datos
		As := A(N-1);
		Ae := to_integer(unsigned(A(N-2 downto M))) - bias;
		Am := unsigned('1'&A(M-1 downto 0));

		Bs := B(N-1);
		Be := to_integer(unsigned(B(N-2 downto M))) - bias;
		Bm := unsigned('1'&B(M-1 downto 0));
		
		-- PASO 1: si Ae < Be intercambiar los operados y guardo Ae en Re
		
		Swap := '0';
		if (Ae < Be) then
			Swap := '1';
			Rs := As;
			Re := Ae;
			Rm := Am;
			
			As := Bs;
			Ae := Be;
			Am := Bm;
			
			Bs := Rs;
			Be := Re;
			Bm := Rm;
		end if;
		
		Re := Ae;
		-- PASO 2: Si los signos son distintos reemplazo Bm por su complemento a 2
		
		Rs := As xor Bs;
		if (Rs = '1') then
			Bm := (not Bm) + 1;
		end if;
		
		-- PASO 3: corro Bm a derecha una cantidad igual a la diferencia de los exponentes
		c := Ae-Be;
		
		Rm := Bm srl c;		
		if (Rs = '1') then 
			Rm(M downto M+1-c) := (others => '1');
		end if;
		
		-- los flags g r y s estan en Bm(c-1 downto 0)
		if (c > N) then
			c := N;
		end if;
		g := '0';
		r := '0';
		s := '0';
		if (c > 0) then
			g := Bm(c-1);
		end if;
		if (c > 1) then
			r := Bm(c-2);
		end if;
		if (c > 2) then
			s := '1';
			if (Bm(c-3 downto 0) = 0) then
				s := '0';
			end if;
		end if;
		
		-- PASO 4: calculo del significand preliminar
		Sp_aux := ('0'&Am) + ('0'&Rm);
		Sp := Sp_aux(M downto 0);
		Cout := Sp_aux(M+1);
		
		Compl := '0';
		if (Rs = '1' and Sp(M) = '1' and Cout = '0') then
			Compl := '1';
			Sp := (not Sp) + 1;
		end if;
		
		-- PASO 5 y 6: desplazar Sp

		if (Rs = '0' and Cout = '1') then
			r := Sp(0);
			s := '0';
			if (g = '1' or r = '1' or s = '1') then
				s := '1';
			end if;
			Sp := Sp srl 1;
			Sp(M) := '1';
			Re := Re + 1;
		
		elsif (Sp(M) = '0' and (Rs = '1' or Cout = '0')) then
			Sp := Sp sll 1;
			Re := Re - 1;
			Sp(0) := g;
			if (Sp /= 0) then
				while (Sp(M) = '0') loop
					Sp := Sp sll 1;
					Re := Re - 1;
					r := '0';
					s := '0';
				end loop;
			end if;
		
		else
			r := g;
			s := '0';
			if (r = '1' or s = '1') then 
				s := '1';
			end if;
		end if;

		
	-- PASO 7: Redondear Sp utilizando la tabla de modos de redondeo
	
	--	Cout := '0';
--		if (r = '1' or s='1') then
--			Sp_aux := ('0'&Sp) + 1;
--			Sp := Sp_aux(M downto 0);
--			Cout := Sp_aux(M+1);
--		if ((r = '1' and Bm(0) = '1') or (r='1' and s = '1')) then
--			Sp_aux := ('0'&Sp) + 1;
--			Sp := Sp_aux(M downto 0);
--			Cout := Sp_aux(M+1);
--		end if;
		
--		if (Cout = '1') then
--			Sp := Sp srl 1;
--			Sp(M) := '1';
--			Re := Re - 1;
--		end if;
		if (Re+bias < 0) then
			Sp := (others => '0');
		end if;
		
		-- PASO 8: Determino el signo del resultado
		if (As = Bs) then
			Rs := As;
		elsif ((Sp = 0) or (Swap = '1' and As = '0' and Bs = '1') or (Swap = '0' and Compl = '0' and As = '0' and Bs = '1') or (Swap = '0' and Compl = '1' and As = '1' and Bs = '0')) then
			Rs := '0';
		elsif ((Swap = '1' and As = '1' and Bs = '0') or (Swap = '0' and Compl = '0' and As = '1' and Bs = '0') or (Swap = '0' and Compl = '1' and As = '0' and Bs = '1')) then
			Rs := '1';
		end if;
				
		-- PASO FINAL: Armo el vector del resultado.
		
		R_out(N-1) <= Rs;
		Re := Re + bias;
		if (Sp = 0) then
			Re := 0;
		end if;
		R_out(N-2 downto M) <= std_logic_vector(to_unsigned(Re, E));
		R_out(M-1 downto 0) <= std_logic_vector(Sp(M-1 downto 0));
	
		--report "A = "&integer'image(to_integer(Am))&"Swap="&std_logic'image(Swap)&" Compl="&std_logic'image(Compl);
	
	end process;

end sumadorPF_arch;
