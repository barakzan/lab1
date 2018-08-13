LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

ENTITY data_conversion IS
GENERIC ( COUNT_SIZE		: INTEGER := 16);
PORT (
			CLK_IN		   :	IN	STD_LOGIC;	
			resetN			:	IN	STD_LOGIC;
			MUX				:  IN std_logic_vector(2 downto 0);
			data_in			:	IN std_logic_vector(COUNT_SIZE - 1 downto 0);
			
			data_out			:  out std_logic_vector(COUNT_SIZE - 1 downto 0)
		);

END data_conversion;


	
architecture arch_data_conversion of data_conversion is
begin
		process(CLK_IN, resetN)
		begin
			if resetN = '0' then
				data_out <= (others => '0');
			elsif rising_edge(CLK_IN) then
				case MUX is
					when "000" =>
						data_out <= data_in;
					when "001" =>
						if data_in < 0 then
							data_out <= (others => '0');
						else
							data_out <= data_in;
						end if;
					when "010" =>
						data_out <= (not data_in) + 1; -- inverse
					when "011" =>
						if data_in < 0 then
							data_out <= (not data_in) + 1;
						else
							data_out <= data_in;
						end if;
					when "100" =>
						data_out(COUNT_SIZE - 1 downto 2) <= data_in(COUNT_SIZE - 1 downto 2);
						data_out(1 downto 0) <= (others => '0');
					when "101" =>
						data_out(COUNT_SIZE - 1 downto 10) <= data_in(COUNT_SIZE - 1 downto 10);
						data_out(9 downto 0) <= (others => '0');
					when "110" =>
						data_out(COUNT_SIZE - 1 downto 0) <= data_in(COUNT_SIZE - 1) & 
													data_in(COUNT_SIZE - 1 downto 1);
					when "111" =>
						data_out(COUNT_SIZE - 1 downto 0) <= data_in(COUNT_SIZE - 1 downto 0) + 
													(data_in(COUNT_SIZE - 1) & data_in(COUNT_SIZE - 1 downto 1));
				end case;
			end if;
			
		end process;
end arch_data_conversion ;