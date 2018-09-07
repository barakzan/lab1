library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all ;


entity vol_ctl is
port(
  clk     					: in std_logic;
  resetN 					: in std_logic;
  vol_up						: in std_logic;
  vol_down					: in std_logic;
  sound_in 					: in std_logic_vector(15 downto 0);
  sound_out 				: out std_logic_vector(15 downto 0);
  vol_out					: out std_logic_vector(3 downto 0)
);
end vol_ctl;

architecture vol_ctl_arch of vol_ctl is

signal volume : std_logic_vector(3 downto 0);
signal temp : std_logic_vector(20 downto 0);

 begin

vol_out <= volume - 3;
temp <= sound_in * (volume & "0");
sound_out <= temp(19 downto 4);
 
process(clk, resetN)
 begin
		if resetN = '0' then
			volume <= "0111";
		elsif rising_edge (clk) then
			if vol_up = '1' then
				if volume /= "1100" then
					volume <= volume + 1;
				end if;
			elsif vol_down = '1' then
				if volume /= "0100" then
					volume <= volume - 1;
				end if;
			end if;
		end if;
 end process;
end vol_ctl_arch;