 library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun July 24 2017 
-- Dudy Nov 13 2017


entity note_draw is
port 	(
		
	   CLK      			: in std_logic;
		RESETn				: in std_logic;
		start_X				: in std_logic_vector(9 downto 0);
		end_X					: in std_logic_vector(9 downto 0);
		oCoord_X 			: in integer;
		oCoord_Y 			: in integer;
		timer_done			: in std_logic;
		note					: in std_logic;
		notes_enable		: in std_logic;
		drawing_request	: out std_logic
	);
end note_draw;

architecture note_draw_arch of note_draw is 
	
	constant PIXELS_FOR_NOTES	: integer := 380;
	constant PIXELS_PER_CELL	: integer := 10;
	constant PIXELS_PER_RENDER	: integer := 0; --2;
	constant array_size 			: integer := PIXELS_FOR_NOTES / PIXELS_PER_CELL ;
	
begin

	process ( oCoord_X,oCoord_Y )
	
	variable note_pos : std_logic_vector(0 to array_size - 1);
	variable index : integer;
	variable render_counter : integer;
	
	begin 
		
		if RESETn = '0' then
			drawing_request <= '0';
			render_counter := 0;
			note_pos := (others => '0');
		elsif rising_edge(clk) then
			drawing_request <= '0';
			
			if timer_done = '1' then
				render_counter := render_counter + PIXELS_PER_RENDER;
			end if;
			
			if notes_enable = '1' then
				render_counter := 0;
				note_pos(1 to array_size - 1) := note_pos(0 to array_size - 2);
				note_pos(0) := note;
			end if;
			
			if (oCoord_X > start_x AND oCoord_X < end_x) then
				
				index := (oCoord_Y - render_counter) / PIXELS_PER_CELL;
				
				if note_pos(index) = '1' then
					if oCoord_Y >= PIXELS_FOR_NOTES then
						note_pos(index) := '0';
					else
						drawing_request <= '1';
					end if;
				end if;
			end if;

		end if;
		
	end process ; 
end note_draw_arch;	

