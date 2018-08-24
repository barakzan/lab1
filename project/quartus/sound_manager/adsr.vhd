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
				attack,	 -- 80ms
				decay,	 -- 64ms
				sustain,	 --4000ms
				release );--12ms

signal state : States;
signal slowClk : std_logic;
signal amplifier : std_logic_vector(17 downto 0); -- normlized to 128000	
--signal amplifier : integer  RANGE 0 to 131071;	
signal out_n : std_logic_vector(33 downto 0);

 begin
 
	slowClock: prescaler port map (
		CLK_IN=>CLK,
		resetN=>resetN,
		count_limit=>450000,
		prescaler_1=>slowClk) ;

	out_n <= in_note * amplifier;
	out_note	<= out_n(29 downto 14);
		
	PROCESS (clk,slowClk, resetN)
		begin
			if resetN = '0' then
				test_led <= '0';
				amplifier <= (others => '0');
				state <= idle;
			elsif(rising_edge(clk)) then
				if state /= idle and en = '0' then
					state <= release;
				end if;
				if slowClk = '1' then
					case state is
						when idle =>
							if en = '1' then
								state <= attack;
								amplifier(17 downto 1) <= (others => '0');
								amplifier(0) <= '1';
							end if;
						when attack =>
							if en = '0' then
								state <= release;
							elsif amplifier < 128000 then
								--amplifier <= amplifier * 16;
								amplifier(17 downto 4) <= amplifier(13 downto 0);
								amplifier(3 downto 0) <= (others => '0');
							else
								state <= decay;
							end if;
						when decay =>
							if en = '0' then
								state <= release;
							elsif amplifier > 32000 then
								--amplifier <= amplifier / 8;
								amplifier(14 downto 0) <= amplifier(17 downto 3);
								amplifier(17 downto 15) <= (others => '0');
							else
								state <= sustain;
							end if;	
						when sustain =>
							if en = '0' then
								state <= release;
							elsif amplifier > 16000 then
								--amplifier <= amplifier / 2;
								amplifier(16 downto 0) <= amplifier(17 downto 1);
								amplifier(17 downto 17) <= (others => '0');
							else
								state <= release;
							end if;	
						when release =>
							if amplifier > 1 then
								--amplifier <= amplifier / 8;
								amplifier(14 downto 0) <= amplifier(17 downto 3);
								amplifier(17 downto 15) <= (others => '0');
							else
								state <= idle;
							end if;
					end case;	
				end if;
			end if;
	end process;
end adsr_arch;