 LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all ;



entity sound_manager_code is
	port(
			clk 					: in std_logic									;
			resetN 				: in std_logic									;
			vol_up				: in std_logic									;
			vol_down				: in std_logic									;
			space_key			: in std_logic									;
			lowTune				: in std_logic									;
			keys 					: in std_logic_vector(0 to 23) 			;
			attackFactor      : IN INTEGER  RANGE 0 to 4095				;
			decayFactor 		: IN INTEGER  RANGE 0 to 1023				;
			sustainFactor 		: IN INTEGER  RANGE 0 to 1023				;
			sustainFactorSlow	: IN INTEGER  RANGE 0 to 1023				;
			releaseFactor 		: IN INTEGER  RANGE 0 to 1023				;
			releaseFactorSlow : IN INTEGER  RANGE 0 to 1023				;
			attackRounder		: IN INTEGER  RANGE 0 to 255				;
			decayRounder		: IN INTEGER  RANGE 0 to 63				;
			releaseRounder		: IN INTEGER  RANGE 0 to 63				;			
			sound					: out std_logic_vector(15 downto 0) 	;		
			test_led 			: out std_logic								;
			volume				: out std_logic_vector(3 downto 0) 		
	    );
end sound_manager_code ;



architecture arc_sound_manager_code of sound_manager_code is

constant	do_c2		: integer :=	2986;
constant	doD_c2	: integer :=	2818;
constant	re_c2		: integer :=	2660;
constant	reD_c2	: integer :=	2511;
constant	mi_c2		: integer :=	2370;
constant	fa_c2		: integer :=	2237;
constant	faD_c2	: integer :=	2112;
constant	sol_c2	: integer :=	1993;
constant	solD_c2	: integer :=	1881;
constant	la_c2 	: integer :=	1776;
constant	laD_c2	: integer :=	1676;
constant	si_c2		: integer :=	1582;
constant	do_c3		: integer :=	1493;
constant	doD_c3	: integer :=	1409;
constant	re_c3		: integer :=	1330;
constant	reD_c3	: integer :=	1255;
constant	mi_c3		: integer :=	1185;
constant	fa_c3		: integer :=	1118;
constant	faD_c3	: integer :=	1056;
constant	sol_c3	: integer :=	996;
constant	solD_c3	: integer :=	940;
constant	la_c3		: integer :=	888;
constant	laD_c3	: integer :=	838;
constant	si_c3		: integer :=	791;
constant	do_c4		: integer :=	746;
constant	doD_c4	: integer :=	705;
constant	re_c4		: integer :=	655;
constant	reD_c4	: integer :=	628;
constant	mi_c4		: integer :=	592;
constant	fa_c4		: integer :=	559;
constant	faD_c4	: integer :=	528;
constant	sol_c4	: integer :=	498;
constant	solD_c4	: integer :=	470;
constant	la_c4		: integer :=	444;
constant	laD_c4	: integer :=	419;
constant	si_c4		: integer :=	395;
constant	do_c5		: integer :=	373;
constant	doD_c5	: integer :=	352;
constant	re_c5		: integer :=	333;
constant	reD_c5	: integer :=	314;
constant	mi_c5		: integer :=	296;
constant	fa_c5		: integer :=	280;
constant	faD_c5	: integer :=	264;
constant	sol_c5	: integer :=	249;
constant	solD_c5	: integer :=	235;
constant	la_c5		: integer :=	222;
constant	laD_c5	: integer :=	209;
constant	si_c5		: integer :=	198;




component prescaler is
	port(
			CLK_IN				:	IN  STD_LOGIC				   			;	
			resetN				:  IN	 STD_LOGIC								;
			count_limit       :  IN  INTEGER  RANGE 0 to 33554431		;
			prescaler_1	 		:	OUT STD_LOGIC 								;
			prescaler_2	 		:	OUT STD_LOGIC 
		 );		
END component;

component addr_counter IS
	port(
			CLK_IN				:	IN	STD_LOGIC								;	
			resetN				:	IN	STD_LOGIC								;
			en						: 	in  std_logic 								;
			en1					: 	in  std_logic 								;
			addr					: 	out std_logic_vector(7 downto 0)
		 );
END component;

component sintable is
	port(
		  CLK     					: in std_logic								;
		  resetN 					: in std_logic								;
		  ADDR    					: in std_logic_vector(7 downto 0)	;
		  Q       					: out std_logic_vector(15 downto 0)
		 );
