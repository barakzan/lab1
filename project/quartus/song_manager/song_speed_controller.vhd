LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY song_speed_controller IS
GENERIC ( COUNT_SIZE		: INTEGER := 23);
PORT (
			clk				:	IN	STD_LOGIC;	
			resetN			:	IN	STD_LOGIC;
			up					: 	in  std_logic ;
			down				: 	in  std_logic ;
			freq				: 	out std_logic_vector(COUNT_SIZE - 1 downto 0)
		);

END song_speed_controller;

architecture song_speed_controller_arch of song_speed_controller is

constant array_size 			: integer := 5;
type table_type is array(0 to array_size - 1) of std_logic_vector(COUNT_SIZE - 1 downto 0);
signal speed_table				: table_type;

signal freq_out : std_logic_vector(COUNT_SIZE - 1 downto 0);
begin

	freq <= freq_out;

	process(clk, resetN)

	constant speed_table : table_type := (
		std_logic_vector(to_unsigned(5000000, COUNT_SIZE)), -- 10   hz
		std_logic_vector(to_unsigned(4000000, COUNT_SIZE)), -- 12.5 hz
		std_logic_vector(to_unsigned(3333333, COUNT_SIZE)), -- 15   hz
		std_logic_vector(to_unsigned(2857143, COUNT_SIZE)), -- 17.5 hz
		std_logic_vector(to_unsigned(2500000, COUNT_SIZE))  -- 20   hz
		);
	variable index : integer;
	
	begin
		if resetN = '0' then
			index := 0;
			freq_out <= speed_table(index);
		elsif rising_edge(clk) then
			if up = '1' AND down = '0' then 		-- up pressed
				if index < (array_size - 1) then
					index := index + 1;
				end if;
			elsif up = '0' AND down = '1' then  -- down pressed
				if index > 0 then
					index := index - 1;
				end if;
			end if;
			
			freq_out <= speed_table(index);
		end if;
	end process;

end song_speed_controller_arch;