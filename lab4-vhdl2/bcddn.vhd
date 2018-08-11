
--bcddn 

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;


entity bcddn is
	 port ( Clk,ena,resetN,LoadN : in std_logic ;
			Data : in std_logic_vector(7 downto 0) ;
			CountL,CountH : out std_logic_vector(3 downto 0) ;
			TC : out std_logic ) ;
end bcddn ;

architecture arc_bcddn of bcddn is	 
 signal cntL,cntH : std_logic_vector(3 downto 0) ;
begin
	process(Clk,resetN)
	 begin
		if rising_edge(CLK) then
			if (resetN = '0') then	--reset
				cntL <= (others => '0');
				cntH <= (others => '0');
			elsif (LoadN = '0') then	--LoadN
				cntL <= Data (3 downto 0) ;
				cntH <= Data (7 downto 4) ;
			else
				if ena = '1' then
					if cntL = 0 then
						cntL <= "1001" ;
						if cntH = 0 then
							cntH <= "1001" ;
						else
							cntH <= cntH - 1 ;
						end if;
					else
						cntL <= cntL - 1 ;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	CountL <= cntL ;
	CountH <= cntH ;
	
	process(cntH, cntL)
	 begin
		if( cntL = 0  and cntH = 0 and ena = '1') then
			TC <= '1' ;
		else
			TC <= '0' ;
		end if;
	end process;
end arc_bcddn;