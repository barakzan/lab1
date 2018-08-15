library ieee ;
use ieee.std_logic_1164.all ;

entity LEFT_SHIFT is
port ( resetN : in std_logic ;
			 clk : in std_logic ;
			 din : in std_logic_vector (8 downto 0);
			 key_code : in std_logic_vector (8 downto 0);
			 make : in std_logic ;
			 break : in std_logic ;
			 dout : out std_logic );
end LEFT_SHIFT;

architecture arc_LEFT_SHIFT of LEFT_SHIFT is
type press_state is(pressed, not_pressed);
	 signal state: press_state;
	 signal out_led: std_logic;
	 
 begin
	
 dout <= '1' when state = pressed else '0';
	
	process ( resetN , clk)
	 begin
	 if resetN = '0' then
		 state <= not_pressed ;
	 elsif rising_edge(clk) then
		if (din = key_code) and (make = '1' )	then
			state <= pressed;
		elsif (din = key_code) and (break = '1' ) then
			state <= not_pressed;
		end if;
	end if;
 end process;
end architecture arc_LEFT_SHIFT;