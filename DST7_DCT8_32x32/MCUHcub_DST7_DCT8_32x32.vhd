-- MCU-Hcub de 8 pontos para DST-VII 
-- Rafael Santos; André Marcelo Coelho da Silva
-- Created: 18/12/2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_signed.all;


entity MCUHcub_DST7_DCT8_32x32 is
generic(
		inBits			:	integer := 9;
		outBits			:	integer := 23
);
port (

x 		: in  std_logic_vector (inBits - 1 downto 0);
--4 & 9 & 13 & 17 & 21 & 26 & 30 & 34 & 38 & 42 & 46 & 50 & 53 & 56 & 60 & 63 & 66 & 68 & 72 & 74 & 77 & 78 & 80 & 82 & 84 & 85 & 86 & 87 & 88 & 89 & 90 & 90
x4		: out std_logic_vector (outBits downto 0);
x9		: out std_logic_vector (outBits downto 0);
x13	: out std_logic_vector (outBits downto 0);
x17	: out std_logic_vector (outBits downto 0);
x21 	: out std_logic_vector (outBits downto 0);
x26 	: out std_logic_vector (outBits downto 0);
x30 	: out std_logic_vector (outBits downto 0);
x34 	: out std_logic_vector (outBits downto 0);
x38 	: out std_logic_vector (outBits downto 0);
x42 	: out std_logic_vector (outBits downto 0);
x46 	: out std_logic_vector (outBits downto 0);
x50 	: out std_logic_vector (outBits downto 0);
x53 	: out std_logic_vector (outBits downto 0);
x56 	: out std_logic_vector (outBits downto 0);
x60	: out std_logic_vector (outBits downto 0);
x63	: out std_logic_vector (outBits downto 0);
x66	: out std_logic_vector (outBits downto 0);
x68	: out std_logic_vector (outBits downto 0);
x72	: out std_logic_vector (outBits downto 0);
x74	: out std_logic_vector (outBits downto 0);
x77	: out std_logic_vector (outBits downto 0);
x78	: out std_logic_vector (outBits downto 0);
x80	: out std_logic_vector (outBits downto 0);
x82	: out std_logic_vector (outBits downto 0);
x84	: out std_logic_vector (outBits downto 0);
x85 	: out std_logic_vector (outBits downto 0);
x86 	: out std_logic_vector (outBits downto 0);
x87	: out std_logic_vector (outBits downto 0);
x88	: out std_logic_vector (outBits downto 0);
x89	: out std_logic_vector (outBits downto 0);
x90	: out std_logic_vector (outBits downto 0)
);


end entity;


