library ieee ;
use ieee.std_logic_1164.all ;

entity key_detector is
port ( resetN : in std_logic ;
			 clk : in std_logic ;
			 din : in std_logic_vector (8 downto 0);
			 key_code : in std_logic_vector (8 downto 0);
			 make : in std_logic; 
			 pressed : out std_logic );
end key_detector;

architecture arc_key_detector of key_detector is
begin
	process ( resetN , clk)
	 begin
	 if resetN = '0' then
		 pressed <= '0' ;
	 elsif rising_edge(clk) then
		pressed <= '0' ;
		if (din = key_code) and (make = '1' )	then
			pressed <= '1';
		end if;
	end if;
 end process;
end architecture arc_key_detector;