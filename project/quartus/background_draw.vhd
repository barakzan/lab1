 library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun July 24 2017 
-- Dudy Nov 13 2017


entity background_draw is
port 	(
		
	   CLK      : in std_logic;
		RESETn	: in std_logic;
		oCoord_X : in integer;
		oCoord_Y : in integer;
		mVGA_RGB	: out std_logic_vector(7 downto 0) --	,//	VGA composite RGB
	);
end background_draw;

architecture background_draw_arch of background_draw is 

-- each note 44 width pixel
-- each gap between notes 2 pixels

-- Constants for frame drawing
constant	x_frame	: integer :=	639;
constant	y_frame	: integer :=	479;
constant	y_start_gray	: integer :=	470;
constant	int_frame	: integer :=	10;

constant	start_white_y	: integer :=	381;
constant	start_black_y  : integer := 	381;
constant	end_white_y		: integer :=	479;
constant	end_black_y  	: integer := 	459;

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

signal mVGA_R	: std_logic_vector(2 downto 0); --	,	 			//	VGA Red[2:0]
signal mVGA_G	: std_logic_vector(2 downto 0); --	,	 			//	VGA Green[2:0]
signal mVGA_B	: std_logic_vector(1 downto 0); --	,  			//	VGA Blue[1:0]
	
begin

mVGA_RGB <=  mVGA_R & mVGA_G &  mVGA_B ;
-- defining three rectangles 

process ( oCoord_X,oCoord_y )
begin 

	if (oCoord_X >= 0 AND oCoord_X < x_frame) AND (oCoord_y > 0 AND oCoord_y < start_white_y) then
			mVGA_R <= "010";	
			mVGA_G <= "010";	
			mVGA_B <= "01" ;	 
	else
		if (oCoord_X > end_note1 AND oCoord_X < start_note2) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note2 AND oCoord_X < start_note3) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note3 AND oCoord_X < start_note4) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note4 AND oCoord_X < start_note5) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note5 AND oCoord_X < start_note6) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note6 AND oCoord_X < start_note7) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note7 AND oCoord_X < start_note8) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note8 AND oCoord_X < start_note9) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note9 AND oCoord_X < start_note10) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note10 AND oCoord_X < start_note11) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note11 AND oCoord_X < start_note12) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note12 AND oCoord_X < start_note13) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note13 AND oCoord_X < start_note14) AND (oCoord_y >= start_white_y AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black1 AND oCoord_X < end_black1) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black2 AND oCoord_X < end_black2) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black3 AND oCoord_X < end_black3) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black4 AND oCoord_X < end_black4) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black5 AND oCoord_X < end_black5) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black6 AND oCoord_X < end_black6) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black7 AND oCoord_X < end_black7) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black8 AND oCoord_X < end_black8) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black9 AND oCoord_X < end_black9) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black10 AND oCoord_X < end_black10) AND (oCoord_y >= start_black_y AND oCoord_y < end_black_y) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		else
			if (oCoord_y > y_start_gray) then
				mVGA_R <= "011";	
				mVGA_G <= "100";	
				mVGA_B <= "10" ;
			else
				mVGA_R <= "111";	
				mVGA_G <= "111";	
				mVGA_B <= "11" ;
			end if;	
		end if;
		

	end if ; 

end process ; 

		
end background_draw_arch;		