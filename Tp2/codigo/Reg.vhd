library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity Reg is
	port(
		clk: in std_logic;
		en: in std_logic;
		input: in std_logic_vector(11 downto 0);
		output: out std_logic_vector(11 downto 0)
	);	
end;

architecture Beh of Reg is

begin

	process(clk, en)
	begin
		if rising_edge(clk) and en = '1' then
			output <= input;
		end if;
	end process;

end;
