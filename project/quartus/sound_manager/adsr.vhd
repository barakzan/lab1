library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all ;
use ieee.numeric_std.all;


entity adsr is
port(
  CLK     					: in std_logic;
  resetN 					: in std_logic;
  en							: in std_logic;
  in_note  					: in std_logic_vector(15 downto 0);
  --in_note  					: in integer RANGE 0 to 65535;
  test_led					: out std_logic;
  out_note 					: out std_logic_vector(15 downto 0)
);
end adsr;

architecture adsr_arch of adsr is

		component prescaler is
	PORT
		(
			CLK_IN					:	IN  STD_LOGIC				;	
			resetN					:  IN	 STD_LOGIC;
			count_limit          :  IN  integer  RANGE 0 to 524285;
			prescaler_1	 		:	OUT STD_LOGIC ;
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
signal amplifier : std_logic_vector(14 downto 0); -- normlized to 3200	
--signal amplifier : integer  RANGE 0 to 131071;	
signal out_n : std_logic_vector(30 downto 0);

 begin
 
	slowClock: prescaler port map (
		CLK_IN=>CLK,
		resetN=>resetN,
		count_limit=>450000,
		prescaler_1=>slowClk) ;

	out_n <= in_note * amplifier;
	out_note	<= out_n(30 downto 15);
	--out_note <= in_note when en ='1' else (others => '0');
	test_led <= '1' when amplifier > 0 else '0';
		
	PROCESS (slowClk, resetN)
	constant attackFactor : integer := 230 ;
	constant decayFactor : integer := 30 ;
	constant sustainFactor : integer := 18 ;
	constant releaseFactor : integer := 22 ;
		begin
			if resetN = '0' then
				amplifier <= (others => '0');
				state <= idle;
			elsif rising_edge (slowClk) then
				case state is
					when idle =>
						if en = '1' then
							state <= attack;
							amplifier <= (others => '0');
						end if;
					when attack =>
						if en = '0' then
							state <= decayReleased;
						elsif amplifier < 3200 then
							amplifier <= amplifier + attackFactor;
						else
							state <= decayPressed;
						end if;
					when decayPressed =>
						if en = '0' then
							state <= sustainReleased;
						elsif amplifier > 1600 then
							amplifier <= amplifier - decayFactor;
						else
							state <= sustainPressed;
						end if;	
					when decayReleased =>
						if en = '1' then
							state <= attack;
						elsif amplifier > 1600 then
							amplifier <= amplifier - decayFactor;
						else
							state <= sustainReleased;
						end if;	
					when sustainPressed =>
						if en = '0' then
							state <= releaseReleased;
						elsif amplifier > 800 then
							amplifier <= amplifier - sustainFactor;
						else
							state <= releasePressed;
						end if;	
					when sustainReleased =>
						if en = '1' then
							state <= attack;
						elsif amplifier > 800 then
							amplifier <= amplifier - sustainFactor;
						else
							state <= releaseReleased;
						end if;
					when releasePressed =>
						if en = '0' then
							state <= releaseReleased;
						elsif amplifier > releaseFactor then
							amplifier <= amplifier - releaseFactor;
						else
							amplifier <= (others => '0');	
						end if;
					when releaseReleased =>
						if en = '1' then
							state <= attack;
						elsif amplifier > releaseFactor then
							amplifier <= amplifier - releaseFactor;
						else
							amplifier <= (others => '0');
							state <= idle;
						end if;
				end case;	
			end if;
	end process;
end adsr_arch;