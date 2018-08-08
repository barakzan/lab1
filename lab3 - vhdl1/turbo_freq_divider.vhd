-- Frequency divider
library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;

entity turbo_freq_divider is
	 port ( CLK,RESETN : in std_logic ;
			  TURBO : in std_logic;
			one_sec_flag : out std_logic ) ;
end turbo_freq_divider  ;


architecture arc_turbo_freq_divider of turbo_freq_divider is	
begin
 process(CLK,RESETN)
    variable one_sec: integer ;
--  constant sec: integer := 50000000 ; -- for Real operation 
    constant sec: integer := 20 ; -- for simulation 
	 variable max : integer;
 begin
    if RESETN = '0' then
        one_sec := 0 ;
        one_sec_flag <= '0' ;
    elsif rising_edge(CLK) then
        one_sec := one_sec + 1 ;
		  
		  if (TURBO = '1') then
				max := sec / 10;
		  else
				max := sec;
		  end if;
		  
        if (one_sec >= max) then
            one_sec_flag <= '1' ;
            one_sec := 0;
        else
            one_sec_flag <= '0';
        end if;
    end if;
 end process;

end arc_turbo_freq_divider ;