architecture behavior of MCUHcub_DST7_DCT8_32x32 is
		signal x_resized			: std_logic_vector(outBits downto 0);
		
		-- First row
		signal shift4x 			: std_logic_vector(outBits downto 0);
		signal shift8x 			: std_logic_vector(outBits downto 0);
		signal shift16x 			: std_logic_vector(outBits downto 0);
		signal shift32x 			: std_logic_vector(outBits downto 0);
		
		signal sub7x				: std_logic_vector(outBits downto 0);
		signal sub15x				: std_logic_vector(outBits downto 0);
		signal sub63x 				: std_logic_vector(outBits downto 0);
		
		signal adder5x 			: std_logic_vector(outBits downto 0);
		signal adder9x 			: std_logic_vector(outBits downto 0);
		signal adder17x 			: std_logic_vector(outBits downto 0);
		signal adder33x 			: std_logic_vector(outBits downto 0);
		
		
		-- Second row
		signal shift14x			: std_logic_vector(outBits downto 0);
		signal shift24x			: std_logic_vector(outBits downto 0);
		signal shift30x			: std_logic_vector(outBits downto 0);
		signal shift34x			: std_logic_vector(outBits downto 0);
		signal shift38x			: std_logic_vector(outBits downto 0);
		signal shift40x			: std_logic_vector(outBits downto 0);
		signal shift42x			: std_logic_vector(outBits downto 0);
		signal shift48x			: std_logic_vector(outBits downto 0);
		signal shift50x			: std_logic_vector(outBits downto 0);
		signal shift60x			: std_logic_vector(outBits downto 0);
		signal shift62x			: std_logic_vector(outBits downto 0);
		signal shift66x			: std_logic_vector(outBits downto 0);
		signal shift68x			: std_logic_vector(outBits downto 0);
		signal shift72x			: std_logic_vector(outBits downto 0);
		signal shift74x			: std_logic_vector(outBits downto 0);
		signal shift80x			: std_logic_vector(outBits downto 0);
		signal shift84x			: std_logic_vector(outBits downto 0);
		
		signal sub13x 				: std_logic_vector(outBits downto 0);
		signal sub39x 				: std_logic_vector(outBits downto 0);
		signal sub53x 				: std_logic_vector(outBits downto 0);
		signal sub77x 				: std_logic_vector(outBits downto 0);
		
		signal adder11x 			: std_logic_vector(outBits downto 0);
		signal adder19x 			: std_logic_vector(outBits downto 0);
		signal adder21x 			: std_logic_vector(outBits downto 0);
		signal adder23x 			: std_logic_vector(outBits downto 0);
		signal adder25x 			: std_logic_vector(outBits downto 0);
		signal adder37x 			: std_logic_vector(outBits downto 0);
		signal adder41x 			: std_logic_vector(outBits downto 0);
		signal adder45x 			: std_logic_vector(outBits downto 0);
		signal adder55x 			: std_logic_vector(outBits downto 0);
		signal adder73x 			: std_logic_vector(outBits downto 0);
		signal adder81x 			: std_logic_vector(outBits downto 0);
		signal adder85x 			: std_logic_vector(outBits downto 0);
		
		-- Third row
		signal shift38x			: std_logic_vector(outBits downto 0);
		signal shift74x			: std_logic_vector(outBits downto 0);
		signal shift78x			: std_logic_vector(outBits downto 0);
		signal shift82x			: std_logic_vector(outBits downto 0);
		signal shift86x			: std_logic_vector(outBits downto 0);
		signal shift88x			: std_logic_vector(outBits downto 0);
		signal shift90x			: std_logic_vector(outBits downto 0);
		
		signal adder43x 			: std_logic_vector(outBits downto 0);
		signal adder89x 			: std_logic_vector(outBits downto 0);
		
		signal sub77x 				: std_logic_vector(outBits downto 0);
		signal sub87x 				: std_logic_vector(outBits downto 0);
	
		-- Ouput signals
		signal x4temp				: std_logic_vector(outBits downto 0);
		signal x9temp				: std_logic_vector(outBits downto 0);
		signal x13temp				: std_logic_vector(outBits downto 0);
		signal x17temp				: std_logic_vector(outBits downto 0);
		signal x21temp 			: std_logic_vector(outBits downto 0);
		signal x26temp 			: std_logic_vector(outBits downto 0);
		signal x30temp 			: std_logic_vector(outBits downto 0);
		signal x34temp 			: std_logic_vector(outBits downto 0);
		signal x38temp 			: std_logic_vector(outBits downto 0);
		signal x42temp 			: std_logic_vector(outBits downto 0);
		signal x46temp 			: std_logic_vector(outBits downto 0);
		signal x50temp 			: std_logic_vector(outBits downto 0);
		signal x53temp 			: std_logic_vector(outBits downto 0);
		signal x56temp 			: std_logic_vector(outBits downto 0);
		signal x60temp				: std_logic_vector(outBits downto 0);
		signal x63temp				: std_logic_vector(outBits downto 0);
		signal x66temp				: std_logic_vector(outBits downto 0);
		signal x68temp				: std_logic_vector(outBits downto 0);
		signal x72temp				: std_logic_vector(outBits downto 0);
		signal x74temp				: std_logic_vector(outBits downto 0);
		signal x77temp				: std_logic_vector(outBits downto 0);
		signal x78temp				: std_logic_vector(outBits downto 0);
		signal x80temp				: std_logic_vector(outBits downto 0);
		signal x82temp				: std_logic_vector(outBits downto 0);
		signal x84temp				: std_logic_vector(outBits downto 0);
		signal x85temp 			: std_logic_vector(outBits downto 0);
		signal x86temp 			: std_logic_vector(outBits downto 0);
		signal x87temp				: std_logic_vector(outBits downto 0);
		signal x88temp				: std_logic_vector(outBits downto 0);
		signal x89temp				: std_logic_vector(outBits downto 0);
		signal x90temp				: std_logic_vector(outBits downto 0);

		
		function my_resize(x: std_logic_vector; new_size: integer) return std_logic_vector is
			variable resized: std_logic_vector(new_size downto 0);
			begin
				resized := std_logic_vector(resize(signed(x), new_size + 1));
				return resized;
			end function my_resize;
		


