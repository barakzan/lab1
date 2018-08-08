-- HEX to Seven-Segment (active low) – vector out 
library ieee ; 
use ieee.std_logic_1164.all ; 

entity hexss is    
port ( din : in  std_logic_vector(3 downto 0) ;     
		 blinkN : in std_logic ;
		 lamp_test : in std_logic;
 	    ss  : out std_logic_vector(6 downto 0) ); 
  --    ADD additional signals 
end hexss ; 

architecture arc_hexss of hexss is	
begin
		process(blinkN, lamp_test)
		begin
			if lamp_test = '1' then
				ss <= (others => '0');
			elsif blinkN = '0' then
				ss <= (others => '1');
			else
				case din is
					when "0000" => ss <= "1000000"; -- 0
					when "0001" => ss <= "1111001"; -- 1
					when "0010" => ss <= "0100100"; -- 2
					when "0011" => ss <= "0110000"; -- 3
					when "0100" => ss <= "0011001"; -- 4
					when "0101" => ss <= "0010010"; -- 5
					when "0110" => ss <= "0000010"; -- 6
					when "0111" => ss <= "1111000"; -- 7
					when "1000" => ss <= "0000000"; -- 8
					when "1001" => ss <= "0010000"; -- 9
					when "1010" => ss <= "0001000"; -- A
					when "1011" => ss <= "0000011"; -- B
					when "1100" => ss <= "1000110"; -- C
					when "1101" => ss <= "0100001"; -- D
					when "1110" => ss <= "0000110"; -- E
					when "1111" => ss <= "0001110"; -- F
					when others => ss <= (others => '1');
				end case;
			end if;
		end process;
end arc_hexss;