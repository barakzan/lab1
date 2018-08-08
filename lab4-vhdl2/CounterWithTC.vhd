library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;
use ieee.numeric_std.all;

entity CounterWithTC is
	 port ( CLK,RESETN,LOAD : in std_logic ;
			Qin : in std_logic_vector(3 downto 0) ;
			Q : out std_logic_vector(3 downto 0) ;
			TC : out std_logic ) ;
end CounterWithTC ;

architecture arc_CounterWithTC of CounterWithTC is	
 signal Qtemp : std_logic_vector(3 downto 0) ;
begin
	process(CLK,RESETN)
	 begin
		if rising_edge(CLK) then
			if (RESETN = '0') then	--reset
				Qtemp <= (others => '0');
			elsif (LOAD = '1') then	--LOAD Qin
				Qtemp <= Qin ;
			elsif (unsigned(Qtemp) = 8) then --8 (restat)
				Qtemp <= (others => '0');
			elsif (unsigned(Qtemp) = 4 or unsigned(Qtemp) = 5 ) then --skip 4 and 5
				Qtemp <= std_logic_vector(to_unsigned(7,Qtemp'length));
			else
				Qtemp <= std_logic_vector(unsigned(Qtemp) + 1) ;	--inc		
			end if;
		end if;
	end process;
	
	Q <= Qtemp ;
	
	process(Qtemp)
	 begin
		if( Qtemp = 8 ) then
			TC <= '1' ;
		else
			TC <= '0' ;
		end if;
	end process;
end arc_CounterWithTC;
