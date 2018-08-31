 LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all ;



entity sound_manager_code is
	port(
			clk 					: in std_logic									;
			resetN 				: in std_logic									;
			keys 					: in std_logic_vector(0 to 6) 			;
		   attackFactor      : IN INTEGER  RANGE 0 to 4095				;
		   decayFactor 		: IN INTEGER  RANGE 0 to 511				;
		   sustainFactor 		: IN INTEGER  RANGE 0 to 511				;
		   releaseFactor 		: IN INTEGER  RANGE 0 to 511				;
		   attackRounder		: IN INTEGER  RANGE 0 to 128				;
		   decayRounder		: IN INTEGER  RANGE 0 to 32				;
		   releaseRounder		: IN INTEGER  RANGE 0 to 32				;			
			sound					: out std_logic_vector(15 downto 0) 	;		
			test_led 			: out std_logic
	    );
end sound_manager_code ;



architecture arc_sound_manager_code of sound_manager_code is

component prescaler is
	port(
			CLK_IN				:	IN  STD_LOGIC				   			;	
			resetN				:  IN	 STD_LOGIC								;
			count_limit       :  IN  INTEGER  RANGE 0 to 8388607		;
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
		  CLK     					: in std_logic								;
		  resetN 					: in std_logic								;
		  en							: in std_logic								;
		  in_note  					: in std_logic_vector(15 downto 0)	;
		  attackFactor          : IN INTEGER  RANGE 0 to 4095			;
		  decayFactor 				: IN INTEGER  RANGE 0 to 511			;
		  sustainFactor 			: IN INTEGER  RANGE 0 to 511			;
		  releaseFactor 			: IN INTEGER  RANGE 0 to 511			;
		  attackRounder			: IN INTEGER  RANGE 0 to 128			;
		  decayRounder				: IN INTEGER  RANGE 0 to 32			;
		  releaseRounder			: IN INTEGER  RANGE 0 to 32			;
		  
		  test_led					: out std_logic;
		  out_note 					: out std_logic_vector(15 downto 0)
		 );
end component;

component addr_note IS
	PORT (
			clk				:  in std_logic									;
			enables			: 	in std_logic_vector(6 downto 0)			;
			note0				: 	in std_logic_vector(15 downto 0)			;
			note1				: 	in std_logic_vector(15 downto 0)			;
			note2				: 	in std_logic_vector(15 downto 0)			;
			note3				: 	in std_logic_vector(15 downto 0)			;
			note4				: 	in std_logic_vector(15 downto 0)			;
			note5				: 	in std_logic_vector(15 downto 0)			;
			note6				: 	in std_logic_vector(15 downto 0)			;
			addr				: 	out std_logic_vector(15 downto 0)
		 );