begin 
		x_resized <= my_resize(x, outBits);
						
--------------------- 1ª linha de deslocadores -----------
		shift4x(outBits downto 2) <= x_resized(outBits - 2 downto 0);
		shift4x(1 downto 0) <= "00";
		
		shift8x(outBits downto 3) <= x_resized(outBits - 3 downto 0); 
		shift8x(2 downto 0) <= "000";
		
		shift16x(outBits downto 4) <= x_resized(outBits - 4 downto 0); 
		shift16x(3 downto 0) <= "0000";
		
		shift32x(outBits downto 5) <= x_resized(outBits - 5 downto 0); 
		shift32x(4 downto 0) <= "00000";
		
		shift64x(outBits downto 6) <= x_resized(outBits - 6 downto 0); 
		shift64x(5 downto 0) <= "000000";

-------------------1ª linha de somadores e subtratores----------------		
		
		sub7x(outBits downto 0) <= shift8x - x_resized;
		sub15x(outBits downto 0) <= shift16x - x_resized;
		sub63x(outBits downto 0) <= shift64x - x_resized;
		
		adder9x(outBits downto 0) <= shift8x + x_resized;
		adder17x(outBits downto 0) <= shift16x + x_resized;
		adder33x(outBits downto 0) <= shift32x + x_resized;
	
-------------------1ª linha de resultados----------------		
		
		x4temp  <= shift4x;
		x9temp  <= adder9x;
		x17temp <= adder17x;
		x63temp <= adder63x;
		
-------------------2ª linha de deslocadores----------------	

		shift24x(outBits downto 3) <= sub3x(outBits - 3 downto 0);
		shift24x(2 downto 0) <= "000";
		
		shift40x(outBits downto 3) <= adder5x(outBits - 3 downto 0);
		shift40x(2 downto 0) <= "000";
		
		shift48x(outBits downto 4) <= sub3x(outBits - 4 downto 0);
		shift48x(3 downto 0) <= "0000";
		
		shift62x(outBits downto 1) <= sub31x(outBits - 1 downto 0);
		shift62x(0) <= '0';
		
		shift68x(outBits downto 2) <= adder17x(outBits - 2 downto 0);
		shift68x(1 downto 0) <= "00";
		
		shift80x(outBits downto 4) <= adder5x(outBits - 4 downto 0);
		shift80x(3 downto 0) <= "0000";
		
---------------2ª linha de subtratores e somadores----------
			
		sub77x(outBits downto 0) <= shift80x - sub3x;
		
		adder11x(outBits downto 0) <= shift8x + sub3x;
		adder25x(outBits downto 0) <= shift24x + x_resized;
		adder55x(outBits downto 0) <= shift24x + sub31x;
		adder73x(outBits downto 0) <= adder5x + shift68x;
		adder81x(outBits downto 0) <= shift80x + x_resized;
		adder85x(outBits downto 0) <= shift80x + adder5x;
			
-------------------2ª linha de resultados----------------		

		x25temp <= adder25x;
		x40temp <= shift40x;
		x48temp <= shift48x;
		x55temp <= adder55x;
		x62temp <= shift62x;
		x68temp <= shift68x;
		x73temp <= adder73x;
		x77temp <= sub77x;
		x81temp <= adder81x;
		x85temp <= adder85x;

-------------------3ª linha de deslocadores----------------
				
		shift88x(outBits downto 3) <= adder11x(outBits - 3 downto 0);
		shift88x(2 downto 0) <= "000";
		
---------------3ª linha de subtratores e somadores----------
		
		sub87x(outBits downto 0) <= shift88x - x_resized;
		
-------------------3ª linha de resultados----------------		

		x87temp <= sub87x;
		x88temp <= shift88x;	
		
-------------------Outputs-------------------------------		
		x8 <= x8temp;
		x17 <= x17temp;
		x25 <= x25temp;
		x33 <= x33temp;
		x40 <= x40temp;
		x48 <= x48temp;
		x55 <= x55temp;
		x62 <= x62temp;
		x68 <= x68temp;
		x73 <= x73temp;
		x77 <= x77temp;
		x81 <= x81temp;		
		x85 <= x85temp;
		x87 <= x87temp;
		x88 <= x88temp;

end behavior;
