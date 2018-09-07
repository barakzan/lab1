library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;

entity mux48to24 is
 port (keys  : in std_logic_vector(23 downto 0) ;
		 notes : in std_logic_vector(23 downto 0) ;
		 sel   : in std_logic;
		 outd  : out std_logic_vector(23 downto 0) 
		 );
 end mux48to24 ;

architecture arc_mux48to24 of mux48to24 is			
 begin
	outd <= keys when sel = '0' else notes;
 
 end arc_mux48to24 ;
	