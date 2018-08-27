 LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all ;


ENTITY score_counter IS
PORT
	(
		resetN					:	IN  STD_LOGIC;	
		clk 						:  IN	 STD_LOGIC;
		enable					: 	IN	 STD_LOGIC;
		duration					:  IN std_logic_vector(9 downto 0);
		hits						:  IN std_logic_vector(9 downto 0);
		score						:  out std_logic_vector(9 downto 0)
	);
		
END score_counter;

ARCHITECTURE score_counter_arch OF score_counter IS
signal in_score : std_logic_vector(9 downto 0);
begin

	score <= in_score;

	process(clk)
	begin
		if resetN = '0' then
			in_score <= (others => '0');
		elsif rising_edge(clk) and enable = '1' then
			in_score <= in_score + hits;
		end if;
	end process;

end score_counter_arch;