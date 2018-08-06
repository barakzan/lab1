-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "08/07/2018 00:09:21"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          frequency_divider
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY frequency_divider_vhd_vec_tst IS
END frequency_divider_vhd_vec_tst;
ARCHITECTURE frequency_divider_arch OF frequency_divider_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLK : STD_LOGIC;
SIGNAL one_sec_flag : STD_LOGIC;
SIGNAL RESETN : STD_LOGIC;
COMPONENT frequency_divider
	PORT (
	CLK : IN STD_LOGIC;
	one_sec_flag : BUFFER STD_LOGIC;
	RESETN : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : frequency_divider
	PORT MAP (
-- list connections between master ports and signals
	CLK => CLK,
	one_sec_flag => one_sec_flag,
	RESETN => RESETN
	);

-- CLK
t_prcs_CLK: PROCESS
BEGIN
LOOP
	CLK <= '0';
	WAIT FOR 10000 ps;
	CLK <= '1';
	WAIT FOR 10000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_CLK;

-- RESETN
t_prcs_RESETN: PROCESS
BEGIN
	RESETN <= '0';
	WAIT FOR 70000 ps;
	RESETN <= '1';
	WAIT FOR 410000 ps;
	RESETN <= '0';
	WAIT FOR 20000 ps;
	RESETN <= '1';
WAIT;
END PROCESS t_prcs_RESETN;
END frequency_divider_arch;
