library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all ;


entity adsr is
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
end adsr;

architecture adsr_arch of adsr is

		component prescaler is
	PORT
		(
			CLK_IN				:	IN  STD_LOGIC;	
			resetN				:  IN	 STD_LOGIC;
			count_limit       :  IN  integer  RANGE 0 to 33554431;
			prescaler_1	 		:	OUT STD_LOGIC;
			prescaler_2	 		:	OUT STD_LOGIC 
		);
		end component ;

type States is (idle , --initial state
				attack,	
				decayPressed,
				decayReleased,
				sustainPressed,
				sustainReleased,		
				releasePressed,
				releaseReleased);

signal state : States;
signal slowClk : std_logic;
signal amplifier : std_logic_vector(15 downto 0); -- normlized to 32000	
signal out_n : std_logic_vector(31 downto 0);

 begin
 
	slowClock: prescaler port map (
		CLK_IN=>CLK,
		resetN=>resetN,
		count_limit=>450000,
		prescaler_1=>slowClk) ;

	out_n <= in_note * amplifier;
	out_note(13 downto 0)	<= out_n(31 downto 18);
	out_note(15 downto 14)   <= "00";
	--out_note <= in_note when en ='1' else (others => '0');
	test_led <= '1' when amplifier > 950 else '0';
		
	PROCESS (slowClk, resetN)
	variable rounder : integer range 0 to 4095;
		begin
			if resetN = '0' then
				amplifier <= (others => '0');
				state <= idle;
				rounder := 0;
			elsif rising_edge (slowClk) then
				case state is
					when idle =>
						if en = '1' then
							state <= attack;
							rounder := 0;
							amplifier <= (others => '0');
						end if;
					when attack =>
						if rounder <= (attackFactor / 2) then
							if rounder <= (attackFactor / 4) then
								rounder := rounder + attackRounder;
							else
								rounder := rounder + (attackRounder / 2);
							end if;
						end if;
						if en = '0' then
							state <= decayReleased;
							rounder := 0;
						elsif amplifier < 32000 then
							amplifier <= amplifier + attackFactor - rounder;
						else
							state <= decayPressed;
							rounder := 0;
						end if;
					when decayPressed =>
						if rounder <= (decayFactor / 2) then
							if rounder <= (decayFactor / 4) then
								rounder := rounder + decayRounder;
							else
								rounder := rounder + (decayRounder / 2);
							end if;
						end if;
						if en = '0' then
							state <= sustainReleased;
							rounder := 0;
						elsif amplifier > 16000 then
							amplifier <= amplifier - decayFactor + rounder;
						else
							state <= sustainPressed;
							rounder := 0;
						end if;	
					when decayReleased =>
						if rounder <= (decayFactor / 2) then
							if rounder <= (decayFactor / 4) then
								rounder := rounder + decayRounder;
							else
								rounder := rounder + (decayRounder / 2);
							end if;
						end if;
						if en = '1' then
							state <= attack;
							amplifier <= (others => '0');
							rounder := 0;
						elsif amplifier > 16000 then
							amplifier <= amplifier - decayFactor + rounder;
						else
							state <= sustainReleased;
							rounder := 0;
						end if;	
					when sustainPressed =>
						rounder := 0;
						if en = '0' then
							state <= releaseReleased;
							rounder := 0;
						elsif amplifier > 8000 then
							amplifier <= amplifier - sustainFactor + rounder;
						else
							state <= releasePressed;
							rounder := 0;
						end if;	
					when sustainReleased =>
						rounder := 0;
						if en = '1' then
							state <= attack;
							amplifier <= (others => '0');
							rounder := 0;
						elsif amplifier > 8000 then
							amplifier <= amplifier - sustainFactor + rounder;
						else
							state <= releaseReleased;
							rounder := 0;
						end if;
					when releasePressed =>
						if rounder <= (releaseFactor / 2) then
							if rounder <= (releaseFactor / 4) then
								rounder := rounder + releaseRounder;
							else
								rounder := rounder + (releaseRounder / 2);
							end if;
						end if;	
						if en = '0' then
							state <= releaseReleased;
							rounder := 0;
						elsif amplifier > releaseFactor then
							amplifier <= amplifier - releaseFactor + rounder;
						else
							amplifier <= (others => '0');	
							rounder := 0;
						end if;
					when releaseReleased =>
						if rounder <= (releaseFactor / 2) then
							if rounder <= (releaseFactor / 4) then
								rounder := rounder + releaseRounder;
							else
								rounder := rounder + (releaseRounder / 2);
							end if;
						end if;	
						if en = '1' then
							state <= attack;
							amplifier <= (others => '0');
							rounder := 0;
						elsif amplifier > releaseFactor then
							amplifier <= amplifier - releaseFactor + rounder;
						else
							amplifier <= (others => '0');
							state <= idle;
							rounder := 0;
						end if;
				end case;	
			end if;
	end process;
end adsr_arch;