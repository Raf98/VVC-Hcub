-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "01/14/2024 04:43:45"
                                                            
-- Vhdl Test Bench template for design  :  DST7_DCT8_8x8
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;                                

ENTITY DST7_DCT8_16x16_TB IS
END DST7_DCT8_16x16_TB;
ARCHITECTURE DST7_DCT8_16x16_arch OF DST7_DCT8_16x16_TB IS
-- constants                                                 
-- signals
SIGNAL clk :  std_logic := '0';
SIGNAL reset :  std_logic := '0';
                                                   
SIGNAL op : STD_LOGIC := '0';
SIGNAL x0  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x1  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x2  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x3  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x4  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x5  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x6  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x7  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x8  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x9  : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x10 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x11 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x12 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x13 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x14 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x15 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x16 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x17 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x18 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x19 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x20 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x21 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x22 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x23 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x24 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x25 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x26 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x27 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x28 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x29 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x30 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x31 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x32 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x33 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x34 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x35 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x36 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x37 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x38 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x39 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x40 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x41 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x42 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x43 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x44 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x45 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x46 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x47 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x48 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x49 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x50 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x51 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x52 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x53 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x54 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x55 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x56 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x57 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x58 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x59 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x60 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x61 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x62 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";
SIGNAL x63 : STD_LOGIC_VECTOR(8 DOWNTO 0) := "000000000";

SIGNAL y0 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp0 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y1 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp1 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y2 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp2 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y3 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp3 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y4 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp4 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y5 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp5 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y6 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp6 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y7 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp7 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y8 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp8 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y9 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp9 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y10 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp10 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y11 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp11 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y12 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp12 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y13 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp13 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y14 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp14 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y15 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp15 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y16 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp16 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y17 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp17 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y18 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp18 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y19 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp19 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y20 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp20 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y21 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp21 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y22 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp22 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y23 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp23 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y24 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp24 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y25 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp25 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y26 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp26 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y27 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp27 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y28 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp28 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y29 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp29 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y30 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp30 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y31 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp31 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y32 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp32 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y33 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp33 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y34 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp34 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y35 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp35 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y36 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp36 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y37 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp37 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y38 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp38 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y39 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp39 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y40 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp40 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y41 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp41 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y42 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp42 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y43 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp43 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y44 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp44 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y45 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp45 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y46 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp46 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y47 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp47 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y48 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp48 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y49 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp49 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y50 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp50 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y51 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp51 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y52 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp52 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y53 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp53 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y54 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp54 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y55 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp55 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y56 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp56 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y57 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp57 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y58 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp58 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y59 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp59 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y60 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp60 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y61 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp61 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y62 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp62 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y63 : STD_LOGIC_VECTOR(19 DOWNTO 0);
SIGNAL y_exp63 : STD_LOGIC_VECTOR(19 DOWNTO 0);

--SIGNAL y_exp0 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp1 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp2 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp3 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp4 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp5 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp6 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp7 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp8 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp9 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp10 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp11 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp12 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp13 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp14 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp15 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp16 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp17 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp18 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp19 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp20 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp21 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp22 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp23 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp24 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp25 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp26 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp27 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp28 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp29 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp30 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp31 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp32 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp33 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp34 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp35 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp36 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp37 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp38 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp39 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp40 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp41 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp42 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp43 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp44 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp45 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp46 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp47 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp48 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp49 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp50 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp51 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp52 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp53 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp54 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp55 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp56 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp57 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp58 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp59 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp60 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp61 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp62 : STD_LOGIC_VECTOR(19 DOWNTO 0);
--SIGNAL y_exp63 : STD_LOGIC_VECTOR(19 DOWNTO 0);

