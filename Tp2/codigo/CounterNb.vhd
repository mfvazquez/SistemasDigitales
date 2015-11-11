library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CounterNb is
	generic(
		N: natural := 14;
		M: natural := 1
			);
	port(
		clk: in std_logic;
		out1: out std_logic := '0';
		out2: out std_logic := '0'
	);
end;

architecture Beh of CounterNb is
begin
	process(clk)
		variable cuenta: unsigned(N downto 0);
		variable comparador: unsigned(M-1 downto 0) := (others => '1');
		variable rst: std_logic := '1';
		variable out_rst: unsigned(1 downto 0) := "10";
	begin
		if rising_edge(clk) then
			if out_rst = "01" then
				out1 <= '0';
				out_rst := "10";
			elsif out_rst = "10" then
				out2 <= '1';
				out_rst := "11";
			elsif out_rst = "11" then
				out2 <= '0';
				out_rst := "00";
			else
				cuenta := cuenta + 1;
				if rst = '1' then
					cuenta := (others => '0');
					rst := '0';
					out_rst := "01";
					out1 <= '1';
				elsif comparador = cuenta(N downto N+1-M) then
					rst := '1';
				end if;		
			end if;
		end if;
	end process;
end;
