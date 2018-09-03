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
			note7				: 	in std_logic_vector(15 downto 0);
			note8				: 	in std_logic_vector(15 downto 0);
			note9				: 	in std_logic_vector(15 downto 0);
			note10			: 	in std_logic_vector(15 downto 0);
			note11			: 	in std_logic_vector(15 downto 0);
			note12			: 	in std_logic_vector(15 downto 0);
			note13			: 	in std_logic_vector(15 downto 0);
			note14			: 	in std_logic_vector(15 downto 0);
			note15			: 	in std_logic_vector(15 downto 0);
			note16			: 	in std_logic_vector(15 downto 0);
			note17			: 	in std_logic_vector(15 downto 0);
			note18			: 	in std_logic_vector(15 downto 0);
			note19			: 	in std_logic_vector(15 downto 0);
			note20			: 	in std_logic_vector(15 downto 0);
			note21			: 	in std_logic_vector(15 downto 0);
			note22			: 	in std_logic_vector(15 downto 0);
			note23			: 	in std_logic_vector(15 downto 0);
			addr				: 	out std_logic_vector(15 downto 0)
		);

END addr_note;

architecture addr_note_arch of addr_note is
signal sum : std_logic_vector(15 downto 0);
signal temp_sum : std_logic_vector(15 downto 0);
signal numOfNotes : std_logic_vector(3 downto 0);
begin

	temp_sum <= std_logic_vector(  to_unsigned(to_integer(unsigned(sum)) / to_integer(unsigned(numOfNotes)),16));
	--addr(13 downto 0) <= temp_sum(15 downto 2) ;
	--addr(15 downto 14) <= "00";
	addr <= temp_sum;
	
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
		sum <= ("00"&note0(13 downto 0)) +("00"&note1(13 downto 0)) +("00"&note2(13 downto 0)) +("00"&note3(13 downto 0)) +
				 ("00"&note4(13 downto 0)) +("00"&note5(13 downto 0)) +("00"&note6(13 downto 0)) +("00"&note7(13 downto 0)) +
				 ("00"&note8(13 downto 0)) +("00"&note9(13 downto 0)) +("00"&note10(13 downto 0))+("00"&note11(13 downto 0))+
				 ("00"&note12(13 downto 0))+("00"&note13(13 downto 0))+("00"&note14(13 downto 0))+("00"&note15(13 downto 0))+
				 ("00"&note16(13 downto 0))+("00"&note17(13 downto 0))+("00"&note18(13 downto 0))+("00"&note19(13 downto 0))+
				 ("00"&note20(13 downto 0))+("00"&note21(13 downto 0))+("00"&note22(13 downto 0))+("00"&note23(13 downto 0));
		end if;
	end process;
end addr_note_arch ;