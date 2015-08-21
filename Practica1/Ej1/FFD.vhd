library IEEE;
use IEEE.std_logic_1164.all;

entity FFD is
	port(
		clk: in std_logic;
		rst: in std_logic;
		ena: in std_logic;
		D: in std_logic;
		Q: out std_logic
	);
end FFD;

architecture beh of ffd is
begin
	process(clk, rst)
	begin
		if rst = '1' then
			Q <= '0';
		elsif rising_edge(clk) then
			if ena = '1' then 
				Q <= D;
			end if;
		end if;
	end process;
end beh;
