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
		out_enable				:	out std_logic;
		duration					:  out std_logic_vector(11 downto 0);
		hits						:  out std_logic_vector(11 downto 0)
	);
		
END hit_detector;

ARCHITECTURE hit_detector_arch OF hit_detector IS
begin

	process(clk)
		constant SILENCE : std_logic_vector(0 to 23) := (others => '0');
		variable duration_counter : std_logic_vector(11 downto 0);
		variable hits_counter : std_logic_vector(11 downto 0);
		variable last_notes : std_logic_vector(0 to 11);
	begin
		if resetN = '0' then
			duration_counter := (others => '0');
			hits_counter := (others => '0');
			last_notes := (others => '0');
			hits <= (others => '0');
			duration <= (others => '0');
			out_enable <= '0';
		elsif rising_edge(clk) then
			out_enable <= '0';
			if enable = '1' then
				if last_notes = song_notes then
					if song_notes /= SILENCE then
						duration_counter := duration_counter + 1;
					end if;
				else				-- song_notes /= last_notes
					hits <= hits_counter;
					duration <= duration_counter;
					out_enable <= '1';
				
					last_notes := song_notes;
					hits_counter := (others => '0');
					if song_notes /= SILENCE then
						duration_counter := "000000000001";
					else
						duration_counter := (others => '0');
					end if;
				end if;
				
				if keyboard_notes = song_notes AND song_notes /= SILENCE then
					hits_counter := hits_counter + 1;
				end if;
			end if;
		end if;
	end process;

end hit_detector_arch;