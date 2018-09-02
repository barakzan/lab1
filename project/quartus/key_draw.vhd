 library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun July 24 2017 
-- Dudy Nov 13 2017


entity key_draw is
port 	(
		
	   CLK      			: in std_logic;
		RESETn				: in std_logic;
		oCoord_X 			: in integer;
		oCoord_Y 			: in integer;
		keys					: in std_logic_vector(0 to 6);
		drawing_request	: out std_logic;
		mVGA_RGB				: out std_logic_vector(7 downto 0) --	,//	VGA composite RGB
	);
end key_draw;

architecture key_draw_arch of key_draw is 
	constant SILENCE : std_logic_vector(0 to 6) := "0000000";
	
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
	
	constant top_y : integer := 381;
	constant bot_y : integer := 459;
	
	constant	x_frame	: integer :=	639;
	constant	y_frame	: integer :=	479;
	constant	int_frame	: integer :=	10;

	signal mVGA_R	: std_logic_vector(2 downto 0); --	,	 			//	VGA Red[2:0]
	signal mVGA_G	: std_logic_vector(2 downto 0); --	,	 			//	VGA Green[2:0]
	signal mVGA_B	: std_logic_vector(1 downto 0); --	,  			//	VGA Blue[1:0]
	
begin

	mVGA_RGB <=  mVGA_R & mVGA_G &  mVGA_B ;
	-- defining three rectangles 

	process ( oCoord_X,oCoord_y )
	
	begin 
		
		if RESETn = '0' OR keys = SILENCE then
			drawing_request <= '0';
		elsif rising_edge(clk) then
			drawing_request <= '0';
			if keys(0) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= start_note1 AND oCoord_X <= start_black1)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note1 AND oCoord_X <= end_note1)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(1) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black1 AND oCoord_X <= start_black2)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note2 AND oCoord_X <= end_note2)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(2) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black2 AND oCoord_X <= end_note3)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note3 AND oCoord_X <= end_note3)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(3) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= start_note4 AND oCoord_X <= start_black3)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note4 AND oCoord_X <= end_note4)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(4) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black3 AND oCoord_X <= start_black4)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note5 AND oCoord_X <= end_note5)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(5) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black4 AND oCoord_X <= start_black5)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note6 AND oCoord_X <= end_note6)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(6) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black5 AND oCoord_X <= end_note7)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note7 AND oCoord_X <= end_note7)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
		end if;
	end process ; 
end key_draw_arch;	