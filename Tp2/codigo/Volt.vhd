library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VOLT is
	port(
		clk50: in std_logic;
		data_volt_in_p,data_volt_in_n: in std_logic;
		data_volt_out: out std_logic;
		hs: out std_logic;
		vs: out std_logic;
		red_o: out std_logic_vector(2 downto 0);
		grn_o: out std_logic_vector(2 downto 0);
		blu_o: out std_logic_vector(1 downto 0)
	);
		   	 
	attribute loc: string;
	attribute slew: string;
	attribute drive: string;
	attribute iostandard: string;
	attribute loc of clk50:	signal is "B8";

	attribute iostandard of data_volt_in_p: signal is "LVDS_25";	
	attribute loc of data_volt_in_p: signal is "N18";
	attribute iostandard of data_volt_in_n: signal is "LVDS_25";	
	attribute loc of data_volt_in_n: signal is "M18";

	attribute loc of data_volt_out: signal is "P18";
	attribute slew of data_volt_out: signal is "FAST";
	attribute drive of data_volt_out: signal is "8";
	attribute iostandard of data_volt_out: signal is "LVCMOS25";	
	
	attribute loc of hs: signal is "T4";
	attribute loc of vs: signal is "U3";
	attribute loc of red_o: signal is "R8 T8 R9";
	attribute loc of grn_o: signal is "P6 P8 N8";
	attribute loc of blu_o: signal is "U4 U5";

-- Mapeo de pines para el kit spartan 3E
--   attribute loc of clk50: signal is "T9";
--   attribute loc of hs: signal is "R9";
 --  attribute loc of vs: signal is "T10";
  -- attribute loc of red_o: signal is "R12";
   --attribute loc of grn_o: signal is "T12";
--   attribute loc of blu_o: signal is "R11";

end VOLT;

architecture beh of VOLT is

--	component GenEna
--		generic(
--			N: natural := 1;
--			M: natural := 1
--		);
--		port(
--			clk: in std_logic;
--			en: out std_logic
--		);
--	end component;


	component IBUFDS 
		port(
			I : in std_logic; 
			IB : in std_logic; 
			O : out std_logic
		); 
	end component; 

	-- declaracion de los demas componentes
	
	component FFD is
		port(
			clk: in std_logic;
			rst: in std_logic;
			ena: in std_logic;
			D: in std_logic;
			Q: out std_logic
		);
	end component;
	
	component Process_and_controll is
		port (
			en: in std_logic;
			clk: in std_logic;
			hs: out std_logic;
			vs: out std_logic;
			red_o: out std_logic_vector(2 downto 0);
			grn_o: out std_logic_vector(2 downto 0);
			blu_o: out std_logic_vector(1 downto 0)
		);
	end component;
   
	signal Diff_Input: std_logic;
	signal process_in: std_logic;
	
	-- declaracion de las demas señales
       
begin
	ibuf0: IBUFDS port map(
		I => data_volt_in_p,
		IB => data_volt_in_n,
		O => Diff_Input
	);
	
	inst_flop: FFD 
		port map(
			clk => clk50,
			rst =>'0',
			ena => '1',
			D => Diff_Input,
			Q => process_in
		);
	
	inst_proces: Process_and_controll port map(process_in, clk50, hs, vs, red_o, grn_o, blu_o);
--	inst_genEna: GenEna
--		generic map(
--		N => 1,
--		M => 1
--		)
--		port map(
--			clk => clk50, 
--			en => process_in
--		);

	data_volt_out <= process_in;
	
end;