COMPONENT DST7_DCT8_16x16
	PORT (
	op : IN STD_LOGIC := '0';
	x0 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x1 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x2 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x3 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x4 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x5 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x6 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x7 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x8 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x9 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x10 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x11 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x12 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x13 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x14 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x15 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x16 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x17 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x18 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x19 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x20 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x21 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x22 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x23 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x24 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x25 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x26 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x27 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x28 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x29 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x30 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x31 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x32 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x33 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x34 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x35 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x36 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x37 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x38 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x39 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x40 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x41 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x42 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x43 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x44 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x45 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x46 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x47 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x48 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x49 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x50 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x51 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x52 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x53 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x54 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x55 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x56 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x57 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x58 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x59 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x60 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x61 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x62 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	x63 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	y0 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y1 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y2 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y3 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y4 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y5 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y6 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y7 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y8 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y9 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y10 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y11 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y12 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y13 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y14 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y15 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y16 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y17 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y18 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y19 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y20 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y21 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y22 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y23 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y24 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y25 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y26 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y27 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y28 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y29 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y30 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y31 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y32 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y33 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y34 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y35 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y36 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y37 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y38 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y39 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y40 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y41 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y42 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y43 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y44 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y45 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y46 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y47 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y48 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y49 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y50 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y51 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y52 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y53 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y54 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y55 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y56 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y57 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y58 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y59 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y60 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y61 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y62 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
	y63 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
	);
END COMPONENT;

