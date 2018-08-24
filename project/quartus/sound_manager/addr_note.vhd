LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

ENTITY addr_note IS
PORT (
			note1				: 	in std_logic_vector(15 downto 0);
			note2				: 	in std_logic_vector(15 downto 0);
			note3				: 	in std_logic_vector(15 downto 0);
			note4				: 	in std_logic_vector(15 downto 0);
			note5				: 	in std_logic_vector(15 downto 0);
			note6				: 	in std_logic_vector(15 downto 0);
			note7				: 	in std_logic_vector(15 downto 0);
			addr				: 	out std_logic_vector(15 downto 0)
		);

END addr_note;

architecture addr_note_arch of addr_note is
signal sum : std_logic_vector(15 downto 0);
begin

	addr <= sum;

	process (note1, note2, note3, note4, note5, note6, note7)	
	begin
		sum <= note1 + note2 + note3 + note4 + note5 + note6 + note7;
	end process;
end addr_note_arch ;