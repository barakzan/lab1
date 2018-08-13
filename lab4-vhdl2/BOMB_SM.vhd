library ieee ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity BOMB_SM is
	port ( 	clk:	in 	std_logic;
		resetN:		in 	std_logic;
		START:		in 	std_logic;
		WaitX:  	in	std_logic; --X addeed as "wait" might be a reserved word 
		OneHzPulse:	in	std_logic;  -- a narrow pulse every second 
 		Tc: 		in	std_logic;   --counter terminal count 
		
		CounterEnable:  out	std_logic;  --enable('1')/disable('0')  
		CounterLoadN:  out	std_logic;  --/load ('0')  
		LampEnable: 	out	std_logic ); -- on('1') off('0')
end BOMB_SM;

architecture arc_BOMB_SM of BOMB_SM is 
  type state_type is (idle, arm, run, pause, lamp_on, lamp_off); --enumerated type for state machine
  signal state : state_type;
begin

    process (clk, resetN)
	 variable sec_trigger: integer ;
	 variable sec_indicator: integer ;
    begin
        if resetN = '0' then
            state <= idle;
				CounterLoadN <= '1' ;
				CounterEnable <= '0';
				LampEnable <= '0';
	     elsif (rising_edge(clk)) then
	   -- preset all outputs ,override in the state machine if needed  
	   		CounterLoadN <= '1' ;
				CounterEnable <= '0';
				LampEnable <= '0';
			--  fill other commands ;
	   
			if OneHzPulse = '1' AND sec_indicator = 0 then
				sec_indicator := 1;
				sec_trigger := 1;
			elsif OneHzPulse = '0' then
				sec_indicator := 0;
			end if;
		
            -- Determine the next state synchronously, based on
            -- the current state and the input
			case state is
                when idle=>
                    if start = '1' then
                        state <= arm;
								CounterLoadN <= '0' ;
                    end if;
					 when arm =>
						  if start = '0' then
								state <= run;
								CounterEnable <= '1';
						  end if;
                when run=>
						  if WaitX = '1' then
								state <= pause;
								CounterEnable <= '0';
						  elsif Tc = '1' then
							   state <= lamp_on;
								sec_trigger := 0;								
						  else
								CounterEnable <= '1';
						  end if;
                when pause => --..... to operate 3sec timer
						  if WaitX = '0' then
								state <= run;
								CounterEnable <= '1';
						  end if;
                when lamp_on => --.... to operate 1sec timer
						  if sec_trigger = 1 then
								LampEnable <= '0';
								state <= lamp_off;
						  else
								LampEnable <= '1';
						  end if;
						  
						  sec_trigger := 0;
                when lamp_off => --..... to operate 1sec timer
						  if sec_trigger = 1 then
								LampEnable <= '1';
								state <= lamp_on;
						  else
								LampEnable <= '0';
						  end if;
						  
						  sec_trigger := 0;
         end case; 
        end if;
    end process;
end arc_BOMB_SM ; 

