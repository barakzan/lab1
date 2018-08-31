--LIBRARY ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY addr_note IS
PORT (
			clk				: in std_logic;
			enables			: 	in std_logic_vector(6 downto 0);
			note0				: 	in std_logic_vector(15 downto 0);
			note1				: 	in std_logic_vector(15 downto 0);
			note2				: 	in std_logic_vector(15 downto 0);
			note3				: 	in std_logic_vector(15 downto 0);
			note4				: 	in std_logic_vector(15 downto 0);
			note5				: 	in std_logic_vector(15 downto 0);
			note6				: 	in std_logic_vector(15 downto 0);
			addr				: 	out std_logic_vector(15 downto 0)
		);

END addr_note;

architecture addr_note_arch of addr_note is
signal sum : std_logic_vector(15 downto 0);
signal temp_sum : std_logic_vector(15 downto 0);
signal numOfNotes : std_logic_vector(3 downto 0);
begin

	temp_sum <= std_logic_vector(  to_unsigned(to_integer(unsigned(sum)) / to_integer(unsigned(numOfNotes)),16));
	addr(13 downto 0) <= temp_sum(15 downto 2) ;
	addr(15 downto 14) <= "00";

	--addr <= sum;
	process (clk)	
	variable cnt : std_logic_vector(3 downto 0);
	begin
		if (rising_edge(clk)) then
		cnt := (others => '0');
		ens : for i in 0 to 6 loop
			if enables(i) = '1' then
				cnt := cnt + 1;
			end if;
		end loop ens;
		if cnt > 1 then
			cnt := ("0" & cnt(3 downto 1)) + "0010";
		else
			numOfNotes <= "0011";
		end if;
		--sum <= std_logic_vector(  to_unsigned(to_integer(unsigned(note1 + note2 + note3 + note4 + note5 + note6 + note7)) / 4 ,16));
		sum <= note0 + note1 + note2 + note3 + note4 + note5 + note6;
		end if;
	end process;
end addr_note_arch ;