library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all ;

entity songs_player is
   port ( resetN     : in  std_logic                       ;
          clk        : in  std_logic                       ;
          enable	   : in  std_logic                       ;
			 delay	   : in  std_logic_vector(6 downto 0)   ;
			 new_note   : out std_logic							  ;
          dout_draw  : out std_logic_vector(11 downto 0)   ;
			 dout_sound : out std_logic_vector(11 downto 0)
		   )  ;

end songs_player;

architecture songs_player_arch of songs_player is

constant array_size 			: integer := 53 ;

type table_type is array(0 to array_size - 1) of std_logic_vector(11 downto 0);
signal notes_table				: table_type;

begin

	process(clk)
	constant notes_table : table_type := (
"000010000000",-- 5 X "000010000000"
"000010000000",
"000010000000",
"000010000000",
"000010000000",
"000000000000",-- 3 X "000000000000"
"000000000000",
"000000000000",
"001000000000",-- 5 X "001000000000"
"001000000000",
"001000000000",
"001000000000",
"001000000000",
"000000000000",-- 3 X "000000000000"
"000000000000",
"000000000000",
"001000000000",-- 5 X "001000000000"
"001000000000",
"001000000000",
"001000000000",
"001000000000",
"000000000000",-- 3 X "000000000000"
"000000000000",
"000000000000",
"000100000000",-- 5 X "000100000000"
"000100000000",
"000100000000",
"000100000000",
"000100000000",
"000000000000",-- 3 X "000000000000"
"000000000000",
"000000000000",
"010000000000",-- 5 X "010000000000"
"010000000000",
"010000000000",
"010000000000",
"010000000000",
"000000000000",-- 3 X "000000000000"
"000000000000",
"000000000000",
"010000000000",-- 5 X "010000000000"
"010000000000",
"010000000000",
"010000000000",
"010000000000",
"000000000000",-- 3 X "000000000000"
"000000000000",
"000000000000",
"100000000000",-- 5 X "100000000000"
"100000000000",
"100000000000",
"100000000000",
"100000000000"
);

variable addr : integer;
	begin
			
		if resetN = '0' then
		   addr := 0;
			dout_draw  <= (others => '0');
			dout_sound <= (others => '0');
			new_note <= '0';
			
		elsif rising_edge(clk) then
		
			new_note <= '0';
			if enable = '1' then
				
				if addr < ("0000000" & delay) or addr >= array_size + ("0000000" & delay) then
					dout_sound <= (others => '0');
				else
					dout_sound <= notes_table(to_integer(unsigned(addr - ("0000000" & delay))));
				end if;		
				
				if addr < array_size then
					dout_draw <= notes_table(addr);
				else
					dout_draw <= (others => '0');
				end if;
				
				if addr <= array_size + ("0000000" & delay) then
					addr := addr + 1;
					new_note <= '1';
				end if;
				
			end if;
		end if;
	end process;

end songs_player_arch;
