-- DST-VII 1D 8x8 utilizando MCU com Hcub para a multiplicação
-- e Macro Function para as somas
-- Rafael Santos; André Marcelo Coelho da Silva
-- Created: 18/12/2023


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


	
entity DST7_DCT8_16x16 is
generic(
	Nbits				:  integer := 9;
	inBits			:	integer := 9;
	numInOutputs	:	integer := 64;
	outBits			:	integer := 19;
	rNum				:  integer := 4;
	numTr				:  integer := 4
);
port(	
		op                                 	  : in  std_logic;
		x0 ,x1 ,x2 ,x3 ,x4 ,x5 ,x6 ,x7        : in std_logic_vector(inBits - 1 downto 0);
		x8 ,x9 ,x10 ,x11 ,x12 ,x13 ,x14 ,x15  : in std_logic_vector(inBits - 1 downto 0);
		x16 ,x17 ,x18 ,x19 ,x20 ,x21 ,x22 ,x23: in std_logic_vector(inBits - 1 downto 0);
		x24 ,x25 ,x26 ,x27 ,x28 ,x29 ,x30 ,x31: in std_logic_vector(inBits - 1 downto 0);
		x32 ,x33 ,x34 ,x35 ,x36 ,x37 ,x38 ,x39: in std_logic_vector(inBits - 1 downto 0);
		x40 ,x41 ,x42 ,x43 ,x44 ,x45 ,x46 ,x47: in std_logic_vector(inBits - 1 downto 0);
		x48 ,x49 ,x50 ,x51 ,x52 ,x53 ,x54 ,x55: in std_logic_vector(inBits - 1 downto 0);
		x56 ,x57 ,x58 ,x59 ,x60 ,x61 ,x62 ,x63: in std_logic_vector(inBits - 1 downto 0);
		
		y0, y1, y2, y3, y4, y5, y6, y7		  : out std_logic_vector(outBits   downto 0);
		y8, y9, y10, y11, y12, y13, y14, y15  : out std_logic_vector(outBits   downto 0);
		y16, y17, y18, y19, y20, y21, y22, y23: out std_logic_vector(outBits   downto 0);
		y24, y25, y26, y27, y28, y29, y30, y31: out std_logic_vector(outBits   downto 0);
		y32, y33, y34, y35, y36, y37, y38, y39: out std_logic_vector(outBits   downto 0);
		y40, y41, y42, y43, y44, y45, y46, y47: out std_logic_vector(outBits   downto 0);
		y48, y49, y50, y51, y52, y53, y54, y55: out std_logic_vector(outBits   downto 0);
		y56, y57, y58, y59, y60, y61, y62, y63: out std_logic_vector(outBits   downto 0)
);

end DST7_DCT8_16x16;


architecture behavior of DST7_DCT8_16x16 is
		
		Component MCUHcub_DST7_DCT8_16x16 is
			PORT( 
				x 		: in  std_logic_vector (inBits - 1 downto 0);
				x8		: out std_logic_vector (outBits downto 0);
				x17	: out std_logic_vector (outBits downto 0);
				x25 	: out std_logic_vector (outBits downto 0);
				x33 	: out std_logic_vector (outBits downto 0);
				x40 	: out std_logic_vector (outBits downto 0);
				x48 	: out std_logic_vector (outBits downto 0);
				x55 	: out std_logic_vector (outBits downto 0);
				x62	: out std_logic_vector (outBits downto 0);
				x68	: out std_logic_vector (outBits downto 0);
				x73	: out std_logic_vector (outBits downto 0);
				x77	: out std_logic_vector (outBits downto 0);
				x81	: out std_logic_vector (outBits downto 0);
				x85 	: out std_logic_vector (outBits downto 0);
				x87	: out std_logic_vector (outBits downto 0);
				x88	: out std_logic_vector (outBits downto 0)
			);
		end Component;
		
		
		type hcubOutputs is array( 0 to numInOutputs - 1 ) of std_logic_vector( outBits downto 0 );
		signal x_8, x_17, x_25, x_33, x_40, x_48, x_55, x_62, x_68, x_73, x_77, x_81, x_85, x_87, x_88:	hcubOutputs;
		
		type inputSignals is array( 0 to numInOutputs - 1 ) of std_logic_vector( inBits - 1 downto 0 );
		signal x: inputSignals;
		
		type outputSignals is array( 0 to numInOutputs - 1 ) of std_logic_vector( outBits downto 0 );
		signal y, y_dct, y_dst: outputSignals;
	

