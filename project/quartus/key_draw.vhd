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
	
	constant top_y : integer := 389;
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
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= start_note8 AND oCoord_X <= start_black6)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note8 AND oCoord_X <= end_note8)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(1) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black6 AND oCoord_X <= start_black7)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note9 AND oCoord_X <= end_note9)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(2) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black7 AND oCoord_X <= end_note10)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note10 AND oCoord_X <= end_note10)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(3) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= start_note11 AND oCoord_X <= start_black8)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note11 AND oCoord_X <= end_note11)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(4) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black8 AND oCoord_X <= start_black9)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note12 AND oCoord_X <= end_note12)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(5) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black9 AND oCoord_X <= start_black10)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note13 AND oCoord_X <= end_note13)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
			if keys(6) = '1' then
				if ((oCoord_y >= top_y AND oCoord_y < bot_y) AND (oCoord_X >= end_black10 AND oCoord_X <= end_note14)) OR
					((oCoord_y >= bot_y AND oCoord_y < y_frame) AND (oCoord_X >= start_note14 AND oCoord_X <= end_note14)) then
					drawing_request <= '1';
					mVGA_R <= "000";	
					mVGA_G <= "111";	
					mVGA_B <= "00" ;
				end if;
			end if;
		end if;
	end process ; 
end key_draw_arch;	