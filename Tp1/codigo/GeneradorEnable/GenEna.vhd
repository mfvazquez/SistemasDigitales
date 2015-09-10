library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GenEna is
	port(
		clk: in std_logic;
		cuenta_aux: out std_logic_vector(25 downto 0);
		en: out std_logic
	);
	
end;

architecture GenEna_arq of GenEna is
begin
	process(clk)
		variable cuenta: unsigned(25 downto 0);
		variable rst: std_logic := '1';
	begin
		if rst = '1' and rising_edge(clk) then
			cuenta := B"00_0000_0000_0000_0000_0000_0000";
			en <= '0';
			rst := '0';
		end if;		
		if rising_edge(clk) then
			cuenta := cuenta + 1;
			if cuenta(25) = '1' and cuenta(24) = '1' then
				en <= '1';
				rst := '1';
			end if;
		end if;
	cuenta_aux <= std_logic_vector(cuenta);
	end process;
end;
