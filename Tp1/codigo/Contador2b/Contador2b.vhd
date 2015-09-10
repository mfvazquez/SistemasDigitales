library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Contador2b is
	port(
		clk: in std_logic;
		en: in std_logic;
		cuenta: out std_logic_vector(1 downto 0)
	);
	
end;

architecture Contador2b_arq of Contador2b is
begin
	process(clk)
		variable cuenta_aux: unsigned(1 downto 0);
		variable rst: std_logic := '1';
	begin
		if en = '1' and rising_edge(clk) then
			if rst = '1' then
				cuenta_aux := "00";
				rst := '0';
			else
				cuenta_aux := cuenta_aux + 1;
				if cuenta_aux = "11" then
					rst := '1';
				end if;
			end if;
		end if;
		cuenta <= std_logic_vector(cuenta_aux);
	end process;
end;