begin 
x(0) <= x0;
x(1) <= x1;
x(2) <= x2;
x(3) <= x3;
x(4) <= x4;
x(5) <= x5;
x(6) <= x6;
x(7) <= x7;
x(8) <= x8;
x(9) <= x9;
x(10) <= x10;
x(11) <= x11;
x(12) <= x12;
x(13) <= x13;
x(14) <= x14;
x(15) <= x15;
x(16) <= x16;
x(17) <= x17;
x(18) <= x18;
x(19) <= x19;
x(20) <= x20;
x(21) <= x21;
x(22) <= x22;
x(23) <= x23;
x(24) <= x24;
x(25) <= x25;
x(26) <= x26;
x(27) <= x27;
x(28) <= x28;
x(29) <= x29;
x(30) <= x30;
x(31) <= x31;
x(32) <= x32;
x(33) <= x33;
x(34) <= x34;
x(35) <= x35;
x(36) <= x36;
x(37) <= x37;
x(38) <= x38;
x(39) <= x39;
x(40) <= x40;
x(41) <= x41;
x(42) <= x42;
x(43) <= x43;
x(44) <= x44;
x(45) <= x45;
x(46) <= x46;
x(47) <= x47;
x(48) <= x48;
x(49) <= x49;
x(50) <= x50;
x(51) <= x51;
x(52) <= x52;
x(53) <= x53;
x(54) <= x54;
x(55) <= x55;
x(56) <= x56;
x(57) <= x57;
x(58) <= x58;
x(59) <= x59;
x(60) <= x60;
x(61) <= x61;
x(62) <= x62;
x(63) <= x63;


			generateMCUs:        
            for i in 0 to numInOutputs-1 generate
						  
					MCU: MCUHcub_DST7_DCT8_16x16 
					port map(
						x => x(i),
						x8 => x_8(i),
						x17 => x_17(i),
						x25 => x_25(i),
						x33 => x_33(i),
						x40 => x_40(i),
						x48 => x_48(i),
						x55 => x_55(i),
						x62 => x_62(i),
						x68 => x_68(i),
						x73 => x_73(i),
						x77 => x_77(i),
						x81 => x_81(i),
						x85 => x_85(i),
						x87 => x_87(i),
						x88 => x_88(i));
						  
				end generate generateMCUs;

			
				
        generateSignalsOutputsDCT8:        
            for i in 0 to numTr - 1 generate
						y_dct(i*16 + 0) <= x_88(i*16 + 0) + x_88(i*16 + 1) + x_87(i*16 + 2) + x_85(i*16 + 3) + x_81(i*16 + 4) + x_77(i*16 + 5) + x_73(i*16 + 6) + x_68(i*16 + 7) + x_62(i*16 + 8) + x_55(i*16 + 9) + x_48(i*16 + 10) + x_40(i*16 + 11) + x_33(i*16 + 12) + x_25(i*16 + 13) + x_17(i*16 + 14) + x_8(i*16 + 15);
						y_dct(i*16 + 1) <= x_88(i*16 + 0) + x_81(i*16 + 1) + x_68(i*16 + 2) + x_48(i*16 + 3) + x_25(i*16 + 4) - x_25(i*16 + 6) - x_48(i*16 + 7) - x_68(i*16 + 8) - x_81(i*16 + 9) - x_88(i*16 + 10) - x_88(i*16 + 11) - x_81(i*16 + 12) - x_68(i*16 + 13) - x_48(i*16 + 14) - x_25(i*16 + 15);
						y_dct(i*16 + 2) <= x_87(i*16 + 0) + x_68(i*16 + 1) + x_33(i*16 + 2) - x_8(i*16 + 3) - x_48(i*16 + 4) - x_77(i*16 + 5) - x_88(i*16 + 6) - x_81(i*16 + 7) - x_55(i*16 + 8) - x_17(i*16 + 9) + x_25(i*16 + 10) + x_62(i*16 + 11) + x_85(i*16 + 12) + x_88(i*16 + 13) + x_73(i*16 + 14) + x_40(i*16 + 15);
						y_dct(i*16 + 3) <= x_85(i*16 + 0) + x_48(i*16 + 1) - x_8(i*16 + 2) - x_62(i*16 + 3) - x_88(i*16 + 4) - x_77(i*16 + 5) - x_33(i*16 + 6) + x_25(i*16 + 7) + x_73(i*16 + 8) + x_88(i*16 + 9) + x_68(i*16 + 10) + x_17(i*16 + 11) - x_40(i*16 + 12) - x_81(i*16 + 13) - x_87(i*16 + 14) - x_55(i*16 + 15);
						y_dct(i*16 + 4) <= x_81(i*16 + 0) + x_25(i*16 + 1) - x_48(i*16 + 2) - x_88(i*16 + 3) - x_68(i*16 + 4) + x_68(i*16 + 6) + x_88(i*16 + 7) + x_48(i*16 + 8) - x_25(i*16 + 9) - x_81(i*16 + 10) - x_81(i*16 + 11) - x_25(i*16 + 12) + x_48(i*16 + 13) + x_88(i*16 + 14) + x_68(i*16 + 15);
						y_dct(i*16 + 5) <= x_77(i*16 + 0) - x_77(i*16 + 2) - x_77(i*16 + 3) + x_77(i*16 + 5) + x_77(i*16 + 6) - x_77(i*16 + 8) - x_77(i*16 + 9) + x_77(i*16 + 11) + x_77(i*16 + 12) - x_77(i*16 + 14) - x_77(i*16 + 15);
						y_dct(i*16 + 6) <= x_73(i*16 + 0) - x_25(i*16 + 1) - x_88(i*16 + 2) - x_33(i*16 + 3) + x_68(i*16 + 4) + x_77(i*16 + 5) - x_17(i*16 + 6) - x_88(i*16 + 7) - x_40(i*16 + 8) + x_62(i*16 + 9) + x_81(i*16 + 10) - x_8(i*16 + 11) - x_87(i*16 + 12) - x_48(i*16 + 13) + x_55(i*16 + 14) + x_85(i*16 + 15);
						y_dct(i*16 + 7) <= x_68(i*16 + 0) - x_48(i*16 + 1) - x_81(i*16 + 2) + x_25(i*16 + 3) + x_88(i*16 + 4) - x_88(i*16 + 6) - x_25(i*16 + 7) + x_81(i*16 + 8) + x_48(i*16 + 9) - x_68(i*16 + 10) - x_68(i*16 + 11) + x_48(i*16 + 12) + x_81(i*16 + 13) - x_25(i*16 + 14) - x_88(i*16 + 15);
						y_dct(i*16 + 8) <= x_62(i*16 + 0) - x_68(i*16 + 1) - x_55(i*16 + 2) + x_73(i*16 + 3) + x_48(i*16 + 4) - x_77(i*16 + 5) - x_40(i*16 + 6) + x_81(i*16 + 7) + x_33(i*16 + 8) - x_85(i*16 + 9) - x_25(i*16 + 10) + x_87(i*16 + 11) + x_17(i*16 + 12) - x_88(i*16 + 13) - x_8(i*16 + 14) + x_88(i*16 + 15);
						y_dct(i*16 + 9) <= x_55(i*16 + 0) - x_81(i*16 + 1) - x_17(i*16 + 2) + x_88(i*16 + 3) - x_25(i*16 + 4) - x_77(i*16 + 5) + x_62(i*16 + 6) + x_48(i*16 + 7) - x_85(i*16 + 8) - x_8(i*16 + 9) + x_88(i*16 + 10) - x_33(i*16 + 11) - x_73(i*16 + 12) + x_68(i*16 + 13) + x_40(i*16 + 14) - x_87(i*16 + 15);
						y_dct(i*16 + 10) <= x_48(i*16 + 0) - x_88(i*16 + 1) + x_25(i*16 + 2) + x_68(i*16 + 3) - x_81(i*16 + 4) + x_81(i*16 + 6) - x_68(i*16 + 7) - x_25(i*16 + 8) + x_88(i*16 + 9) - x_48(i*16 + 10) - x_48(i*16 + 11) + x_88(i*16 + 12) - x_25(i*16 + 13) - x_68(i*16 + 14) + x_81(i*16 + 15);
						y_dct(i*16 + 11) <= x_40(i*16 + 0) - x_88(i*16 + 1) + x_62(i*16 + 2) + x_17(i*16 + 3) - x_81(i*16 + 4) + x_77(i*16 + 5) - x_8(i*16 + 6) - x_68(i*16 + 7) + x_87(i*16 + 8) - x_33(i*16 + 9) - x_48(i*16 + 10) + x_88(i*16 + 11) - x_55(i*16 + 12) - x_25(i*16 + 13) + x_85(i*16 + 14) - x_73(i*16 + 15);
						y_dct(i*16 + 12) <= x_33(i*16 + 0) - x_81(i*16 + 1) + x_85(i*16 + 2) - x_40(i*16 + 3) - x_25(i*16 + 4) + x_77(i*16 + 5) - x_87(i*16 + 6) + x_48(i*16 + 7) + x_17(i*16 + 8) - x_73(i*16 + 9) + x_88(i*16 + 10) - x_55(i*16 + 11) - x_8(i*16 + 12) + x_68(i*16 + 13) - x_88(i*16 + 14) + x_62(i*16 + 15);
						y_dct(i*16 + 13) <= x_25(i*16 + 0) - x_68(i*16 + 1) + x_88(i*16 + 2) - x_81(i*16 + 3) + x_48(i*16 + 4) - x_48(i*16 + 6) + x_81(i*16 + 7) - x_88(i*16 + 8) + x_68(i*16 + 9) - x_25(i*16 + 10) - x_25(i*16 + 11) + x_68(i*16 + 12) - x_88(i*16 + 13) + x_81(i*16 + 14) - x_48(i*16 + 15);
						y_dct(i*16 + 14) <= x_17(i*16 + 0) - x_48(i*16 + 1) + x_73(i*16 + 2) - x_87(i*16 + 3) + x_88(i*16 + 4) - x_77(i*16 + 5) + x_55(i*16 + 6) - x_25(i*16 + 7) - x_8(i*16 + 8) + x_40(i*16 + 9) - x_68(i*16 + 10) + x_85(i*16 + 11) - x_88(i*16 + 12) + x_81(i*16 + 13) - x_62(i*16 + 14) + x_33(i*16 + 15);
						y_dct(i*16 + 15) <= x_8(i*16 + 0) - x_25(i*16 + 1) + x_40(i*16 + 2) - x_55(i*16 + 3) + x_68(i*16 + 4) - x_77(i*16 + 5) + x_85(i*16 + 6) - x_88(i*16 + 7) + x_88(i*16 + 8) - x_87(i*16 + 9) + x_81(i*16 + 10) - x_73(i*16 + 11) + x_62(i*16 + 12) - x_48(i*16 + 13) + x_33(i*16 + 14) - x_17(i*16 + 15);
	  
            end generate generateSignalsOutputsDCT8;
				
				generateSignalsOutputsDST7:        
            for i in 0 to numTr - 1 generate
						y_dst(i*16 + 0) <= x_8(i*16 + 0) + x_25(i*16 + 1) + x_40(i*16 + 2) + x_55(i*16 + 3) + x_68(i*16 + 4) + x_77(i*16 + 5) + x_85(i*16 + 6) + x_88(i*16 + 7) + x_88(i*16 + 8) + x_87(i*16 + 9) + x_81(i*16 + 10) + x_73(i*16 + 11) + x_62(i*16 + 12) + x_48(i*16 + 13) + x_33(i*16 + 14) + x_17(i*16 + 15);
						y_dst(i*16 + 1) <= x_17(i*16 + 0) + x_48(i*16 + 1) + x_73(i*16 + 2) + x_87(i*16 + 3) + x_88(i*16 + 4) + x_77(i*16 + 5) + x_55(i*16 + 6) + x_25(i*16 + 7) - x_8(i*16 + 8) - x_40(i*16 + 9) - x_68(i*16 + 10) - x_85(i*16 + 11) - x_88(i*16 + 12) - x_81(i*16 + 13) - x_62(i*16 + 14) - x_33(i*16 + 15);
						y_dst(i*16 + 2) <= x_25(i*16 + 0) + x_68(i*16 + 1) + x_88(i*16 + 2) + x_81(i*16 + 3) + x_48(i*16 + 4) - x_48(i*16 + 6) - x_81(i*16 + 7) - x_88(i*16 + 8) - x_68(i*16 + 9) - x_25(i*16 + 10) + x_25(i*16 + 11) + x_68(i*16 + 12) + x_88(i*16 + 13) + x_81(i*16 + 14) + x_48(i*16 + 15);
						y_dst(i*16 + 3) <= x_33(i*16 + 0) + x_81(i*16 + 1) + x_85(i*16 + 2) + x_40(i*16 + 3) - x_25(i*16 + 4) - x_77(i*16 + 5) - x_87(i*16 + 6) - x_48(i*16 + 7) + x_17(i*16 + 8) + x_73(i*16 + 9) + x_88(i*16 + 10) + x_55(i*16 + 11) - x_8(i*16 + 12) - x_68(i*16 + 13) - x_88(i*16 + 14) - x_62(i*16 + 15);
						y_dst(i*16 + 4) <= x_40(i*16 + 0) + x_88(i*16 + 1) + x_62(i*16 + 2) - x_17(i*16 + 3) - x_81(i*16 + 4) - x_77(i*16 + 5) - x_8(i*16 + 6) + x_68(i*16 + 7) + x_87(i*16 + 8) + x_33(i*16 + 9) - x_48(i*16 + 10) - x_88(i*16 + 11) - x_55(i*16 + 12) + x_25(i*16 + 13) + x_85(i*16 + 14) + x_73(i*16 + 15);
						y_dst(i*16 + 5) <= x_48(i*16 + 0) + x_88(i*16 + 1) + x_25(i*16 + 2) - x_68(i*16 + 3) - x_81(i*16 + 4) + x_81(i*16 + 6) + x_68(i*16 + 7) - x_25(i*16 + 8) - x_88(i*16 + 9) - x_48(i*16 + 10) + x_48(i*16 + 11) + x_88(i*16 + 12) + x_25(i*16 + 13) - x_68(i*16 + 14) - x_81(i*16 + 15);
						y_dst(i*16 + 6) <= x_55(i*16 + 0) + x_81(i*16 + 1) - x_17(i*16 + 2) - x_88(i*16 + 3) - x_25(i*16 + 4) + x_77(i*16 + 5) + x_62(i*16 + 6) - x_48(i*16 + 7) - x_85(i*16 + 8) + x_8(i*16 + 9) + x_88(i*16 + 10) + x_33(i*16 + 11) - x_73(i*16 + 12) - x_68(i*16 + 13) + x_40(i*16 + 14) + x_87(i*16 + 15);
						y_dst(i*16 + 7) <= x_62(i*16 + 0) + x_68(i*16 + 1) - x_55(i*16 + 2) - x_73(i*16 + 3) + x_48(i*16 + 4) + x_77(i*16 + 5) - x_40(i*16 + 6) - x_81(i*16 + 7) + x_33(i*16 + 8) + x_85(i*16 + 9) - x_25(i*16 + 10) - x_87(i*16 + 11) + x_17(i*16 + 12) + x_88(i*16 + 13) - x_8(i*16 + 14) - x_88(i*16 + 15);
						y_dst(i*16 + 8) <= x_68(i*16 + 0) + x_48(i*16 + 1) - x_81(i*16 + 2) - x_25(i*16 + 3) + x_88(i*16 + 4) - x_88(i*16 + 6) + x_25(i*16 + 7) + x_81(i*16 + 8) - x_48(i*16 + 9) - x_68(i*16 + 10) + x_68(i*16 + 11) + x_48(i*16 + 12) - x_81(i*16 + 13) - x_25(i*16 + 14) + x_88(i*16 + 15);
						y_dst(i*16 + 9) <= x_73(i*16 + 0) + x_25(i*16 + 1) - x_88(i*16 + 2) + x_33(i*16 + 3) + x_68(i*16 + 4) - x_77(i*16 + 5) - x_17(i*16 + 6) + x_88(i*16 + 7) - x_40(i*16 + 8) - x_62(i*16 + 9) + x_81(i*16 + 10) + x_8(i*16 + 11) - x_87(i*16 + 12) + x_48(i*16 + 13) + x_55(i*16 + 14) - x_85(i*16 + 15);
						y_dst(i*16 + 10) <= x_77(i*16 + 0) - x_77(i*16 + 2) + x_77(i*16 + 3) - x_77(i*16 + 5) + x_77(i*16 + 6) - x_77(i*16 + 8) + x_77(i*16 + 9) - x_77(i*16 + 11) + x_77(i*16 + 12) - x_77(i*16 + 14) + x_77(i*16 + 15);
						y_dst(i*16 + 11) <= x_81(i*16 + 0) - x_25(i*16 + 1) - x_48(i*16 + 2) + x_88(i*16 + 3) - x_68(i*16 + 4) + x_68(i*16 + 6) - x_88(i*16 + 7) + x_48(i*16 + 8) + x_25(i*16 + 9) - x_81(i*16 + 10) + x_81(i*16 + 11) - x_25(i*16 + 12) - x_48(i*16 + 13) + x_88(i*16 + 14) - x_68(i*16 + 15);
						y_dst(i*16 + 12) <= x_85(i*16 + 0) - x_48(i*16 + 1) - x_8(i*16 + 2) + x_62(i*16 + 3) - x_88(i*16 + 4) + x_77(i*16 + 5) - x_33(i*16 + 6) - x_25(i*16 + 7) + x_73(i*16 + 8) - x_88(i*16 + 9) + x_68(i*16 + 10) - x_17(i*16 + 11) - x_40(i*16 + 12) + x_81(i*16 + 13) - x_87(i*16 + 14) + x_55(i*16 + 15);
						y_dst(i*16 + 13) <= x_87(i*16 + 0) - x_68(i*16 + 1) + x_33(i*16 + 2) + x_8(i*16 + 3) - x_48(i*16 + 4) + x_77(i*16 + 5) - x_88(i*16 + 6) + x_81(i*16 + 7) - x_55(i*16 + 8) + x_17(i*16 + 9) + x_25(i*16 + 10) - x_62(i*16 + 11) + x_85(i*16 + 12) - x_88(i*16 + 13) + x_73(i*16 + 14) - x_40(i*16 + 15);
						y_dst(i*16 + 14) <= x_88(i*16 + 0) - x_81(i*16 + 1) + x_68(i*16 + 2) - x_48(i*16 + 3) + x_25(i*16 + 4) - x_25(i*16 + 6) + x_48(i*16 + 7) - x_68(i*16 + 8) + x_81(i*16 + 9) - x_88(i*16 + 10) + x_88(i*16 + 11) - x_81(i*16 + 12) + x_68(i*16 + 13) - x_48(i*16 + 14) + x_25(i*16 + 15);
						y_dst(i*16 + 15) <= x_88(i*16 + 0) - x_88(i*16 + 1) + x_87(i*16 + 2) - x_85(i*16 + 3) + x_81(i*16 + 4) - x_77(i*16 + 5) + x_73(i*16 + 6) - x_68(i*16 + 7) + x_62(i*16 + 8) - x_55(i*16 + 9) + x_48(i*16 + 10) - x_40(i*16 + 11) + x_33(i*16 + 12) - x_25(i*16 + 13) + x_17(i*16 + 14) - x_8(i*16 + 15);
												
            end generate generateSignalsOutputsDST7;
				
				with op select
				y <= 	y_dct when '0',
						y_dst when others;
				
        
