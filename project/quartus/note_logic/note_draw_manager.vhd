 library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun July 24 2017 
-- Dudy Nov 13 2017


entity note_draw_manager is
port 	(
		
	   CLK      			: in std_logic;
		RESETn				: in std_logic;
		oCoord_X 			: in integer;
		oCoord_Y 			: in integer;
		timer_done			: in std_logic;
		notes					: in std_logic_vector(0 to 23);
		notes_enable		: in std_logic;
		drawing_request	: out std_logic;
		mVGA_RGB				: out std_logic_vector(7 downto 0) --	,//	VGA composite RGB
	);
end note_draw_manager;

architecture note_draw_manager_arch of note_draw_manager is 

	signal mVGA_R	: std_logic_vector(2 downto 0); --	,	 			//	VGA Red[2:0]
	signal mVGA_G	: std_logic_vector(2 downto 0); --	,	 			//	VGA Green[2:0]
	signal mVGA_B	: std_logic_vector(1 downto 0); --	,  			//	VGA Blue[1:0]
	
	component note_draw is
	port (
	   CLK      			: in std_logic;
		RESETn				: in std_logic;
		start_X				: in std_logic_vector(8 downto 0);
		end_X					: in std_logic_vector(8 downto 0);
		oCoord_X 			: in integer;
		oCoord_Y 			: in integer;
		timer_done			: in std_logic;
		note					: in std_logic;
		notes_enable		: in std_logic;
		drawing_request	: out std_logic
	);
	end component;
	
constant note_width 			: integer := 44;
constant note_gap_width 	: integer := 2;
constant black_pre_width 	: integer := 10;
constant black_post_width 	: integer := 11;

constant start_note1 : integer := 1;
constant end_note1 : integer := start_note1 + note_width;
constant start_note2 : integer := end_note1 + note_gap_width;
constant end_note2 : integer := note_width + start_note2;

constant start_note3 : integer := end_note2 + note_gap_width;
constant end_note3 : integer := note_width + start_note3;
constant start_note4 : integer := end_note3 + note_gap_width;
constant end_note4 : integer := note_width + start_note4;
constant start_note5 : integer := end_note4 + note_gap_width;
constant end_note5 : integer := note_width + start_note5;
constant start_note6 : integer := end_note5 + note_gap_width;
constant end_note6 : integer := note_width + start_note6;
constant start_note7 : integer := end_note6 + note_gap_width;
constant end_note7 : integer := note_width + start_note7;
constant start_note8 : integer := end_note7 + note_gap_width;
constant end_note8 : integer := note_width + start_note8;
constant start_note9 : integer := end_note8 + note_gap_width;
constant end_note9 : integer := note_width + start_note9;
constant start_note10 : integer := end_note9 + note_gap_width;
constant end_note10 : integer := note_width + start_note10;
constant start_note11 : integer := end_note10 + note_gap_width;
constant end_note11 : integer := note_width + start_note11;
constant start_note12 : integer := end_note11 + note_gap_width;
constant end_note12 : integer := note_width + start_note12;
constant start_note13 : integer := end_note12 + note_gap_width;
constant end_note13 : integer := note_width + start_note13;
constant start_note14 : integer := end_note13 + note_gap_width;
constant end_note14 : integer := note_width + start_note14;

constant start_black1 : integer := end_note1 - black_pre_width;
constant end_black1 : integer := start_note2 + black_post_width;
constant start_black2 : integer := end_note2 - black_pre_width;
constant end_black2 : integer := start_note3 + black_post_width;
constant start_black3 : integer := end_note4 - black_pre_width;
constant end_black3 : integer := start_note5 + black_post_width;
constant start_black4 : integer := end_note5 - black_pre_width;
constant end_black4 : integer := start_note6 + black_post_width;
constant start_black5 : integer := end_note6 - black_pre_width;
constant end_black5 : integer := start_note7 + black_post_width;
constant start_black6 : integer := end_note8 - black_pre_width;
constant end_black6 : integer := start_note9 + black_post_width;
constant start_black7 : integer := end_note9 - black_pre_width;
constant end_black7 : integer := start_note10 + black_post_width;
constant start_black8 : integer := end_note11 - black_pre_width;
constant end_black8 : integer := start_note12 + black_post_width;
constant start_black9 : integer := end_note12 - black_pre_width;
constant end_black9 : integer := start_note13 + black_post_width;
constant start_black10 : integer := end_note13 - black_pre_width;
constant end_black10 : integer := start_note14 + black_post_width;
	
	signal notes_request : std_logic_vector(0 to 23);
	
