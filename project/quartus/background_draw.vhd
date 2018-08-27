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

-- each note 27 width pixel
-- each gap between notes 3 pixels

-- Constants for frame drawing
constant	x_frame	: integer :=	639;
constant	y_frame	: integer :=	479;
constant	int_frame	: integer :=	10;

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
constant start_black5 : integer := end_note7 - 5;
constant end_black5 : integer := start_note8 + 6;
constant start_black6 : integer := end_note8 - 5;
constant end_black6 : integer := start_note9 + 6;
constant start_black7 : integer := end_note10 - 5;
constant end_black7 : integer := start_note11 + 6;
constant start_black8 : integer := end_note11 - 5;
constant end_black8 : integer := start_note12 + 6;
constant start_black9 : integer := end_note13 - 5;
constant end_black9 : integer := start_note14 + 6;

signal mVGA_R	: std_logic_vector(2 downto 0); --	,	 			//	VGA Red[2:0]
signal mVGA_G	: std_logic_vector(2 downto 0); --	,	 			//	VGA Green[2:0]
signal mVGA_B	: std_logic_vector(1 downto 0); --	,  			//	VGA Blue[1:0]
	
begin

mVGA_RGB <=  mVGA_R & mVGA_G &  mVGA_B ;
-- defining three rectangles 

process ( oCoord_X,oCoord_y )
begin 

	if (oCoord_X >= 0 AND oCoord_X < x_frame) AND (oCoord_y > 0 AND oCoord_y < 389) then
			mVGA_R <= "010";	
			mVGA_G <= "010";	
			mVGA_B <= "01" ;	 
	else
		if (oCoord_X > end_note1 AND oCoord_X < start_note2) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black1 AND oCoord_X < end_black1) AND (oCoord_y >= 389 AND oCoord_y < 459) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note2 AND oCoord_X < start_note3) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note3 AND oCoord_X < start_note4) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black2 AND oCoord_X < end_black2) AND (oCoord_y >= 389 AND oCoord_y < 459) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note4 AND oCoord_X < start_note5) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note5 AND oCoord_X < start_note6) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black3 AND oCoord_X < end_black3) AND (oCoord_y >= 389 AND oCoord_y < 459) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note6 AND oCoord_X < start_note7) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note7 AND oCoord_X < start_note8) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > start_black4 AND oCoord_X < end_black4) AND (oCoord_y >= 389 AND oCoord_y < 459) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note8 AND oCoord_X < start_note9) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note9 AND oCoord_X < start_note10) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note10 AND oCoord_X < start_note11) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note11 AND oCoord_X < start_note12) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note12 AND oCoord_X < start_note13) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note13 AND oCoord_X < start_note14) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note14 AND oCoord_X < start_note15) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note15 AND oCoord_X < start_note16) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note16 AND oCoord_X < start_note17) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note17 AND oCoord_X < start_note18) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note18 AND oCoord_X < start_note19) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note19 AND oCoord_X < start_note20) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		elsif (oCoord_X > end_note20 AND oCoord_X < start_note21) AND (oCoord_y >= 389 AND oCoord_y < y_frame) then
			mVGA_R <= "000";	
			mVGA_G <= "000";	
			mVGA_B <= "00" ;
		else
			mVGA_R <= "111";	
			mVGA_G <= "111";	
			mVGA_B <= "11" ;
		end if;
	end if ; 

end process ; 

		
end background_draw_arch;		