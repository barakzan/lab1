library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;

entity mux_CA is
 port (ind : in bit_vector(2 downto 0 ) ;
		sel : in bit_vector(1 downto 0) ;
		outd : out bit ) ;
 end mux_CA ;

architecture arc_mux_CA of mux_CA is
	begin
		outd <= ind(0) when (sel="00") else ind(1) when (sel="01") else ind(2) ;
	end arc_mux_CA ;
	
	