end component;

component adsr is
	port(
  CLK     					: in std_logic;
  resetN 					: in std_logic;
  en							: in std_logic;
  in_note  					: in std_logic_vector(15 downto 0);
  attackFactor          : IN INTEGER  RANGE 0 to 4095;
  decayFactor 				: IN INTEGER  RANGE 0 to 1023;
  sustainFactor 			: IN INTEGER  RANGE 0 to 1023;
  releaseFactor 			: IN INTEGER  RANGE 0 to 1023;
  attackRounder			: IN INTEGER  RANGE 0 to 255;
  decayRounder				: IN INTEGER  RANGE 0 to 63;
  releaseRounder			: IN INTEGER  RANGE 0 to 63;
  test_led					: out std_logic;
  out_note 					: out std_logic_vector(15 downto 0)
		 );
end component;

component addr_note IS
	PORT (
			clk				:  in std_logic										;
			enables			: 	in std_logic_vector(23 downto 0)				;
			note0				: 	in std_logic_vector(15 downto 0)				;
			note1				: 	in std_logic_vector(15 downto 0)				;
			note2				: 	in std_logic_vector(15 downto 0)				;
			note3				: 	in std_logic_vector(15 downto 0)				;
			note4				: 	in std_logic_vector(15 downto 0)				;
			note5				: 	in std_logic_vector(15 downto 0)				;
			note6				: 	in std_logic_vector(15 downto 0)				;
			note7				: 	in std_logic_vector(15 downto 0)				;
			note8				: 	in std_logic_vector(15 downto 0)				;
			note9				: 	in std_logic_vector(15 downto 0)				;
			note10				: 	in std_logic_vector(15 downto 0)			;
			note11				: 	in std_logic_vector(15 downto 0)			;
			note12				: 	in std_logic_vector(15 downto 0)			;
			note13				: 	in std_logic_vector(15 downto 0)			;
			note14				: 	in std_logic_vector(15 downto 0)			;
			note15				: 	in std_logic_vector(15 downto 0)			;
			note16				: 	in std_logic_vector(15 downto 0)			;
			note17				: 	in std_logic_vector(15 downto 0)			;
			note18				: 	in std_logic_vector(15 downto 0)			;
			note19				: 	in std_logic_vector(15 downto 0)			;
			note20				: 	in std_logic_vector(15 downto 0)			;
			note21				: 	in std_logic_vector(15 downto 0)			;
			note22				: 	in std_logic_vector(15 downto 0)			;
			note23				: 	in std_logic_vector(15 downto 0)			;
			addr					: 	out std_logic_vector(15 downto 0)
		 );

END component;