y0 <= y(0);
y1 <= y(1);
y2 <= y(2);
y3 <= y(3);
y4 <= y(4);
y5 <= y(5);
y6 <= y(6);
y7 <= y(7);
y8 <= y(8);
y9 <= y(9);
y10 <= y(10);
y11 <= y(11);
y12 <= y(12);
y13 <= y(13);
y14 <= y(14);
y15 <= y(15);
y16 <= y(16);
y17 <= y(17);
y18 <= y(18);
y19 <= y(19);
y20 <= y(20);
y21 <= y(21);
y22 <= y(22);
y23 <= y(23);
y24 <= y(24);
y25 <= y(25);
y26 <= y(26);
y27 <= y(27);
y28 <= y(28);
y29 <= y(29);
y30 <= y(30);
y31 <= y(31);
y32 <= y(32);
y33 <= y(33);
y34 <= y(34);
y35 <= y(35);
y36 <= y(36);
y37 <= y(37);
y38 <= y(38);
y39 <= y(39);
y40 <= y(40);
y41 <= y(41);
y42 <= y(42);
y43 <= y(43);
y44 <= y(44);
y45 <= y(45);
y46 <= y(46);
y47 <= y(47);
y48 <= y(48);
y49 <= y(49);
y50 <= y(50);
y51 <= y(51);
y52 <= y(52);
y53 <= y(53);
y54 <= y(54);
y55 <= y(55);
y56 <= y(56);
y57 <= y(57);
y58 <= y(58);
y59 <= y(59);
y60 <= y(60);
y61 <= y(61);
y62 <= y(62);
y63 <= y(63);
			

			
end behavior;
