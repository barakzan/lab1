library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all ;

entity kbd_to_key is
generic ( num_of_keys : 	integer := 7 );
port ( resetN : in std_logic ;
			 clk : in std_logic ;
			 din : in std_logic_vector (8 downto 0);
			 make : in std_logic ;
			 break : in std_logic ;
			 dout : out std_logic_vector (0 to num_of_keys - 1) );
end kbd_to_key;

architecture arc_kbd_to_key of kbd_to_key is
	 type KEY_DATA is array (0 to num_of_keys - 1) of integer;
	 constant keys : KEY_DATA :=
            (52, -- G
             51, -- H
             59, -- J
             66, -- K
				 75, -- L
				 76, -- Double dots
				 82);  -- Coma
	 
 begin
	
	process ( resetN , clk)
	 begin
	 if resetN = '0' then
		 dout <= (others => '0');
	 elsif rising_edge(clk) then
		l_key_chk : for i in 0 to num_of_keys-1 loop
			if din = keys(i) then
				if make = '1' then
					dout(i) <= '1';
				elsif break = '1' then
					dout(i) <= '0';
				end if;
			end if;
		end loop l_key_chk;
	end if;
 end process;
end architecture arc_kbd_to_key;