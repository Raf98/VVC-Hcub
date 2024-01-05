-- DST-VII 1D 8x8 utilizando MCU com Hcub para a multiplicação
-- e Macro Function para as somas
-- Rafael Santos; André Marcelo Coelho da Silva
-- Created: 18/12/2023


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


	
entity DST7_DCT8_8x8 is
	generic(
		Nbits				:  integer := 9;
		inBits			:	integer := 9;
		numInOutputs	:	integer := 64;
		outBits			:	integer := 17;
		rNum				:  integer := 4;
		numTr				:  integer := 8
	);
	port(
		op:												 in std_logic;
		x0 ,x1 ,x2 ,x3 ,x4 ,x5 ,x6 ,x7: 			 in std_logic_vector(inBits - 1 downto 0);
		x8 ,x9 ,x10 ,x11 ,x12 ,x13 ,x14 ,x15:   in std_logic_vector(inBits - 1 downto 0);
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

end DST7_DCT8_8x8;


architecture behavior of DST7_DCT8_8x8 is
		
		Component MCUHcubparaDSTVII8x8 is
			PORT( 
				x 		: in  std_logic_vector (inBits - 1 downto 0);
				x17	: out std_logic_vector (outBits 	  downto 0);
				x32 	: out std_logic_vector (outBits    downto 0);
				x46 	: out std_logic_vector (outBits    downto 0);
				x60	: out std_logic_vector (outBits    downto 0);
				x71	: out std_logic_vector (outBits 	  downto 0);
				x78 	: out std_logic_vector (outBits 	  downto 0);
				x85 	: out std_logic_vector (outBits    downto 0);
				x86	: out std_logic_vector (outBits 	  downto 0)
);
		end Component;
		
		
		type hcubOutputs is array( 0 to numInOutputs - 1 ) of std_logic_vector( outBits downto 0 );
		signal x_17, x_32, x_46, x_60, x_71, x_78, x_85, x_86:	hcubOutputs;
		
		type inputSignals is array( 0 to numInOutputs - 1 ) of std_logic_vector( inBits - 1 downto 0 );
		signal x: inputSignals;
		
		type outputSignals is array( 0 to numInOutputs - 1 ) of std_logic_vector( outBits downto 0 );
		signal y, y_dct, y_dst: outputSignals;
			
				
			-- atribuir valores de x a sinais auxiliares, em formato de vetor
			--usar array para os sinais x
	

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
						  
                    MCU: MCUHcubparaDSTVII8x8 
                    port map( 
				x => x(i),
				x17 => x_17(i),
				x32 => x_32(i),
				x46 => x_46(i), 
				x60 => x_60(i), 
				x71 => x_71(i), 
				x78 => x_78(i), 
				x85 => x_85(i), 
				x86 => x_86(i));
						  
        end generate generateMCUs;
        
        generateSignalsOutputsDCT_8: 
            for i in 0 to numTr - 1 generate
					 --with op select 
				    y_dct(i*8 + 0) <= x_86(i*8 + 0) + x_85(i*8 + 1) + x_78(i*8 + 2) + x_71(i*8 + 3) + x_60(i*8 + 4) + x_46(i*8 + 5) + x_32(i*8 + 6) + x_17(i*8 + 7);-- when '0',
										--x_17(i*8 + 0) + x_46(i*8 + 1) + x_71(i*8 + 2) + x_85(i*8 + 3) + x_86(i*8 + 4) + x_78(i*8 + 5) + x_60(i*8 + 6) + x_32(i*8 + 7) when others;					
		     	    y_dct(i*8 + 1) <= x_85(i*8 + 0) + x_60(i*8 + 1) + x_17(i*8 + 2) - x_32(i*8 + 3) - x_71(i*8 + 4) - x_86(i*8 + 5) - x_78(i*8 + 6) - x_46(i*8 + 7);
                y_dct(i*8 + 2) <= x_78(i*8 + 0) + x_17(i*8 + 1) - x_60(i*8 + 2) - x_86(i*8 + 3) - x_46(i*8 + 4) + x_32(i*8 + 5) + x_85(i*8 + 6) + x_71(i*8 + 7);
                y_dct(i*8 + 3) <= x_71(i*8 + 0) - x_32(i*8 + 1) - x_86(i*8 + 2) - x_17(i*8 + 3) + x_78(i*8 + 4) + x_60(i*8 + 5) - x_46(i*8 + 6) - x_85(i*8 + 7);
		    	    y_dct(i*8 + 4) <= x_60(i*8 + 0) - x_71(i*8 + 1) - x_46(i*8 + 2) + x_78(i*8 + 3) + x_32(i*8 + 4) - x_85(i*8 + 5) - x_17(i*8 + 6) + x_86(i*8 + 7);
                y_dct(i*8 + 5) <= x_46(i*8 + 0) - x_86(i*8 + 1) + x_32(i*8 + 2) + x_60(i*8 + 3) - x_85(i*8 + 4) + x_17(i*8 + 5) + x_71(i*8 + 6) - x_78(i*8 + 7);
                y_dct(i*8 + 6) <= x_32(i*8 + 0) - x_78(i*8 + 1) + x_85(i*8 + 2) - x_46(i*8 + 3) - x_17(i*8 + 4) + x_71(i*8 + 5) - x_86(i*8 + 6) + x_60(i*8 + 7);
                y_dct(i*8 + 7) <= x_17(i*8 + 0) - x_46(i*8 + 1) + x_71(i*8 + 2) - x_85(i*8 + 3) + x_86(i*8 + 4) - x_78(i*8 + 5) + x_60(i*8 + 6) - x_32(i*8 + 7);	  
            end generate generateSignalsOutputsDCT_8;
				
		   generateSignalsOutputsDST_7:        
            for i in 0 to numTr - 1 generate
				    y_dst(i*8 + 0) <= x_17(i*8 + 0) + x_46(i*8 + 1) + x_71(i*8 + 2) + x_85(i*8 + 3) + x_86(i*8 + 4) + x_78(i*8 + 5) + x_60(i*8 + 6) + x_32(i*8 + 7);
					 y_dst(i*8 + 1) <= x_32(i*8 + 0) + x_78(i*8 + 1) + x_85(i*8 + 2) + x_46(i*8 + 3) - x_17(i*8 + 4) - x_71(i*8 + 5) - x_86(i*8 + 6) - x_60(i*8 + 7);
				    y_dst(i*8 + 2) <= x_46(i*8 + 0) + x_86(i*8 + 1) + x_32(i*8 + 2) - x_60(i*8 + 3) - x_85(i*8 + 4) - x_17(i*8 + 5) + x_71(i*8 + 6) + x_78(i*8 + 7);
					 y_dst(i*8 + 3) <= x_60(i*8 + 0) + x_71(i*8 + 1) - x_46(i*8 + 2) - x_78(i*8 + 3) + x_32(i*8 + 4) + x_85(i*8 + 5) - x_17(i*8 + 6) - x_86(i*8 + 7);
					 y_dst(i*8 + 4) <= x_71(i*8 + 0) + x_32(i*8 + 1) - x_86(i*8 + 2) + x_17(i*8 + 3) + x_78(i*8 + 4) - x_60(i*8 + 5) - x_46(i*8 + 6) + x_85(i*8 + 7);
                y_dst(i*8 + 5) <= x_78(i*8 + 0) - x_17(i*8 + 1) - x_60(i*8 + 2) + x_86(i*8 + 3) - x_46(i*8 + 4) - x_32(i*8 + 5) + x_85(i*8 + 6) - x_71(i*8 + 7);
                y_dst(i*8 + 6) <= x_85(i*8 + 0) - x_60(i*8 + 1) + x_17(i*8 + 2) + x_32(i*8 + 3) - x_71(i*8 + 4) + x_86(i*8 + 5) - x_78(i*8 + 6) + x_46(i*8 + 7);
                y_dst(i*8 + 7) <= x_86(i*8 + 0) - x_85(i*8 + 1) + x_78(i*8 + 2) - x_71(i*8 + 3) + x_60(i*8 + 4) - x_46(i*8 + 5) + x_32(i*8 + 6) - x_17(i*8 + 7);	  
            end generate generateSignalsOutputsDST_7;
				
			with op select
			y <= y_dct when '0',
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

        
--y0 <= x_86(0) + x_85(1) + x_78(2) + x_71(3) + x_60(4) + x_46(5) + x_32(6) + x_17(7);
--y1 <= x_85(0) + x_60(1) + x_17(2) - x_32(3) - x_71(4) - x_86(5) - x_78(6) - x_46(7);
--y2 <= x_78(0) + x_17(1) - x_60(2) - x_86(3) - x_46(4) + x_32(5) + x_85(6) + x_71(7);
--y3 <= x_71(0) - x_32(1) - x_86(2) - x_17(3) + x_78(4) + x_60(5) - x_46(6) - x_85(7);
--y4 <= x_60(0) - x_71(1) - x_46(2) + x_78(3) + x_32(4) - x_85(5) - x_17(6) + x_86(7);
--y5 <= x_46(0) - x_86(1) + x_32(2) + x_60(3) - x_85(4) + x_17(5) + x_71(6) - x_78(7);
--y6 <= x_32(0) - x_78(1) + x_85(2) - x_46(3) - x_17(4) + x_71(5) - x_86(6) + x_60(7);
--y7 <= x_17(0) - x_46(1) + x_71(2) - x_85(3) + x_86(4) - x_78(5) + x_60(6) - x_32(7);
-- usar generate para gerar blocos Hcub MCM
--MCU0: MCUHcubparaDSTVII4x4
--			port map( 
--				x 		=> x0,
--				x29	=> x0_29,
--				x55 	=> x0_55,
--				x74 	=> x0_74,
--				x84	=> x0_84);

 
 ----------------------------------------------------
 -- Linha de Somadores
 ----------------------------------------------------
--como cada x é um valor em uma linha/row, y deve ser a soma das multiplicaçoes dos valores dessas LINHAS em X pelos valores das COLUNAS em TN (MCUHcubparaDSTVII)
--			y0 <= '0' & (x0_29 + x1_74 + x2_84 + x3_55);
--			y1 <= '0' & (x0_55 + x1_74 - x2_29 - x3_84);
--			y2 <= '0' & (x0_74 -(x2_74) + x3_74);
--			y3 <= '0' & (x0_84 - (x1_74) + x2_55 - (x3_29));
--			y4 <= '0' & (x4_29 + x5_74 + x6_84 + x7_55);
--			y5 <= '0' & (x4_55 + x5_74 - (x6_29) - (x7_84));
--			y6 <= '0' & (x4_74 - (x6_74) + x7_74);
--			y7 <= '0' &	(x4_84 - (x5_74) + x6_55 - (x7_29));
--			y8 <= '0' & (x8_29 +	x9_74 + x10_84 + x11_55);
--			y9 <= '0' & (x8_55 +	x9_74 - (x10_29) - (x11_84));
--			y10 <= '0' & (x8_74 - (x10_74) + x11_74);
--			y11 <= '0' & (x8_84 - (x9_74) + x10_55 - (x11_29));
--			y12 <= '0' & (x12_29 + x13_74 + x14_84 + x15_55);
--			y13 <= '0' & (x12_55 + x13_74 - (x14_29) - (x15_84));
--			y14 <= '0' & (x12_74 - (x14_74) + x15_74);
--			y15 <= '0' & (x12_84	- (x13_74) + x14_55 - (x15_29));

-- usar sinais auxiliares de y como saida para as operaçoes
-- aplicar rezise na atribuiçao das saidas auxiliares nas saidas
--y0 = x0_86 + x1_85 + x2_78 + x3_71 + x4_60 + x5_46 + x6_32 + x7_17;
--y1 = x0_85 + x1_60 + x2_17 - x3_32 - x4_71 - x5_86 - x6_78 - x7_46;
--y2 = x0_78 + x1_17 - x2_60 - x3_86 - x4_46 + x5_32 + x6_85 + x7_71;
--y3 = x0_71 - x1_32 - x2_86 - x3_17 + x4_78 + x5_60 - x6_46 - x7_85;
--y4 = x0_60 - x1_71 - x2_46 + x3_78 + x4_32 - x5_85 - x6_17 + x7_86;
--y5 = x0_46 - x1_86 + x2_32 + x3_60 - x4_85 + x5_17 + x6_71 - x7_78;
--y6 = x0_32 - x1_78 + x2_85 - x3_46 - x4_17 + x5_71 - x6_86 + x7_60;
--y7 = x0_17 - x1_46 + x2_71 - x3_85 + x4_86 - x5_78 + x6_60 - x7_32;
--y8 = x4_86 + x5_85 + x6_78 + x7_71 + x8_60 + x9_46 + x10_32 + x11_17;
--y9 = x4_85 + x5_60 + x6_17 - x7_32 - x8_71 - x9_86 - x10_78 - x11_46;
--y10 = x4_78 + x5_17 - x6_60 - x7_86 - x8_46 + x9_32 + x10_85 + x11_71;
--y11 = x4_71 - x5_32 - x6_86 - x7_17 + x8_78 + x9_60 - x10_46 - x11_85;
--y12 = x4_60 - x5_71 - x6_46 + x7_78 + x8_32 - x9_85 - x10_17 + x11_86;
--y13 = x4_46 - x5_86 + x6_32 + x7_60 - x8_85 + x9_17 + x10_71 - x11_78;
--y14 = x4_32 - x5_78 + x6_85 - x7_46 - x8_17 + x9_71 - x10_86 + x11_60;
--y15 = x4_17 - x5_46 + x6_71 - x7_85 + x8_86 - x9_78 + x10_60 - x11_32;
--y16 = x8_86 + x9_85 + x10_78 + x11_71 + x12_60 + x13_46 + x14_32 + x15_17;
--y17 = x8_85 + x9_60 + x10_17 - x11_32 - x12_71 - x13_86 - x14_78 - x15_46;
--y18 = x8_78 + x9_17 - x10_60 - x11_86 - x12_46 + x13_32 + x14_85 + x15_71;
--y19 = x8_71 - x9_32 - x10_86 - x11_17 + x12_78 + x13_60 - x14_46 - x15_85;
--y20 = x8_60 - x9_71 - x10_46 + x11_78 + x12_32 - x13_85 - x14_17 + x15_86;
--y21 = x8_46 - x9_86 + x10_32 + x11_60 - x12_85 + x13_17 + x14_71 - x15_78;
--y22 = x8_32 - x9_78 + x10_85 - x11_46 - x12_17 + x13_71 - x14_86 + x15_60;
--y23 = x8_17 - x9_46 + x10_71 - x11_85 + x12_86 - x13_78 + x14_60 - x15_32;
--y24 = x12_86 + x13_85 + x14_78 + x15_71 + x16_60 + x17_46 + x18_32 + x19_17;
--y25 = x12_85 + x13_60 + x14_17 - x15_32 - x16_71 - x17_86 - x18_78 - x19_46;
--y26 = x12_78 + x13_17 - x14_60 - x15_86 - x16_46 + x17_32 + x18_85 + x19_71;
--y27 = x12_71 - x13_32 - x14_86 - x15_17 + x16_78 + x17_60 - x18_46 - x19_85;
--y28 = x12_60 - x13_71 - x14_46 + x15_78 + x16_32 - x17_85 - x18_17 + x19_86;
--y29 = x12_46 - x13_86 + x14_32 + x15_60 - x16_85 + x17_17 + x18_71 - x19_78;
--y30 = x12_32 - x13_78 + x14_85 - x15_46 - x16_17 + x17_71 - x18_86 + x19_60;
--y31 = x12_17 - x13_46 + x14_71 - x15_85 + x16_86 - x17_78 + x18_60 - x19_32;
--y32 = x16_86 + x17_85 + x18_78 + x19_71 + x20_60 + x21_46 + x22_32 + x23_17;
--y33 = x16_85 + x17_60 + x18_17 - x19_32 - x20_71 - x21_86 - x22_78 - x23_46;
--y34 = x16_78 + x17_17 - x18_60 - x19_86 - x20_46 + x21_32 + x22_85 + x23_71;
--y35 = x16_71 - x17_32 - x18_86 - x19_17 + x20_78 + x21_60 - x22_46 - x23_85;
--y36 = x16_60 - x17_71 - x18_46 + x19_78 + x20_32 - x21_85 - x22_17 + x23_86;
--y37 = x16_46 - x17_86 + x18_32 + x19_60 - x20_85 + x21_17 + x22_71 - x23_78;
--y38 = x16_32 - x17_78 + x18_85 - x19_46 - x20_17 + x21_71 - x22_86 + x23_60;
--y39 = x16_17 - x17_46 + x18_71 - x19_85 + x20_86 - x21_78 + x22_60 - x23_32;
--y40 = x20_86 + x21_85 + x22_78 + x23_71 + x24_60 + x25_46 + x26_32 + x27_17;
--y41 = x20_85 + x21_60 + x22_17 - x23_32 - x24_71 - x25_86 - x26_78 - x27_46;
--y42 = x20_78 + x21_17 - x22_60 - x23_86 - x24_46 + x25_32 + x26_85 + x27_71;
--y43 = x20_71 - x21_32 - x22_86 - x23_17 + x24_78 + x25_60 - x26_46 - x27_85;
--y44 = x20_60 - x21_71 - x22_46 + x23_78 + x24_32 - x25_85 - x26_17 + x27_86;
--y45 = x20_46 - x21_86 + x22_32 + x23_60 - x24_85 + x25_17 + x26_71 - x27_78;
--y46 = x20_32 - x21_78 + x22_85 - x23_46 - x24_17 + x25_71 - x26_86 + x27_60;
--y47 = x20_17 - x21_46 + x22_71 - x23_85 + x24_86 - x25_78 + x26_60 - x27_32;
--y48 = x24_86 + x25_85 + x26_78 + x27_71 + x28_60 + x29_46 + x30_32 + x31_17;
--y49 = x24_85 + x25_60 + x26_17 - x27_32 - x28_71 - x29_86 - x30_78 - x31_46;
--y50 = x24_78 + x25_17 - x26_60 - x27_86 - x28_46 + x29_32 + x30_85 + x31_71;
--y51 = x24_71 - x25_32 - x26_86 - x27_17 + x28_78 + x29_60 - x30_46 - x31_85;
--y52 = x24_60 - x25_71 - x26_46 + x27_78 + x28_32 - x29_85 - x30_17 + x31_86;
--y53 = x24_46 - x25_86 + x26_32 + x27_60 - x28_85 + x29_17 + x30_71 - x31_78;
--y54 = x24_32 - x25_78 + x26_85 - x27_46 - x28_17 + x29_71 - x30_86 + x31_60;
--y55 = x24_17 - x25_46 + x26_71 - x27_85 + x28_86 - x29_78 + x30_60 - x31_32;
--y56 = x28_86 + x29_85 + x30_78 + x31_71 + x32_60 + x33_46 + x34_32 + x35_17;
--y57 = x28_85 + x29_60 + x30_17 - x31_32 - x32_71 - x33_86 - x34_78 - x35_46;
--y58 = x28_78 + x29_17 - x30_60 - x31_86 - x32_46 + x33_32 + x34_85 + x35_71;
--y59 = x28_71 - x29_32 - x30_86 - x31_17 + x32_78 + x33_60 - x34_46 - x35_85;
--y60 = x28_60 - x29_71 - x30_46 + x31_78 + x32_32 - x33_85 - x34_17 + x35_86;
--y61 = x28_46 - x29_86 + x30_32 + x31_60 - x32_85 + x33_17 + x34_71 - x35_78;
--y62 = x28_32 - x29_78 + x30_85 - x31_46 - x32_17 + x33_71 - x34_86 + x35_60;
--y63 = x28_17 - x29_46 + x30_71 - x31_85 + x32_86 - x33_78 + x34_60 - x35_32;
			

			
end behavior;
