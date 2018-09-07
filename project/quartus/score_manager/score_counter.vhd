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
		hit						:  IN std_logic;
		score0					:  out std_logic_vector(3 downto 0);
		score1					:  out std_logic_vector(3 downto 0);
		score2					:  out std_logic_vector(3 downto 0)		
	);
		
END score_counter;

ARCHITECTURE score_counter_arch OF score_counter IS
signal low_score  : std_logic_vector(3 downto 0);
signal mid_score  : std_logic_vector(3 downto 0);
signal high_score : std_logic_vector(3 downto 0);
begin
	score0 <= low_score;
	score1 <= mid_score;
	score2 <= high_score;

	process(clk, resetN)
	 begin
		if resetN = '0' then
			low_score <= (others => '0');
			mid_score <= (others => '0');
			high_score <= (others => '0');		
		elsif rising_edge(clk) and hit = '1' then
			if low_score = "1001" then
				low_score <= (others => '0');	
				if mid_score = "1001" then
					mid_score <= (others => '0');	
					if high_score = "1001" then
						high_score <= "1001";
					else
						high_score <= high_score + 1;
					end if;	
				else
					mid_score <= mid_score + 1;
				end if;	
			else
				low_score <= low_score + 1;
			end if;
		end if;
	end process;

end score_counter_arch;