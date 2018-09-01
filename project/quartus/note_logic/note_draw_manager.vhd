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
		notes					: in std_logic_vector(0 to 6);
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
	
	constant start_note1 : integer := 6;
	constant end_note1 : integer := 27;
	constant start_note2 : integer := end_note1 + 3;
	constant end_note2 : integer := 27 + start_note2;
	constant start_note3 : integer := end_note2 + 3;
	constant end_note3 : integer := 27 + start_note3;
	constant start_note4 : integer := end_note3 + 3;
	constant end_note4 : integer := 27 + start_note4;
	constant start_note5 : integer := end_note4 + 3;
	constant end_note5 : integer := 27 + start_note5;
	constant start_note6 : integer := end_note5 + 3;
	constant end_note6 : integer := 27 + start_note6;
	constant start_note7 : integer := end_note6 + 3;
	constant end_note7 : integer := 27 + start_note7;
	constant start_note8 : integer := end_note7 + 3;
	constant end_note8 : integer := 27 + start_note8;
	constant start_note9 : integer := end_note8 + 3;
	constant end_note9 : integer := 27 + start_note9;
	constant start_note10 : integer := end_note9 + 3;
	constant end_note10 : integer := 27 + start_note10;
	constant start_note11 : integer := end_note10 + 3;
	constant end_note11 : integer := 27 + start_note11;
	constant start_note12 : integer := end_note11 + 3;
	constant end_note12 : integer := 27 + start_note12;
	constant start_note13 : integer := end_note12 + 3;
	constant end_note13 : integer := 27 + start_note13;
	constant start_note14 : integer := end_note13 + 3;
	constant end_note14 : integer := 27 + start_note14;
	constant start_note15 : integer := end_note14 + 3;
	constant end_note15 : integer := 27 + start_note15;
	constant start_note16 : integer := end_note15 + 3;
	constant end_note16 : integer := 27 + start_note16;
	constant start_note17 : integer := end_note16 + 3;
	constant end_note17 : integer := 27 + start_note17;
	constant start_note18 : integer := end_note17 + 3;
	constant end_note18 : integer := 27 + start_note18;
	constant start_note19 : integer := end_note18 + 3;
	constant end_note19 : integer := 27 + start_note19;
	constant start_note20 : integer := end_note19 + 3;
	constant end_note20 : integer := 27 + start_note20;
	constant start_note21 : integer := end_note20 + 3;
	constant end_note21 : integer := 27 + start_note21;
	constant start_note22 : integer := end_note21 + 3;
	constant end_note22 : integer := 27 + start_note22;
	
	constant start_black1 : integer := end_note1 - 5;
	constant end_black1 : integer := start_note2 + 6;
	constant start_black2 : integer := end_note2 - 5;
	constant end_black2 : integer := start_note3 + 6;
	constant start_black3 : integer := end_note4 - 5;
	constant end_black3 : integer := start_note5 + 6;
	constant start_black4 : integer := end_note5 - 5;
	constant end_black4 : integer := start_note6 + 6;
	constant start_black5 : integer := end_note6 - 5;
	constant end_black5 : integer := start_note7 + 6;
	constant start_black6 : integer := end_note8 - 5;
	constant end_black6 : integer := start_note9 + 6;
	constant start_black7 : integer := end_note9 - 5;
	constant end_black7 : integer := start_note10 + 6;
	constant start_black8 : integer := end_note11 - 5;
	constant end_black8 : integer := start_note12 + 6;
	constant start_black9 : integer := end_note12 - 5;
	constant end_black9 : integer := start_note13 + 6;
	constant start_black10 : integer := end_note13 - 5;
	constant end_black10 : integer := start_note14 + 6;
	constant start_black11 : integer := end_note15 - 5;
	constant end_black11 : integer := start_note16 + 6;
	constant start_black12 : integer := end_note16 - 5;
	constant end_black12 : integer := start_note17 + 6;
	constant start_black13 : integer := end_note18 - 5;
	constant end_black13 : integer := start_note19 + 6;
	constant start_black14 : integer := end_note19 - 5;
	constant end_black14 : integer := start_note20 + 6;
	constant start_black15 : integer := end_note20 - 5;
	constant end_black15 : integer := start_note21 + 6;
	
	signal notes_request : std_logic_vector(0 to 6);
	
begin

	mVGA_RGB <=  "00011100" ;
	
	drawing_request <= '1' when notes_request > 0 else '0';
	
	note1: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note8, 9)), 
				std_logic_vector(to_unsigned(end_note8, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(0), notes_enable, notes_request(0));
	note2: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note9, 9)), 
				std_logic_vector(to_unsigned(end_note9, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(1), notes_enable, notes_request(1));
	note3: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note10, 9)), 
				std_logic_vector(to_unsigned(end_note10, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(2), notes_enable, notes_request(2));
	note4: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note11, 9)), 
				std_logic_vector(to_unsigned(end_note11, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(3), notes_enable, notes_request(3));
	note5: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note12, 9)), 
				std_logic_vector(to_unsigned(end_note12, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(4), notes_enable, notes_request(4));
	note6: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note13, 9)), 
				std_logic_vector(to_unsigned(end_note13, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(5), notes_enable, notes_request(5));
	note7: note_draw port map (CLK, RESETn, std_logic_vector(to_unsigned(start_note14, 9)), 
				std_logic_vector(to_unsigned(end_note14, 9)), 
				oCoord_X, oCoord_Y, timer_done, notes(6), notes_enable, notes_request(6));

end note_draw_manager_arch;	