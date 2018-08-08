library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;
use ieee.numeric_std.all;

entity counter is
	 port ( CLK,RESETN : in std_logic ;
			count : out std_logic_vector(3 downto 0) ) ;
end counter ;


architecture arc_counter of counter is	

 signal tick_count : std_logic_vector(3 downto 0) ;

begin
	process(CLK,RESETN)
		begin
		if rising_edge(CLK) then
			if (RESETN = '0' or unsigned(tick_count) = 13) then
				tick_count <= (others => '0');	
			else
				tick_count <= std_logic_vector(unsigned(tick_count) + 1);		
			end if;
		end if;
	end process;
	
	count <= tick_count ;

end arc_counter;