END component;


  signal enables 	: std_logic_vector(0 to 6)								;
  signal ps 		: std_logic_vector(0 to 6)								;
  
  signal addr0 	: std_logic_vector(7 downto 0)						;
  signal addr1 	: std_logic_vector(7 downto 0)						;
  signal addr2 	: std_logic_vector(7 downto 0)						;
  signal addr3 	: std_logic_vector(7 downto 0)						;
  signal addr4 	: std_logic_vector(7 downto 0)						;
  signal addr5 	: std_logic_vector(7 downto 0)						;
  signal addr6 	: std_logic_vector(7 downto 0)						;
  
  signal sin0 		: std_logic_vector(15 downto 0)						;
  signal sin1 		: std_logic_vector(15 downto 0)						;
  signal sin2 		: std_logic_vector(15 downto 0)						;
  signal sin3 		: std_logic_vector(15 downto 0)						;
  signal sin4 		: std_logic_vector(15 downto 0)						;
  signal sin5 		: std_logic_vector(15 downto 0)						;
  signal sin6 		: std_logic_vector(15 downto 0)						;
  
  signal note0		: std_logic_vector(15 downto 0)						;
  signal note1		: std_logic_vector(15 downto 0)						;
  signal note2		: std_logic_vector(15 downto 0)						;
  signal note3		: std_logic_vector(15 downto 0)						;
  signal note4		: std_logic_vector(15 downto 0)						;
  signal note5		: std_logic_vector(15 downto 0)						;
  signal note6		: std_logic_vector(15 downto 0)						;
  

 begin

	PS0: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>746 ,prescaler_1=>ps(0) );
	PS1: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>655 ,prescaler_1=>ps(1) );
	PS2: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>592 ,prescaler_1=>ps(2) );
	PS3: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>559 ,prescaler_1=>ps(3) );
	PS4: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>498 ,prescaler_1=>ps(4) );
	PS5: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>444 ,prescaler_1=>ps(5) );
	PS6: prescaler port map (CLK_IN=>clk, resetN=>resetN, count_limit=>395 ,prescaler_1=>ps(6) );
	
	cnt0 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(0) ,en1=>ps(0) ,addr=>addr0 );
	cnt1 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(1) ,en1=>ps(1) ,addr=>addr1 );
	cnt2 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(2) ,en1=>ps(2) ,addr=>addr2 );
	cnt3 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(3) ,en1=>ps(3) ,addr=>addr3 );
	cnt4 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(4) ,en1=>ps(4) ,addr=>addr4 );
	cnt5 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(5) ,en1=>ps(5) ,addr=>addr5 );
	cnt6 : addr_counter port map (CLK_IN=>clk, resetN=>resetN, en=>ps(6) ,en1=>ps(6) ,addr=>addr6 );

	sinTable0: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr0, Q=>sin0 );
	sinTable1: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr1, Q=>sin1 );
	sinTable2: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr2, Q=>sin2 );
	sinTable3: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr3, Q=>sin3 );
	sinTable4: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr4, Q=>sin4 );
	sinTable5: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr5, Q=>sin5 );
	sinTable6: sintable port map (CLK=>clk ,resetN=>resetN, ADDR=>addr6, Q=>sin6 );
 
	adsr0: adsr port map (clk=>clk, resetN=>resetN, en=>keys(0), in_note=>sin0, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactor,releaseFactor=>releaseFactor, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(0) ,out_note=>note0 );
	adsr1: adsr port map (clk=>clk, resetN=>resetN, en=>keys(1), in_note=>sin0, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactor,releaseFactor=>releaseFactor, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(1) ,out_note=>note1 );
	adsr2: adsr port map (clk=>clk, resetN=>resetN, en=>keys(2), in_note=>sin0, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactor,releaseFactor=>releaseFactor, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(2) ,out_note=>note2 );
	adsr3: adsr port map (clk=>clk, resetN=>resetN, en=>keys(3), in_note=>sin0, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactor,releaseFactor=>releaseFactor, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(3) ,out_note=>note3 );
	adsr4: adsr port map (clk=>clk, resetN=>resetN, en=>keys(4), in_note=>sin0, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactor,releaseFactor=>releaseFactor, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(4) ,out_note=>note4 );
	adsr5: adsr port map (clk=>clk, resetN=>resetN, en=>keys(5), in_note=>sin0, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactor,releaseFactor=>releaseFactor, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(5) ,out_note=>note5 );
	adsr6: adsr port map (clk=>clk, resetN=>resetN, en=>keys(6), in_note=>sin0, attackFactor=>attackFactor, decayFactor=>decayFactor, sustainFactor=>sustainFactor,releaseFactor=>releaseFactor, attackRounder=>attackRounder, decayRounder=>decayRounder, releaseRounder=>releaseRounder, test_led=>enables(6) ,out_note=>note6 );
 
	note_addr : addr_note port map (clk=>clk, enables=>enables, note0=>note0, note1=>note1, note2=>note2, note3=>note3, note4=>note4, note5=>note5, note6=>note6, addr=>sound );
	
	test_led <= enables(0) or enables(1) or enables(2) or enables(3) or enables(4) or enables(5) or enables(6);
 
 
end arc_sound_manager_code ;




