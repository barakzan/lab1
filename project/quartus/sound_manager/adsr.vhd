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
  test_led					: out std_logic;
  out_note 					: out std_logic_vector(15 downto 0)
);
end adsr;

architecture adsr_arch of adsr is
begin
	PROCESS (CLK, resetN)
			BEGIN
				if resetN = '0' then
					out_note <= (others => '0');
					test_led <= '0';
				elsif(rising_edge(CLK)) then
					if en = '1' then
						out_note <= in_note;
						test_led <= '1';
					else
						out_note <= (others => '0');
						test_led <= '0';
					end if;
				end if;
	end process;
end adsr_arch;