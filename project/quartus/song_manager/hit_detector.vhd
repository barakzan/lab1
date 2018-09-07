 LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all ;


ENTITY hit_detector IS
PORT
	(
		resetN					:	IN  STD_LOGIC;	
		clk 						:  IN	 STD_LOGIC;
		enable					:  IN  STD_LOGIC;
		keyboard_notes			:  in  std_logic_vector(0 to 23);
		song_notes				:  in  std_logic_vector(0 to 23);
		hit						:  out  STD_LOGIC
	);
		
END hit_detector;

ARCHITECTURE hit_detector_arch OF hit_detector IS
	signal hits : std_logic_vector(4 downto 0);
begin

	process(clk, resetN)
		variable hits_counter : std_logic_vector(4 downto 0);
	 begin
		if resetN = '0' then
			hits_counter := (others => '0');
			hits <= (others => '0');
			hit <= '0';
		elsif rising_edge(clk) then
			hit <= '0';
			if enable = '1' then	
				hits_counter := (others => '0');
				cnt : for i in 0 to 23 loop
					if keyboard_notes(i) = song_notes(i) and song_notes(i) = '1' then
						hits_counter := hits_counter + 1;
					end if;
				end loop cnt;
				hits <= hits_counter;
			else	
				if hits /= "00000" then
					hits <= hits - 1;
					hit <= '1';
				end if;
			end if;
		end if;
	end process;
	
end hit_detector_arch;