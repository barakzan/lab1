--mux9to1

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_signed.all ;

entity mux9to1 is
 port (ind : in std_logic_vector(8 downto 0) ;
		sel0 : in std_logic_vector(1 downto 0) ;
		sel1 : in std_logic_vector(1 downto 0) ;
		sel2 : in std_logic_vector(1 downto 0) ;
		selM : in std_logic_vector(1 downto 0) ;
		outd : out std_logic ) ;
 end mux9to1 ;

architecture arc_mux9to1 of mux9to1 is
		component mux_CA is
			port(ind : in std_logic_vector(2 downto 0 ) ;
				  sel : in std_logic_vector(1 downto 0) ;
				 outd : out std_logic ) ;
		end component ;
		
signal d0, d1, d2 : std_logic ;
			
 begin
		u0: mux_CA port map (ind=>ind(8 downto 6),sel=>sel0,outd=>d0) ;
		u1: mux_CA port map (ind=>ind(5 downto 3),sel=>sel0,outd=>d1) ;
		u2: mux_CA port map (ind=>ind(2 downto 0),sel=>sel0,outd=>d2) ;
		u3: mux_CA port map (ind=>(d0, d1, d2) ,sel=>selM,outd=>outd) ;	
 end arc_mux9to1 ;
	