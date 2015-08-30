library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BCD is
	port(
		clk: in std_logic;
		rst: in std_logic;
		en: in std_logic;
		cuenta: out std_logic_vector(3 downto 0);
		flag: out std_logic
	);
	
end;

architecture BCD_arq of BCD is

begin
	process(clk, rst)
		variable aux: unsigned(3 downto 0);
	begin
		if rst = '1' then
			aux := "0000";
		elsif rising_edge(clk) then
			if en = '1' then
				aux := aux + 1;
				if aux = "1001" then
					flag <= '1';
				elsif aux = "1010" then
					flag <= '0';
					aux := "0000";
				else
					flag <= '0';
				end if;
			end if;
		end if;
		cuenta <= std_logic_vector(aux);
	end process;
end;