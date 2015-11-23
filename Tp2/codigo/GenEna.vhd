library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GenEna is
	generic(
		N: natural := 1;
		M: natural := 1
			);
	port(
		clk: in std_logic;
		en: out std_logic
	);
end;

architecture Beh of GenEna is
begin
	process(clk)
		variable cuenta: unsigned(N downto 0);
		variable comparador: unsigned(M-1 downto 0) := (others => '1');
		variable rst: std_logic := '1';
	begin
		if rising_edge(clk) then
			cuenta := cuenta + 1;
			if rst = '1' then
				cuenta := (others => '0');
				en <= '1';
				rst := '0';
			elsif comparador = cuenta(N downto N+1-M) then
				en <= '0';
				rst := '1';
			end if;		
		end if;
	end process;
end;

