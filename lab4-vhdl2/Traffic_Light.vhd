--Traffic_Light 

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;


entity Traffic_Light is
	 port ( clk,resetN,SwitchN,TurboN : in std_logic ;
			  Red,Yellow,Green : out std_logic) ;
end Traffic_Light ;

architecture arc_Traffic_Light of Traffic_Light is	
 type count_state is(redState, redYellowState, greenState, yellowState); 
 signal State : count_state;
 signal MyClk : std_logic;
 
begin
--internal clock
	process(Clk, resetN)	
		constant TurboSize : integer := 10 ;
		--constant frequencyDivider : integer := 2500000 ;
		constant frequencyDivider : integer := 20 ;
		variable cnt : integer ;	 
	 begin
		if rising_edge(CLK) then
			if resetN = '0' then			
				MyClk <= '0' ;
				cnt := 0;
			else
				if TurboN = '0' then
					cnt := cnt + TurboSize;
				else
					cnt := cnt + 1 ;
				end if;
				if cnt >= frequencyDivider then
					cnt := cnt - frequencyDivider;
					MyClk <= not MyClk;
				end if;
			end if;
		end if;
	end process;
	
	process(MyClk, resetN)
		constant redTime : integer := 37 ;
		constant greenTime : integer := 29 ;
		constant middleTime : integer := 15 ;
		variable count : integer ;
	 begin
		if resetN = '0' then
			count := 0;
			State <= redState;
		elsif rising_edge(MyClk) then
			count := count + 1;
			case State is 
				when redState =>	
					if (count >= redTime) OR (SwitchN = '0') then
						count := 0;
						State <= redYellowState;
					end if;
				when redYellowState =>
					if count >= middleTime then
						count := 0;
						State <= greenState;
					end if;
				when greenState =>
					if count >= greenTime then
						count := 0;
						State <= yellowState;
					end if;
				when yellowState =>
					if count >= middleTime then
						count := 0;
						State <= redState;
					end if;
			end case;
		end if;
	end process;
	
	Red <= '0' when State = redState  or State = redYellowState else '1';
	Yellow <= '0' when State = yellowState  or State = redYellowState else '1';
	Green <= '0' when State = greenState else '1';
	
end arc_Traffic_Light;
