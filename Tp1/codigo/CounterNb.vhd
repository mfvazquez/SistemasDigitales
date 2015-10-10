library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CounterNb is
	generic(
		N: natural := 2
		);
	port(
		clk: in std_logic;
		en: in std_logic;
		cuenta: out std_logic_vector(N-1 downto 0)
	);
end;

architecture Beh of CounterNb is
begin
	process(clk)
		variable cuenta_aux: unsigned(N-1 downto 0) := (others => '0');
		variable comparador: unsigned(N-1 downto 0) := (others => '1');
		variable rst: std_logic := '0';
	begin
		if en = '1' and rising_edge(clk) then
			if rst = '1' then
				cuenta_aux := (others => '0');
				rst := '0';
			else
				cuenta_aux := cuenta_aux + 1;
				if cuenta_aux = comparador then
					rst := '1';
				end if;
			end if;
		end if;
		cuenta <= std_logic_vector(cuenta_aux);
	end process;
end;