function str_to_stdvec(inp: string) return std_logic_vector is
	variable temp: std_logic_vector(inp'range);
	begin
		for i in inp'range loop
			if (inp(i) = '1') then
				temp(i) := '1';
			elsif (inp(i) = '0') then
				temp(i) := '0';
			end if;
		end loop;
		return temp;
	end function str_to_stdvec;

function stdvec_to_str(inp: std_logic_vector) return string is
		variable temp: string(inp'left+1 downto 1);
	begin
		for i in inp'reverse_range loop
			if (inp(i) = '1') then
				temp(i+1) := '1';
			elsif (inp(i) = '0') then
				temp(i+1) := '0';
			end if;
		end loop;
		return temp;
	end function stdvec_to_str;
	
	
procedure assign_input (variable inline: inout line; variable num_in: inout string; signal x: inout std_logic_vector; blank: inout string) is

	begin
	
		read(inline, num_in);
		x <= str_to_stdvec(num_in);
		read(inline, blank(1)); --le o espaco vazio entre os valores de cada linha de entrada

	end procedure assign_input;

procedure assign_output (variable outline: inout line; 
                         variable vec_out: inout std_logic_vector; 
								 variable str_out: inout string; 
								 signal y: in std_logic_vector; 
								 blank: inout string) is

	begin
		
		vec_out := y;
		str_out := stdvec_to_str(vec_out);
		write(outline, str_out);
		write(outline, blank(1));
	
	end procedure assign_output;
	
	
	file input, output_dct_exp, output_dst_exp, output_dct, output_dst: text;
	

BEGIN
	ARCH_16x16 : DST7_DCT8_16x16
	PORT MAP (
-- list connections between master ports and signals
	op => op,
	x0 => x0,
	x1 => x1,
	x2 => x2,
	x3 => x3,
	x4 => x4,
	x5 => x5,
	x6 => x6,
	x7 => x7,
	x8 => x8,
	x9 => x9,
	x10 => x10,
	x11 => x11,
	x12 => x12,
	x13 => x13,
	x14 => x14,
	x15 => x15,
	x16 => x16,
	x17 => x17,
	x18 => x18,
	x19 => x19,
	x20 => x20,
	x21 => x21,
	x22 => x22,
	x23 => x23,
	x24 => x24,
	x25 => x25,
	x26 => x26,
	x27 => x27,
	x28 => x28,
	x29 => x29,
	x30 => x30,
	x31 => x31,
	x32 => x32,
	x33 => x33,
	x34 => x34,
	x35 => x35,
	x36 => x36,
	x37 => x37,
	x38 => x38,
	x39 => x39,
	x40 => x40,
	x41 => x41,
	x42 => x42,
	x43 => x43,
	x44 => x44,
	x45 => x45,
	x46 => x46,
	x47 => x47,
	x48 => x48,
	x49 => x49,
	x50 => x50,
	x51 => x51,
	x52 => x52,
	x53 => x53,
	x54 => x54,
	x55 => x55,
	x56 => x56,
	x57 => x57,
	x58 => x58,
	x59 => x59,
	x60 => x60,
	x61 => x61,
	x62 => x62,
	x63 => x63,
	y0 => y0,
	y1 => y1,
	y2 => y2,
	y3 => y3,
	y4 => y4,
	y5 => y5,
	y6 => y6,
	y7 => y7,
	y8 => y8,
	y9 => y9,
	y10 => y10,
	y11 => y11,
	y12 => y12,
	y13 => y13,
	y14 => y14,
	y15 => y15,
	y16 => y16,
	y17 => y17,
	y18 => y18,
	y19 => y19,
	y20 => y20,
	y21 => y21,
	y22 => y22,
	y23 => y23,
	y24 => y24,
	y25 => y25,
	y26 => y26,
	y27 => y27,
	y28 => y28,
	y29 => y29,
	y30 => y30,
	y31 => y31,
	y32 => y32,
	y33 => y33,
	y34 => y34,
	y35 => y35,
	y36 => y36,
	y37 => y37,
	y38 => y38,
	y39 => y39,
	y40 => y40,
	y41 => y41,
	y42 => y42,
	y43 => y43,
	y44 => y44,
	y45 => y45,
	y46 => y46,
	y47 => y47,
	y48 => y48,
	y49 => y49,
	y50 => y50,
	y51 => y51,
	y52 => y52,
	y53 => y53,
	y54 => y54,
	y55 => y55,
	y56 => y56,
	y57 => y57,
	y58 => y58,
	y59 => y59,
	y60 => y60,
	y61 => y61,
	y62 => y62,
	y63 => y63
	);
	
	
	
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;

                                           
clock: PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
      clk <= '1', '0' AFTER 5 ns;
  		WAIT FOR 10 ns;                                                         
END PROCESS;

reset <= '1','0' after 0.5 ns;


stimulus_in: process 
	variable inline: line;
	--
	variable vec_out: std_logic_vector(19 downto 0);
	variable str_out: string(20 downto 1);
	variable outline: line;	
		--
	variable num_in: string(9 downto 1);
	variable num_out_exp: string(20 downto 1);
	variable blank: string(2 downto 1);
	
    begin
    
		FILE_OPEN(input, "../testbenchs/DST7-DCT8_input.txt", READ_MODE);

		FILE_OPEN(output_dct_exp, "../testbenchs/DCT8_16x16_output_exp.txt", READ_MODE);
		FILE_OPEN(output_dst_exp, "../testbenchs/DST7_16x16_output_exp.txt", READ_MODE);

--		FILE_OPEN(output_dct, "DCT8_16x16_output.txt", WRITE_MODE);
--		FILE_OPEN(output_dst, "DST7_16x16_output.txt", WRITE_MODE);

		op <= '0';
		
		wait until (reset = '0');
		while not endfile(input) loop
		
			--READING INPUTS
--			readline(input, inline);
--			read(inline, num_in);
--			x0 <= str_to_stdvec(num_in);
--			read(inline, blank(1)); --le o espaco vazio entre os valores de cada linha de entrada
			readline(input, inline);
			assign_input(inline, num_in, x0 , blank); 
			assign_input(inline, num_in, x1 , blank); 
			assign_input(inline, num_in, x2 , blank); 
			assign_input(inline, num_in, x3 , blank); 
			assign_input(inline, num_in, x4 , blank); 
			assign_input(inline, num_in, x5 , blank); 
			assign_input(inline, num_in, x6 , blank); 
			assign_input(inline, num_in, x7 , blank); 
			assign_input(inline, num_in, x8 , blank); 
			assign_input(inline, num_in, x9 , blank); 
			assign_input(inline, num_in, x10, blank); 
			assign_input(inline, num_in, x11, blank); 
			assign_input(inline, num_in, x12, blank); 
			assign_input(inline, num_in, x13, blank); 
			assign_input(inline, num_in, x14, blank); 
			assign_input(inline, num_in, x15, blank); 
			assign_input(inline, num_in, x16, blank); 
			assign_input(inline, num_in, x17, blank); 
			assign_input(inline, num_in, x18, blank); 
			assign_input(inline, num_in, x19, blank); 
			assign_input(inline, num_in, x20, blank); 
			assign_input(inline, num_in, x21, blank); 
			assign_input(inline, num_in, x22, blank); 
			assign_input(inline, num_in, x23, blank); 
			assign_input(inline, num_in, x24, blank); 
			assign_input(inline, num_in, x25, blank); 
			assign_input(inline, num_in, x26, blank); 
			assign_input(inline, num_in, x27, blank); 
			assign_input(inline, num_in, x28, blank); 
			assign_input(inline, num_in, x29, blank); 
			assign_input(inline, num_in, x30, blank); 
			assign_input(inline, num_in, x31, blank); 
			assign_input(inline, num_in, x32, blank); 
			assign_input(inline, num_in, x33, blank); 
			assign_input(inline, num_in, x34, blank); 
			assign_input(inline, num_in, x35, blank); 
			assign_input(inline, num_in, x36, blank); 
			assign_input(inline, num_in, x37, blank); 
			assign_input(inline, num_in, x38, blank); 
			assign_input(inline, num_in, x39, blank); 
			assign_input(inline, num_in, x40, blank); 
			assign_input(inline, num_in, x41, blank); 
			assign_input(inline, num_in, x42, blank); 
			assign_input(inline, num_in, x43, blank); 
			assign_input(inline, num_in, x44, blank); 
			assign_input(inline, num_in, x45, blank); 
			assign_input(inline, num_in, x46, blank); 
			assign_input(inline, num_in, x47, blank); 
			assign_input(inline, num_in, x48, blank); 
			assign_input(inline, num_in, x49, blank); 
			assign_input(inline, num_in, x50, blank); 
			assign_input(inline, num_in, x51, blank); 
			assign_input(inline, num_in, x52, blank); 
			assign_input(inline, num_in, x53, blank); 
			assign_input(inline, num_in, x54, blank); 
			assign_input(inline, num_in, x55, blank); 
			assign_input(inline, num_in, x56, blank); 
			assign_input(inline, num_in, x57, blank); 
			assign_input(inline, num_in, x58, blank); 
			assign_input(inline, num_in, x59, blank); 
			assign_input(inline, num_in, x60, blank); 
			assign_input(inline, num_in, x61, blank); 
			assign_input(inline, num_in, x62, blank); 
			assign_input(inline, num_in, x63, blank); 


			--READING EXPECTED DCT8 OUTPUTS TO COMPARE
			readline(output_dct_exp, inline);
			assign_input(inline, num_out_exp, y_exp0 , blank); 
			assign_input(inline, num_out_exp, y_exp1 , blank); 
			assign_input(inline, num_out_exp, y_exp2 , blank); 
			assign_input(inline, num_out_exp, y_exp3 , blank); 
			assign_input(inline, num_out_exp, y_exp4 , blank); 
			assign_input(inline, num_out_exp, y_exp5 , blank); 
			assign_input(inline, num_out_exp, y_exp6 , blank); 
			assign_input(inline, num_out_exp, y_exp7 , blank); 
			assign_input(inline, num_out_exp, y_exp8 , blank); 
			assign_input(inline, num_out_exp, y_exp9 , blank); 
			assign_input(inline, num_out_exp, y_exp10, blank); 
			assign_input(inline, num_out_exp, y_exp11, blank); 
			assign_input(inline, num_out_exp, y_exp12, blank); 
			assign_input(inline, num_out_exp, y_exp13, blank); 
			assign_input(inline, num_out_exp, y_exp14, blank); 
			assign_input(inline, num_out_exp, y_exp15, blank); 
			assign_input(inline, num_out_exp, y_exp16, blank); 
			assign_input(inline, num_out_exp, y_exp17, blank); 
			assign_input(inline, num_out_exp, y_exp18, blank); 
			assign_input(inline, num_out_exp, y_exp19, blank); 
			assign_input(inline, num_out_exp, y_exp20, blank); 
			assign_input(inline, num_out_exp, y_exp21, blank); 
			assign_input(inline, num_out_exp, y_exp22, blank); 
			assign_input(inline, num_out_exp, y_exp23, blank); 
			assign_input(inline, num_out_exp, y_exp24, blank); 
			assign_input(inline, num_out_exp, y_exp25, blank); 
			assign_input(inline, num_out_exp, y_exp26, blank); 
			assign_input(inline, num_out_exp, y_exp27, blank); 
			assign_input(inline, num_out_exp, y_exp28, blank); 
			assign_input(inline, num_out_exp, y_exp29, blank); 
			assign_input(inline, num_out_exp, y_exp30, blank); 
			assign_input(inline, num_out_exp, y_exp31, blank); 
			assign_input(inline, num_out_exp, y_exp32, blank); 
			assign_input(inline, num_out_exp, y_exp33, blank); 
			assign_input(inline, num_out_exp, y_exp34, blank); 
			assign_input(inline, num_out_exp, y_exp35, blank); 
			assign_input(inline, num_out_exp, y_exp36, blank); 
			assign_input(inline, num_out_exp, y_exp37, blank); 
			assign_input(inline, num_out_exp, y_exp38, blank); 
			assign_input(inline, num_out_exp, y_exp39, blank); 
			assign_input(inline, num_out_exp, y_exp40, blank); 
			assign_input(inline, num_out_exp, y_exp41, blank); 
			assign_input(inline, num_out_exp, y_exp42, blank); 
			assign_input(inline, num_out_exp, y_exp43, blank); 
			assign_input(inline, num_out_exp, y_exp44, blank); 
			assign_input(inline, num_out_exp, y_exp45, blank); 
			assign_input(inline, num_out_exp, y_exp46, blank); 
			assign_input(inline, num_out_exp, y_exp47, blank); 
			assign_input(inline, num_out_exp, y_exp48, blank); 
			assign_input(inline, num_out_exp, y_exp49, blank); 
			assign_input(inline, num_out_exp, y_exp50, blank); 
			assign_input(inline, num_out_exp, y_exp51, blank); 
			assign_input(inline, num_out_exp, y_exp52, blank); 
			assign_input(inline, num_out_exp, y_exp53, blank); 
			assign_input(inline, num_out_exp, y_exp54, blank); 
			assign_input(inline, num_out_exp, y_exp55, blank); 
			assign_input(inline, num_out_exp, y_exp56, blank); 
			assign_input(inline, num_out_exp, y_exp57, blank); 
			assign_input(inline, num_out_exp, y_exp58, blank); 
			assign_input(inline, num_out_exp, y_exp59, blank); 
			assign_input(inline, num_out_exp, y_exp60, blank); 
			assign_input(inline, num_out_exp, y_exp61, blank); 
			assign_input(inline, num_out_exp, y_exp62, blank); 
			assign_input(inline, num_out_exp, y_exp63, blank);
			
			wait until(clk'event and clk = '1');
			--wait until(clk'event and clk = '1');
			--wait until(clk'event and clk = '1');
			--wait until(clk'event and clk = '1');
			
			
			--WRITING OUTPUTS
			--assign_output(outline, vec_out, str_out, y0, blank);
--			assign_output(outline, vec_out, str_out, y0 , blank);
--			assign_output(outline, vec_out, str_out, y1 , blank);
--			assign_output(outline, vec_out, str_out, y2 , blank);
--			assign_output(outline, vec_out, str_out, y3 , blank);
--			assign_output(outline, vec_out, str_out, y4 , blank);
--			assign_output(outline, vec_out, str_out, y5 , blank);
--			assign_output(outline, vec_out, str_out, y6 , blank);
--			assign_output(outline, vec_out, str_out, y7 , blank);
--			assign_output(outline, vec_out, str_out, y8 , blank);
--			assign_output(outline, vec_out, str_out, y9 , blank);
--			assign_output(outline, vec_out, str_out, y10, blank);
--			assign_output(outline, vec_out, str_out, y11, blank);
--			assign_output(outline, vec_out, str_out, y12, blank);
--			assign_output(outline, vec_out, str_out, y13, blank);
--			assign_output(outline, vec_out, str_out, y14, blank);
--			assign_output(outline, vec_out, str_out, y15, blank);
--			assign_output(outline, vec_out, str_out, y16, blank);
--			assign_output(outline, vec_out, str_out, y17, blank);
--			assign_output(outline, vec_out, str_out, y18, blank);
--			assign_output(outline, vec_out, str_out, y19, blank);
--			assign_output(outline, vec_out, str_out, y20, blank);
--			assign_output(outline, vec_out, str_out, y21, blank);
--			assign_output(outline, vec_out, str_out, y22, blank);
--			assign_output(outline, vec_out, str_out, y23, blank);
--			assign_output(outline, vec_out, str_out, y24, blank);
--			assign_output(outline, vec_out, str_out, y25, blank);
--			assign_output(outline, vec_out, str_out, y26, blank);
--			assign_output(outline, vec_out, str_out, y27, blank);
--			assign_output(outline, vec_out, str_out, y28, blank);
--			assign_output(outline, vec_out, str_out, y29, blank);
--			assign_output(outline, vec_out, str_out, y30, blank);
--			assign_output(outline, vec_out, str_out, y31, blank);
--			assign_output(outline, vec_out, str_out, y32, blank);
--			assign_output(outline, vec_out, str_out, y33, blank);
--			assign_output(outline, vec_out, str_out, y34, blank);
--			assign_output(outline, vec_out, str_out, y35, blank);
--			assign_output(outline, vec_out, str_out, y36, blank);
--			assign_output(outline, vec_out, str_out, y37, blank);
--			assign_output(outline, vec_out, str_out, y38, blank);
--			assign_output(outline, vec_out, str_out, y39, blank);
--			assign_output(outline, vec_out, str_out, y40, blank);
--			assign_output(outline, vec_out, str_out, y41, blank);
--			assign_output(outline, vec_out, str_out, y42, blank);
--			assign_output(outline, vec_out, str_out, y43, blank);
--			assign_output(outline, vec_out, str_out, y44, blank);
--			assign_output(outline, vec_out, str_out, y45, blank);
--			assign_output(outline, vec_out, str_out, y46, blank);
--			assign_output(outline, vec_out, str_out, y47, blank);
--			assign_output(outline, vec_out, str_out, y48, blank);
--			assign_output(outline, vec_out, str_out, y49, blank);
--			assign_output(outline, vec_out, str_out, y50, blank);
--			assign_output(outline, vec_out, str_out, y51, blank);
--			assign_output(outline, vec_out, str_out, y52, blank);
--			assign_output(outline, vec_out, str_out, y53, blank);
--			assign_output(outline, vec_out, str_out, y54, blank);
--			assign_output(outline, vec_out, str_out, y55, blank);
--			assign_output(outline, vec_out, str_out, y56, blank);
--			assign_output(outline, vec_out, str_out, y57, blank);
--			assign_output(outline, vec_out, str_out, y58, blank);
--			assign_output(outline, vec_out, str_out, y59, blank);
--			assign_output(outline, vec_out, str_out, y60, blank);
--			assign_output(outline, vec_out, str_out, y61, blank);
--			assign_output(outline, vec_out, str_out, y62, blank);
--			assign_output(outline, vec_out, str_out, y63, blank);
--			
--			writeline(output_dct, outline);
			
			
			op <= '1';

			--READING EXPECTED DST7 OUTPUTS TO COMPARE
			readline(output_dst_exp, inline);
			assign_input(inline, num_out_exp, y_exp0 , blank); 
			assign_input(inline, num_out_exp, y_exp1 , blank); 
			assign_input(inline, num_out_exp, y_exp2 , blank); 
			assign_input(inline, num_out_exp, y_exp3 , blank); 
			assign_input(inline, num_out_exp, y_exp4 , blank); 
			assign_input(inline, num_out_exp, y_exp5 , blank); 
			assign_input(inline, num_out_exp, y_exp6 , blank); 
			assign_input(inline, num_out_exp, y_exp7 , blank); 
			assign_input(inline, num_out_exp, y_exp8 , blank); 
			assign_input(inline, num_out_exp, y_exp9 , blank); 
			assign_input(inline, num_out_exp, y_exp10, blank); 
			assign_input(inline, num_out_exp, y_exp11, blank); 
			assign_input(inline, num_out_exp, y_exp12, blank); 
			assign_input(inline, num_out_exp, y_exp13, blank); 
			assign_input(inline, num_out_exp, y_exp14, blank); 
			assign_input(inline, num_out_exp, y_exp15, blank); 
			assign_input(inline, num_out_exp, y_exp16, blank); 
			assign_input(inline, num_out_exp, y_exp17, blank); 
			assign_input(inline, num_out_exp, y_exp18, blank); 
			assign_input(inline, num_out_exp, y_exp19, blank); 
			assign_input(inline, num_out_exp, y_exp20, blank); 
			assign_input(inline, num_out_exp, y_exp21, blank); 
			assign_input(inline, num_out_exp, y_exp22, blank); 
			assign_input(inline, num_out_exp, y_exp23, blank); 
			assign_input(inline, num_out_exp, y_exp24, blank); 
			assign_input(inline, num_out_exp, y_exp25, blank); 
			assign_input(inline, num_out_exp, y_exp26, blank); 
			assign_input(inline, num_out_exp, y_exp27, blank); 
			assign_input(inline, num_out_exp, y_exp28, blank); 
			assign_input(inline, num_out_exp, y_exp29, blank); 
			assign_input(inline, num_out_exp, y_exp30, blank); 
			assign_input(inline, num_out_exp, y_exp31, blank); 
			assign_input(inline, num_out_exp, y_exp32, blank); 
			assign_input(inline, num_out_exp, y_exp33, blank); 
			assign_input(inline, num_out_exp, y_exp34, blank); 
			assign_input(inline, num_out_exp, y_exp35, blank); 
			assign_input(inline, num_out_exp, y_exp36, blank); 
			assign_input(inline, num_out_exp, y_exp37, blank); 
			assign_input(inline, num_out_exp, y_exp38, blank); 
			assign_input(inline, num_out_exp, y_exp39, blank); 
			assign_input(inline, num_out_exp, y_exp40, blank); 
			assign_input(inline, num_out_exp, y_exp41, blank); 
			assign_input(inline, num_out_exp, y_exp42, blank); 
			assign_input(inline, num_out_exp, y_exp43, blank); 
			assign_input(inline, num_out_exp, y_exp44, blank); 
			assign_input(inline, num_out_exp, y_exp45, blank); 
			assign_input(inline, num_out_exp, y_exp46, blank); 
			assign_input(inline, num_out_exp, y_exp47, blank); 
			assign_input(inline, num_out_exp, y_exp48, blank); 
			assign_input(inline, num_out_exp, y_exp49, blank); 
			assign_input(inline, num_out_exp, y_exp50, blank); 
			assign_input(inline, num_out_exp, y_exp51, blank); 
			assign_input(inline, num_out_exp, y_exp52, blank); 
			assign_input(inline, num_out_exp, y_exp53, blank); 
			assign_input(inline, num_out_exp, y_exp54, blank); 
			assign_input(inline, num_out_exp, y_exp55, blank); 
			assign_input(inline, num_out_exp, y_exp56, blank); 
			assign_input(inline, num_out_exp, y_exp57, blank); 
			assign_input(inline, num_out_exp, y_exp58, blank); 
			assign_input(inline, num_out_exp, y_exp59, blank); 
			assign_input(inline, num_out_exp, y_exp60, blank); 
			assign_input(inline, num_out_exp, y_exp61, blank); 
			assign_input(inline, num_out_exp, y_exp62, blank); 
			assign_input(inline, num_out_exp, y_exp63, blank);
			
			wait until(clk'event and clk = '1');
			
--			assign_output(outline, vec_out, str_out, y0 , blank);
--			assign_output(outline, vec_out, str_out, y1 , blank);
--			assign_output(outline, vec_out, str_out, y2 , blank);
--			assign_output(outline, vec_out, str_out, y3 , blank);
--			assign_output(outline, vec_out, str_out, y4 , blank);
--			assign_output(outline, vec_out, str_out, y5 , blank);
--			assign_output(outline, vec_out, str_out, y6 , blank);
--			assign_output(outline, vec_out, str_out, y7 , blank);
--			assign_output(outline, vec_out, str_out, y8 , blank);
--			assign_output(outline, vec_out, str_out, y9 , blank);
--			assign_output(outline, vec_out, str_out, y10, blank);
--			assign_output(outline, vec_out, str_out, y11, blank);
--			assign_output(outline, vec_out, str_out, y12, blank);
--			assign_output(outline, vec_out, str_out, y13, blank);
--			assign_output(outline, vec_out, str_out, y14, blank);
--			assign_output(outline, vec_out, str_out, y15, blank);
--			assign_output(outline, vec_out, str_out, y16, blank);
--			assign_output(outline, vec_out, str_out, y17, blank);
--			assign_output(outline, vec_out, str_out, y18, blank);
--			assign_output(outline, vec_out, str_out, y19, blank);
--			assign_output(outline, vec_out, str_out, y20, blank);
--			assign_output(outline, vec_out, str_out, y21, blank);
--			assign_output(outline, vec_out, str_out, y22, blank);
--			assign_output(outline, vec_out, str_out, y23, blank);
--			assign_output(outline, vec_out, str_out, y24, blank);
--			assign_output(outline, vec_out, str_out, y25, blank);
--			assign_output(outline, vec_out, str_out, y26, blank);
--			assign_output(outline, vec_out, str_out, y27, blank);
--			assign_output(outline, vec_out, str_out, y28, blank);
--			assign_output(outline, vec_out, str_out, y29, blank);
--			assign_output(outline, vec_out, str_out, y30, blank);
--			assign_output(outline, vec_out, str_out, y31, blank);
--			assign_output(outline, vec_out, str_out, y32, blank);
--			assign_output(outline, vec_out, str_out, y33, blank);
--			assign_output(outline, vec_out, str_out, y34, blank);
--			assign_output(outline, vec_out, str_out, y35, blank);
--			assign_output(outline, vec_out, str_out, y36, blank);
--			assign_output(outline, vec_out, str_out, y37, blank);
--			assign_output(outline, vec_out, str_out, y38, blank);
--			assign_output(outline, vec_out, str_out, y39, blank);
--			assign_output(outline, vec_out, str_out, y40, blank);
--			assign_output(outline, vec_out, str_out, y41, blank);
--			assign_output(outline, vec_out, str_out, y42, blank);
--			assign_output(outline, vec_out, str_out, y43, blank);
--			assign_output(outline, vec_out, str_out, y44, blank);
--			assign_output(outline, vec_out, str_out, y45, blank);
--			assign_output(outline, vec_out, str_out, y46, blank);
--			assign_output(outline, vec_out, str_out, y47, blank);
--			assign_output(outline, vec_out, str_out, y48, blank);
--			assign_output(outline, vec_out, str_out, y49, blank);
--			assign_output(outline, vec_out, str_out, y50, blank);
--			assign_output(outline, vec_out, str_out, y51, blank);
--			assign_output(outline, vec_out, str_out, y52, blank);
--			assign_output(outline, vec_out, str_out, y53, blank);
--			assign_output(outline, vec_out, str_out, y54, blank);
--			assign_output(outline, vec_out, str_out, y55, blank);
--			assign_output(outline, vec_out, str_out, y56, blank);
--			assign_output(outline, vec_out, str_out, y57, blank);
--			assign_output(outline, vec_out, str_out, y58, blank);
--			assign_output(outline, vec_out, str_out, y59, blank);
--			assign_output(outline, vec_out, str_out, y60, blank);
--			assign_output(outline, vec_out, str_out, y61, blank);
--			assign_output(outline, vec_out, str_out, y62, blank);
--			assign_output(outline, vec_out, str_out, y63, blank);
--			
--			writeline(output_dst, outline);
			
			op <= '0';
			
			
		end loop;		
		
		file_close(input);
		file_close(output_dct_exp);
		file_close(output_dst_exp);
		assert false report "end of simulation" severity failure;
		--writeline(output, outline);
		wait;
	end process;                                     
END DST7_DCT8_16x16_arch;
