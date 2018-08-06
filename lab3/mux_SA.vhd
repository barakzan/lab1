library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;

--mux_SA 3->1, in: ind, sel. out: outd
entity mux_SA is
 port (ind : in bit_vector(2 downto 0 ) ;
		sel : in bit_vector(1 downto 0) ;
		outd : out bit ) ;
 end mux_SA ;

architecture arc_mux_SA of mux_SA is
	begin
		with sel select
		outd <= ind(0) when "00"	,
				  ind(1) when "01"	,
				  ind(2) when others ;
	end arc_mux_SA ;