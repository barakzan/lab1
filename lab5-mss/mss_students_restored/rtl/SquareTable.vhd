--------------------------------------
-- SinTable.vhd
-- Written by Gadi and Eran Tuchman.
-- All rights reserved, Copyright 2009
--------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all ;

entity squaretable is
port(
  CLK     					: in std_logic;
  resetN 					: in std_logic;
  ADDR    					: in std_logic_vector(7 downto 0);
  Q       					: out std_logic_vector(15 downto 0)
);
end squaretable;

architecture arch_squaretable of squaretable is
constant array_size 			: integer := 256 ;

type table_type is array(0 to array_size - 1) of std_logic_vector(15 downto 0);
signal square_table				: table_type;
signal Q_tmp       			:  std_logic_vector(15 downto 0) ;


begin
 
  sintable_proc: process(resetN, CLK)
    constant square_table : table_type := (
---start 0 v
X"4000",
X"3F01",
X"3E04",
X"3D09",
X"3C10",
X"3B19",
X"3A24",
X"3931",
X"3840",
X"3751",
X"3664",
X"3579",
X"3490",
X"33A9",
X"32C4",
X"31E1",
X"3100",
X"3021",
X"2F44",
X"2E69",
X"2D90",
X"2CB9",
X"2BE4",
X"2B11",
X"2A40",
X"2971",
X"28A4",
X"27D9",
X"2710",
X"2649",
X"2584",
X"24C1",
X"2400",
X"2341",
X"2284",
X"21C9",
X"2110",
X"2059",
X"1FA4",
X"1EF1",
X"1E40",
X"1D91",
X"1CE4",
X"1C39",
X"1B90",
X"1AE9",
X"1A44",
X"19A1",
X"1900",
X"1861",
X"17C4",
X"1729",
X"1690",
X"15F9",
X"1564",
X"14D1",
X"1440",
X"13B1",
X"1324",
X"1299",
X"1210",
X"1189",
X"1104",
X"1081",
X"1000",
X"0F81",
X"0F04",
X"0E89",
X"0E10",
X"0D99",
X"0D24",
X"0CB1",
X"0C40",
X"0BD1",
X"0B64",
X"0AF9",
X"0A90",
X"0A29",
X"09C4",
X"0961",
X"0900",
X"08A1",
X"0844",
X"07E9",
X"0790",
X"0739",
X"06E4",
X"0691",
X"0640",
X"05F1",
X"05A4",
X"0559",
X"0510",
X"04C9",
X"0484",
X"0441",
X"0400",
X"03C1",
X"0384",
X"0349",
X"0310",
X"02D9",
X"02A4",
X"0271",
X"0240",
X"0211",
X"01E4",
X"01B9",
X"0190",
X"0169",
X"0144",
X"0121",
X"0100",
X"00E1",
X"00C4",
X"00A9",
X"0090",
X"0079",
X"0064",
X"0051",
X"0040",
X"0031",
X"0024",
X"0019",
X"0010",
X"0009",
X"0004",
X"0001",
X"0000",
X"0001",
X"0004",
X"0009",
X"0010",
X"0019",
X"0024",
X"0031",
X"0040",
X"0051",
X"0064",
X"0079",
X"0090",
X"00A9",
X"00C4",
X"00E1",
X"0100",
X"0121",
X"0144",
X"0169",
X"0190",
X"01B9",
X"01E4",
X"0211",
X"0240",
X"0271",
X"02A4",
X"02D9",
X"0310",
X"0349",
X"0384",
X"03C1",
X"0400",
X"0441",
X"0484",
X"04C9",
X"0510",
X"0559",
X"05A4",
X"05F1",
X"0640",
X"0691",
X"06E4",
X"0739",
X"0790",
X"07E9",
X"0844",
X"08A1",
X"0900",
X"0961",
X"09C4",
X"0A29",
X"0A90",
X"0AF9",
X"0B64",
X"0BD1",
X"0C40",
X"0CB1",
X"0D24",
X"0D99",
X"0E10",
X"0E89",
X"0F04",
X"0F81",
X"1000",
X"1081",
X"1104",
X"1189",
X"1210",
X"1299",
X"1324",
X"13B1",
X"1440",
X"14D1",
X"1564",
X"15F9",
X"1690",
X"1729",
X"17C4",
X"1861",
X"1900",
X"19A1",
X"1A44",
X"1AE9",
X"1B90",
X"1C39",
X"1CE4",
X"1D91",
X"1E40",
X"1EF1",
X"1FA4",
X"2059",
X"2110",
X"21C9",
X"2284",
X"2341",
X"2400",
X"24C1",
X"2584",
X"2649",
X"2710",
X"27D9",
X"28A4",
X"2971",
X"2A40",
X"2B11",
X"2BE4",
X"2CB9",
X"2D90",
X"2E69",
X"2F44",
X"3021",
X"3100",
X"31E1",
X"32C4",
X"33A9",
X"3490",
X"3579",
X"3664",
X"3751",
X"3840",
X"3931",
X"3A24",
X"3B19",
X"3C10",
X"3D09",
X"3E04",
X"3F01"
 );

 
 begin

    if (resetN='0') then
		Q_tmp <= ( others => '0');
    elsif(rising_edge(CLK)) then
--      if (ENA='1') then
		Q_tmp <= square_table(conv_integer(ADDR));
--      end if;
   end if;
  end process;
 Q <= Q_tmp; 

		   
end arch_squaretable;