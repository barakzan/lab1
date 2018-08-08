library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;
use ieee.numeric_std.all;

entity counter is
	 port ( CLK,RESETN : in std_logic ;
			count : out std_logic_vector(3 downto 0) ) ;
end counter ;


architecture arc_counter of counter is	
begin

	process(CLK,RESETN)
		variable tick_count: integer ;
		begin
			if (RESETN = '1' OR tick_count = 13) then
				count <= (others => '0');
				tick_count := 0;
			else
				tick_count := tick_count + 1;
				count <= std_logic_vector(to_unsigned(tick_count, count'length));	
			end if;				
	end process;

end arc_counter;
