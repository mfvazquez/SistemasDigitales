library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Serializer is
	port(
		input: in std_logic_vector(3 downto 0);
		display: out std_logic_vector(7 downto 0)
	);
	
end;

architecture Serializer_arq of Serializer is
begin
	process(input)
	begin
		case input is
			when "0000" =>
				display <= "11000000";
			when "0001" =>
				display <= "11111001";
			when "0010" =>
				display <= "10100100";
			when "0011" =>
				display <= "10110000";
			when "0100" =>
				display <= "10011001";
			when "0101" =>
				display <= "10010010";
			when "0110" =>
				display <= "10000010";
			when "0111" =>
				display <= "11111000";
			when "1000" =>
				display <= "10000000";
			when "1001" =>
				display <= "10010000";
			when others =>
				display <= "11111111";
		end case;	
	end process;
end;