component vol_ctl is
port(
  clk     					: in std_logic;
  resetN 					: in std_logic;
  vol_up						: in std_logic;
  vol_down					: in std_logic;
  sound_in 					: in std_logic_vector(15 downto 0);
  sound_out 				: out std_logic_vector(15 downto 0);
  vol_out						: out std_logic_vector(3 downto 0)
);
end component;


  signal enables 	: std_logic_vector(0 to 23)							;
  signal ps 		: std_logic_vector(0 to 23)							;
  
  signal addr0 	: std_logic_vector(7 downto 0)						;
  signal addr1 	: std_logic_vector(7 downto 0)						;
  signal addr2 	: std_logic_vector(7 downto 0)						;
  signal addr3 	: std_logic_vector(7 downto 0)						;
  signal addr4 	: std_logic_vector(7 downto 0)						;
  signal addr5 	: std_logic_vector(7 downto 0)						;
  signal addr6 	: std_logic_vector(7 downto 0)						;
  signal addr7 	: std_logic_vector(7 downto 0)						;
  signal addr8 	: std_logic_vector(7 downto 0)						;
  signal addr9 	: std_logic_vector(7 downto 0)						;
  signal addr10 	: std_logic_vector(7 downto 0)						;
  signal addr11 	: std_logic_vector(7 downto 0)						;
  signal addr12 	: std_logic_vector(7 downto 0)						;
  signal addr13 	: std_logic_vector(7 downto 0)						;
  signal addr14 	: std_logic_vector(7 downto 0)						;
  signal addr15 	: std_logic_vector(7 downto 0)						;
  signal addr16 	: std_logic_vector(7 downto 0)						;
  signal addr17 	: std_logic_vector(7 downto 0)						;
  signal addr18 	: std_logic_vector(7 downto 0)						;
  signal addr19 	: std_logic_vector(7 downto 0)						;
  signal addr20 	: std_logic_vector(7 downto 0)						;
  signal addr21 	: std_logic_vector(7 downto 0)						;
  signal addr22 	: std_logic_vector(7 downto 0)						;
  signal addr23 	: std_logic_vector(7 downto 0)						;
  
  signal sin0 		: std_logic_vector(15 downto 0)						;
  signal sin1 		: std_logic_vector(15 downto 0)						;
  signal sin2 		: std_logic_vector(15 downto 0)						;
  signal sin3 		: std_logic_vector(15 downto 0)						;
  signal sin4 		: std_logic_vector(15 downto 0)						;
  signal sin5 		: std_logic_vector(15 downto 0)						;
  signal sin6 		: std_logic_vector(15 downto 0)						;
  signal sin7 		: std_logic_vector(15 downto 0)						;
  signal sin8 		: std_logic_vector(15 downto 0)						;
  signal sin9 		: std_logic_vector(15 downto 0)						;
  signal sin10		: std_logic_vector(15 downto 0)						;
  signal sin11		: std_logic_vector(15 downto 0)						;
  signal sin12		: std_logic_vector(15 downto 0)						;
  signal sin13		: std_logic_vector(15 downto 0)						;
  signal sin14		: std_logic_vector(15 downto 0)						;
  signal sin15		: std_logic_vector(15 downto 0)						;
  signal sin16		: std_logic_vector(15 downto 0)						;
  signal sin17		: std_logic_vector(15 downto 0)						;
  signal sin18		: std_logic_vector(15 downto 0)						;
  signal sin19		: std_logic_vector(15 downto 0)						;
  signal sin20		: std_logic_vector(15 downto 0)						;
  signal sin21		: std_logic_vector(15 downto 0)						;
  signal sin22		: std_logic_vector(15 downto 0)						;
  signal sin23		: std_logic_vector(15 downto 0)						;
  
  signal note0		: std_logic_vector(15 downto 0)						;
  signal note1		: std_logic_vector(15 downto 0)						;
  signal note2		: std_logic_vector(15 downto 0)						;
  signal note3		: std_logic_vector(15 downto 0)						;
  signal note4		: std_logic_vector(15 downto 0)						;
  signal note5		: std_logic_vector(15 downto 0)						;
  signal note6		: std_logic_vector(15 downto 0)						;
  signal note7		: std_logic_vector(15 downto 0)						;
  signal note8		: std_logic_vector(15 downto 0)						;
  signal note9		: std_logic_vector(15 downto 0)						;
  signal note10	: std_logic_vector(15 downto 0)						;
  signal note11	: std_logic_vector(15 downto 0)						;
  signal note12	: std_logic_vector(15 downto 0)						;
  signal note13	: std_logic_vector(15 downto 0)						;
  signal note14	: std_logic_vector(15 downto 0)						;
  signal note15	: std_logic_vector(15 downto 0)						;
  signal note16	: std_logic_vector(15 downto 0)						;
  signal note17	: std_logic_vector(15 downto 0)						;
  signal note18	: std_logic_vector(15 downto 0)						;
  signal note19	: std_logic_vector(15 downto 0)						;
  signal note20	: std_logic_vector(15 downto 0)						;
  signal note21	: std_logic_vector(15 downto 0)						;
  signal note22	: std_logic_vector(15 downto 0)						;
  signal note23	: std_logic_vector(15 downto 0)						;
  
  signal all_notes : std_logic_vector(15 downto 0)						;
  
  signal sustainStatus		 : std_logic									;
  signal sustainFactorValue : INTEGER  RANGE 0 to 1023				;
  signal releaseFactorValue : INTEGER  RANGE 0 to 1023				;

  signal low_do		: INTEGER  RANGE 0 to 33554431					;
  signal low_doD		: INTEGER  RANGE 0 to 33554431					; 
  signal low_re 		: INTEGER  RANGE 0 to 33554431					;
  signal low_reD		: INTEGER  RANGE 0 to 33554431					;
  signal low_mi 		: INTEGER  RANGE 0 to 33554431					;
  signal low_fa		: INTEGER  RANGE 0 to 33554431					;
  signal low_faD 		: INTEGER  RANGE 0 to 33554431					;
  signal low_sol		: INTEGER  RANGE 0 to 33554431					;
  signal low_solD		: INTEGER  RANGE 0 to 33554431					;
  signal low_la 		: INTEGER  RANGE 0 to 33554431					;
  signal low_laD		: INTEGER  RANGE 0 to 33554431					;
  signal low_si 		: INTEGER  RANGE 0 to 33554431					;
  signal high_do 		: INTEGER  RANGE 0 to 33554431					;
  signal high_doD		: INTEGER  RANGE 0 to 33554431					;
  signal high_re 		: INTEGER  RANGE 0 to 33554431					;
  signal high_reD		: INTEGER  RANGE 0 to 33554431					;
  signal high_mi		: INTEGER  RANGE 0 to 33554431					;
  signal high_fa		: INTEGER  RANGE 0 to 33554431					;
  signal high_faD		: INTEGER  RANGE 0 to 33554431					;
  signal high_sol		: INTEGER  RANGE 0 to 33554431					;
  signal high_solD	: INTEGER  RANGE 0 to 33554431					;
  signal high_la		: INTEGER  RANGE 0 to 33554431					;
  signal high_laD		: INTEGER  RANGE 0 to 33554431					;
  signal high_si 		: INTEGER  RANGE 0 to 33554431					;
  
 begin
 
 	PROCESS (clk, resetN)
	 begin
		if resetN = '0' then
			sustainStatus <= '0';
		elsif rising_edge (clk) then
			if space_key = '1' then
				sustainStatus <= not(sustainStatus);
			end if;
		end if;
	end process;
	
	low_do <= do_c2 when lowTune = '1' else do_c4;
	low_doD <= doD_c2 when lowTune = '1' else doD_c4;
	low_re <= re_c2 when lowTune = '1' else re_c4;
	low_reD <= reD_c2 when lowTune = '1' else reD_c4;
	low_mi <= mi_c2 when lowTune = '1' else mi_c4;
	low_fa <= fa_c2 when lowTune = '1' else fa_c4;
	low_faD <= faD_c2 when lowTune = '1' else faD_c4;
	low_sol <= sol_c2 when lowTune = '1' else sol_c4;
	low_solD <= solD_c2 when lowTune = '1' else solD_c4;
	low_la <= la_c2 when lowTune = '1' else la_c4;
	low_laD <= laD_c2 when lowTune = '1' else laD_c4;
	low_si <= si_c2 when lowTune = '1' else si_c4;
	
	high_do <= do_c3 when lowTune = '1' else do_c5;
	high_doD <= doD_c3 when lowTune = '1' else doD_c5;
	high_re <= re_c3 when lowTune = '1' else re_c5;
	high_reD <= reD_c3 when lowTune = '1' else reD_c5;
	high_mi <= mi_c3 when lowTune = '1' else mi_c5;
	high_fa <= fa_c3 when lowTune = '1' else fa_c5;
	high_faD <= faD_c3 when lowTune = '1' else faD_c5;
	high_sol <= sol_c3 when lowTune = '1' else sol_c5;
	high_solD <= solD_c3 when lowTune = '1' else solD_c5;
	high_la <= la_c3 when lowTune = '1' else la_c5;
	high_laD <= laD_c3 when lowTune = '1' else laD_c5;
	high_si <= si_c3 when lowTune = '1' else si_c5;
	
	sustainFactorValue <= sustainFactor when sustainStatus = '0' else sustainFactorSlow;
	releaseFactorValue <= releaseFactor when sustainStatus = '0' else releaseFactorSlow;
	
	PS0: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_do   ,prescaler_1=>ps(0)  );
	PS1: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_doD   ,prescaler_1=>ps(1) );
	PS2: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_re    ,prescaler_1=>ps(2) );
	PS3: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_reD   ,prescaler_1=>ps(3) );
	PS4: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_mi    ,prescaler_1=>ps(4) );
	PS5: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_fa    ,prescaler_1=>ps(5) );
	PS6: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_faD   ,prescaler_1=>ps(6) );
	PS7: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_sol   ,prescaler_1=>ps(7) );
	PS8: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_solD  ,prescaler_1=>ps(8) );
	PS9: prescaler port map  (CLK_IN=>clk, resetN=>resetN, count_limit=>low_la    ,prescaler_1=>ps(9) );
	PS10: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>low_laD   ,prescaler_1=>ps(10));
	PS11: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>low_si    ,prescaler_1=>ps(11));
	PS12: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_do   ,prescaler_1=>ps(12));
	PS13: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_doD  ,prescaler_1=>ps(13));
	PS14: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_re   ,prescaler_1=>ps(14));
	PS15: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_reD  ,prescaler_1=>ps(15));
	PS16: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_mi   ,prescaler_1=>ps(16));
	PS17: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_fa   ,prescaler_1=>ps(17));
	PS18: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_faD  ,prescaler_1=>ps(18));
	PS19: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_sol  ,prescaler_1=>ps(19));
	PS20: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_solD ,prescaler_1=>ps(20));
	PS21: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_la   ,prescaler_1=>ps(21));
	PS22: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_laD  ,prescaler_1=>ps(22));
	PS23: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>high_si   ,prescaler_1=>ps(23));
	
	cnt0 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(0) ,en1=>ps(0) ,addr=>addr0 );
	cnt1 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(1) ,en1=>ps(1) ,addr=>addr1 );
	cnt2 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(2) ,en1=>ps(2) ,addr=>addr2 );
	cnt3 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(3) ,en1=>ps(3) ,addr=>addr3 );
	cnt4 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(4) ,en1=>ps(4) ,addr=>addr4 );
	cnt5 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(5) ,en1=>ps(5) ,addr=>addr5 );
	cnt6 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(6) ,en1=>ps(6) ,addr=>addr6 );
	cnt7 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(7) ,en1=>ps(7) ,addr=>addr7 );
	cnt8 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(8) ,en1=>ps(8) ,addr=>addr8 );
	cnt9 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(9) ,en1=>ps(9) ,addr=>addr9 );
	cnt10 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(10) ,en1=>ps(10) ,addr=>addr10 );
	cnt11 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(11) ,en1=>ps(11) ,addr=>addr11 );
	cnt12 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(12) ,en1=>ps(12) ,addr=>addr12 );
	cnt13 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(13) ,en1=>ps(13) ,addr=>addr13 );
	cnt14 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(14) ,en1=>ps(14) ,addr=>addr14 );
	cnt15 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(15) ,en1=>ps(15) ,addr=>addr15 );
	cnt16 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(16) ,en1=>ps(16) ,addr=>addr16 );
	cnt17 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(17) ,en1=>ps(17) ,addr=>addr17 );
	cnt18 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(18) ,en1=>ps(18) ,addr=>addr18 );
	cnt19 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(19) ,en1=>ps(19) ,addr=>addr19 );
	cnt20 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(20) ,en1=>ps(20) ,addr=>addr20 );
	cnt21 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(21) ,en1=>ps(21) ,addr=>addr21 );
	cnt22 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(22) ,en1=>ps(22) ,addr=>addr22 );
	cnt23 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(23) ,en1=>ps(23) ,addr=>addr23 );

	sinTable0: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr0, Q=>sin0 );
	sinTable1: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr1, Q=>sin1 );
	sinTable2: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr2, Q=>sin2 );
	sinTable3: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr3, Q=>sin3 );
	sinTable4: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr4, Q=>sin4 );
	sinTable5: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr5, Q=>sin5 );
	sinTable6: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr6, Q=>sin6 );
	sinTable7: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr7, Q=>sin7 );
	sinTable8: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr8, Q=>sin8 );
	sinTable9: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr9, Q=>sin9 );
	sinTable10: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr10, Q=>sin10 );
	sinTable11: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr11, Q=>sin11 );
	sinTable12: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr12, Q=>sin12 );
	sinTable13: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr13, Q=>sin13 );
	sinTable14: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr14, Q=>sin14 );
	sinTable15: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr15, Q=>sin15 );
	sinTable16: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr16, Q=>sin16 );
	sinTable17: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr17, Q=>sin17 );
	sinTable18: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr18, Q=>sin18 );
	sinTable19: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr19, Q=>sin19 );
	sinTable20: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr20, Q=>sin20 );
	sinTable21: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr21, Q=>sin21 );
	sinTable22: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr22, Q=>sin22 );
	sinTable23: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr23, Q=>sin23 );
 
	adsr0: adsr port map (clk=>clk, resetN=>resetN, en=>keys(0), in_note=>sin0, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(0) ,out_note=>note0 );
	adsr1: adsr port map (clk=>clk, resetN=>resetN, en=>keys(1), in_note=>sin1, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(1) ,out_note=>note1 );
	adsr2: adsr port map (clk=>clk, resetN=>resetN, en=>keys(2), in_note=>sin2, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(2) ,out_note=>note2 );
	adsr3: adsr port map (clk=>clk, resetN=>resetN, en=>keys(3), in_note=>sin3, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(3) ,out_note=>note3 );
	adsr4: adsr port map (clk=>clk, resetN=>resetN, en=>keys(4), in_note=>sin4, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(4) ,out_note=>note4 );
	adsr5: adsr port map (clk=>clk, resetN=>resetN, en=>keys(5), in_note=>sin5, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(5) ,out_note=>note5 );
	adsr6: adsr port map (clk=>clk, resetN=>resetN, en=>keys(6), in_note=>sin6, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(6) ,out_note=>note6 );
	adsr7: adsr port map (clk=>clk, resetN=>resetN, en=>keys(7), in_note=>sin7, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(7) ,out_note=>note7 );
	adsr8: adsr port map (clk=>clk, resetN=>resetN, en=>keys(8), in_note=>sin8, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(8) ,out_note=>note8 );
	adsr9: adsr port map (clk=>clk, resetN=>resetN, en=>keys(9), in_note=>sin9, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(9) ,out_note=>note9 );
	adsr10: adsr port map (clk=>clk, resetN=>resetN, en=>keys(10), in_note=>sin10, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(10) ,out_note=>note10 );
	adsr11: adsr port map (clk=>clk, resetN=>resetN, en=>keys(11), in_note=>sin11, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(11) ,out_note=>note11 );
	adsr12: adsr port map (clk=>clk, resetN=>resetN, en=>keys(12), in_note=>sin12, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(12) ,out_note=>note12 );
	adsr13: adsr port map (clk=>clk, resetN=>resetN, en=>keys(13), in_note=>sin13, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(13) ,out_note=>note13 );
	adsr14: adsr port map (clk=>clk, resetN=>resetN, en=>keys(14), in_note=>sin14, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(14) ,out_note=>note14 );
	adsr15: adsr port map (clk=>clk, resetN=>resetN, en=>keys(15), in_note=>sin15, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(15) ,out_note=>note15 );
	adsr16: adsr port map (clk=>clk, resetN=>resetN, en=>keys(16), in_note=>sin16, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(16) ,out_note=>note16 );
	adsr17: adsr port map (clk=>clk, resetN=>resetN, en=>keys(17), in_note=>sin17, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(17) ,out_note=>note17 );
	adsr18: adsr port map (clk=>clk, resetN=>resetN, en=>keys(18), in_note=>sin18, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(18) ,out_note=>note18 );
	adsr19: adsr port map (clk=>clk, resetN=>resetN, en=>keys(19), in_note=>sin19, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(19) ,out_note=>note19 );
	adsr20: adsr port map (clk=>clk, resetN=>resetN, en=>keys(20), in_note=>sin20, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(20) ,out_note=>note20 );
	adsr21: adsr port map (clk=>clk, resetN=>resetN, en=>keys(21), in_note=>sin21, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(21) ,out_note=>note21 );
	adsr22: adsr port map (clk=>clk, resetN=>resetN, en=>keys(22), in_note=>sin22, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(22) ,out_note=>note22 );
	adsr23: adsr port map (clk=>clk, resetN=>resetN, en=>keys(23), in_note=>sin23, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactorValue,releaseFactor=>releaseFactorValue, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(23) ,out_note=>note23 );
	
	note_addr : addr_note port map (clk=>clk, enables=>enables, note0=>note0, note1=>note1, note2=>note2, note3=>note3, note4=>note4, note5=>note5, note6=>note6, 
											  note7=>note7, note8=>note8, note9=>note9, note10=>note10, note11=>note11, note12=>note12, note13=>note13,  
											  note14=>note14, note15=>note15, note16=>note16, note17=>note17, note18=>note18, note19=>note19, note20=>note20, 
											  note21=>note21, note22=>note22, note23=>note23, addr=>all_notes );
	
	vol: vol_ctl port map (clk=>clk, resetN=>resetN,vol_up=>vol_up,vol_down=>vol_down,sound_in=>all_notes,sound_out=>sound,vol_out=>volume);
	
	test_led <= enables(0) or enables(1) or enables(2) or enables(3) or enables(4) or enables(5) or enables(6) or 
	            enables(7) or enables(8) or enables(9) or enables(10) or enables(11) or enables(12) or enables(13) or 
					enables(14) or enables(15) or enables(16) or enables(17) or enables(18) or enables(19) or enables(20) or 
					enables(21) or enables(22) or enables(23);
 
 
end arc_sound_manager_code ;