begin

	mVGA_RGB <=  "00011100" ;
	
	drawing_request <= '1' when notes_request > 0 else '0';
	
	note1: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note1, 9)), 
				std_logic_vector(to_unsigned(end_note1, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(0), notes_enable, notes_request(0));
	note2: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black1, 9)), 
				std_logic_vector(to_unsigned(end_black1, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(1), notes_enable, notes_request(1));
	note3: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note2, 9)), 
				std_logic_vector(to_unsigned(end_note2, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(2), notes_enable, notes_request(2));
	note4: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black2, 9)), 
				std_logic_vector(to_unsigned(end_black2, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(3), notes_enable, notes_request(3));
	note5: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note3, 9)), 
				std_logic_vector(to_unsigned(end_note3, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(4), notes_enable, notes_request(4));
	note6: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note4, 9)), 
				std_logic_vector(to_unsigned(end_note4, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(5), notes_enable, notes_request(5));
	note7: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black3, 9)), 
				std_logic_vector(to_unsigned(end_black3, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(6), notes_enable, notes_request(6));
	note8: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note5, 9)), 
				std_logic_vector(to_unsigned(end_note5, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(7), notes_enable, notes_request(7));
	note9: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black4, 9)), 
				std_logic_vector(to_unsigned(end_black4, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(8), notes_enable, notes_request(8));
	note10: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note6, 9)), 
				std_logic_vector(to_unsigned(end_note6, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(9), notes_enable, notes_request(9));
	note11: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black5, 9)), 
				std_logic_vector(to_unsigned(end_black5, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(10), notes_enable, notes_request(10));
	note12: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note7, 9)), 
				std_logic_vector(to_unsigned(end_note7, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(11), notes_enable, notes_request(11));
	note13: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note8, 9)), 
				std_logic_vector(to_unsigned(end_note8, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(12), notes_enable, notes_request(12));
	note14: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black6, 9)), 
				std_logic_vector(to_unsigned(end_black6, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(13), notes_enable, notes_request(13));
	note15: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note9, 9)), 
				std_logic_vector(to_unsigned(end_note9, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(14), notes_enable, notes_request(14));
	note16: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black7, 9)), 
				std_logic_vector(to_unsigned(end_black7, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(15), notes_enable, notes_request(15));
	note17: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note10, 9)), 
				std_logic_vector(to_unsigned(end_note10, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(16), notes_enable, notes_request(16));
	note18: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note11, 9)), 
				std_logic_vector(to_unsigned(end_note11, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(17), notes_enable, notes_request(17));
	note19: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black8, 9)), 
				std_logic_vector(to_unsigned(end_black8, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(18), notes_enable, notes_request(18));
	note20: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note12, 9)), 
				std_logic_vector(to_unsigned(end_note12, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(19), notes_enable, notes_request(19));
	note21: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black9, 9)), 
				std_logic_vector(to_unsigned(end_black9, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(20), notes_enable, notes_request(20));
	note22: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note13, 9)), 
				std_logic_vector(to_unsigned(end_note13, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(21), notes_enable, notes_request(21));
	note23: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_black10, 9)), 
				std_logic_vector(to_unsigned(end_black10, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(22), notes_enable, notes_request(22));
	note24: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note14, 9)), 
				std_logic_vector(to_unsigned(end_note14, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(23), notes_enable, notes_request(23));

end note_draw_manager_arch;	