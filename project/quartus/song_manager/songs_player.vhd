library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity songs_player is
   port ( resetN   : in  std_logic                    ;
          clk      : in  std_logic                    ;
          enable	 : in  std_logic                    ;
          dout     : out std_logic_vector(11 downto 0) ) ;

end songs_player;

architecture songs_player_arch of songs_player is

constant array_size 			: integer := 53 ;

type table_type is array(0 to array_size - 1) of std_logic_vector(11 downto 0);
signal notes_table				: table_type;

begin

	process(clk)
	constant notes_table : table_type := (
"000010000000",
"000010000000",
"000010000000",
"000010000000",
"000010000000",
"000000000000",
"000000000000",
"000000000000",
"001000000000",
"001000000000",
"001000000000",
"001000000000",
"001000000000",
"000000000000",
"000000000000",
"000000000000",
"001000000000",
"001000000000",
"001000000000",
"001000000000",
"001000000000",
"000000000000",
"000000000000",
"000000000000",
"000100000000",
"000100000000",
"000100000000",
"000100000000",
"000100000000",
"000000000000",
"000000000000",
"000000000000",
"010000000000",
"010000000000",
"010000000000",
"010000000000",
"010000000000",
"000000000000",
"000000000000",
"000000000000",
"010000000000",
"010000000000",
"010000000000",
"010000000000",
"010000000000",
"000000000000",
"000000000000",
"000000000000",
"100000000000",
"100000000000",
"100000000000",
"100000000000",
"100000000000"
);

	variable addr_counter : integer;
	begin
		if resetN = '0' then
			addr_counter := 0;
		elsif rising_edge(clk) and enable = '1' then
			if addr_counter < array_size then
				dout <= notes_table(addr_counter);
				addr_counter := addr_counter + 1;
			else
				dout <= (others => '0');
			end if;		
		end if;
	
	end process;


end songs_player_arch;
