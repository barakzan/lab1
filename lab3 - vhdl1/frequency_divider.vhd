-- Frequency divider
library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;

entity frequency_divider is
	 port ( CLK,RESETN : in std_logic ;
			one_sec_flag : out std_logic ) ;
end frequency_divider ;


architecture arc_frequency_divider of frequency_divider is	
begin
 process(CLK,RESETN)
    variable one_sec: integer ;
--  constant sec: integer := 50000000 ; -- for Real operation 
    constant sec: integer := 5 ; -- for simulation 
 begin
    if RESETN = '0' then
        one_sec := 0 ;
        one_sec_flag <= '0' ;
    elsif rising_edge(CLK) then
        one_sec := one_sec + 1 ;
        if (one_sec > sec) then
            one_sec_flag <= '1' ;
            one_sec := 0;
        else
            one_sec_flag <= '0';
        end if;
    end if;
 end process;

end arc_frequency_divider;
