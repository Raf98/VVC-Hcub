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
		outBits			:	integer := 19
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
		signal shift64x 			: std_logic_vector(outBits downto 0);
		
		signal sub7x				: std_logic_vector(outBits downto 0);
		signal sub15x				: std_logic_vector(outBits downto 0);
		signal sub63x 				: std_logic_vector(outBits downto 0);
		
		signal adder5x 			: std_logic_vector(outBits downto 0);
		signal adder9x 			: std_logic_vector(outBits downto 0);
		signal adder17x 			: std_logic_vector(outBits downto 0);
		signal adder33x 			: std_logic_vector(outBits downto 0);
		
		
		-- Second row
		signal shift14x			: std_logic_vector(outBits downto 0);
		signal shift18x			: std_logic_vector(outBits downto 0);
		signal shift30x			: std_logic_vector(outBits downto 0);
		signal shift34x			: std_logic_vector(outBits downto 0);
		signal shift36x			: std_logic_vector(outBits downto 0);
		signal shift40x			: std_logic_vector(outBits downto 0);
		signal shift42x			: std_logic_vector(outBits downto 0);
		signal shift56x			: std_logic_vector(outBits downto 0);
		signal shift60x			: std_logic_vector(outBits downto 0);
		signal shift62x			: std_logic_vector(outBits downto 0);
		signal shift66x			: std_logic_vector(outBits downto 0);
		signal shift68x			: std_logic_vector(outBits downto 0);
		signal shift72x			: std_logic_vector(outBits downto 0);
		signal shift80x			: std_logic_vector(outBits downto 0);
		
		signal sub11x 				: std_logic_vector(outBits downto 0);
		signal sub13x 				: std_logic_vector(outBits downto 0);
		signal sub25x 				: std_logic_vector(outBits downto 0);
		signal sub39x 				: std_logic_vector(outBits downto 0);
		signal sub53x 				: std_logic_vector(outBits downto 0);
		
		signal adder11x 			: std_logic_vector(outBits downto 0);
		signal adder19x 			: std_logic_vector(outBits downto 0);
		signal adder21x 			: std_logic_vector(outBits downto 0);
		signal adder23x 			: std_logic_vector(outBits downto 0);
		signal adder25x 			: std_logic_vector(outBits downto 0);
		signal adder37x 			: std_logic_vector(outBits downto 0);
		signal adder41x 			: std_logic_vector(outBits downto 0);
		signal adder45x 			: std_logic_vector(outBits downto 0);
		signal adder85x 			: std_logic_vector(outBits downto 0);
		
		-- Third row
		signal shift26x			: std_logic_vector(outBits downto 0);
		signal shift38x			: std_logic_vector(outBits downto 0);
		signal shift46x			: std_logic_vector(outBits downto 0);
		signal shift50x			: std_logic_vector(outBits downto 0);
		signal shift74x			: std_logic_vector(outBits downto 0);
		signal shift78x			: std_logic_vector(outBits downto 0);
		signal shift82x			: std_logic_vector(outBits downto 0);
		signal shift84x			: std_logic_vector(outBits downto 0);
		signal shift88x			: std_logic_vector(outBits downto 0);
		signal shift90x			: std_logic_vector(outBits downto 0);
		
		signal adder43x 			: std_logic_vector(outBits downto 0);
		signal adder89x 			: std_logic_vector(outBits downto 0);
		
		signal sub77x 				: std_logic_vector(outBits downto 0);
		signal sub87x 				: std_logic_vector(outBits downto 0);
		
		-- Fourth row
		signal shift86x			: std_logic_vector(outBits downto 0);
	
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
		
		adder5x(outBits downto 0) <= shift4x + x_resized;
		adder9x(outBits downto 0) <= shift8x + x_resized;
		adder17x(outBits downto 0) <= shift16x + x_resized;
		adder33x(outBits downto 0) <= shift32x + x_resized;
	
-------------------1ª linha de resultados----------------		
		
		x4temp  <= shift4x;
		x9temp  <= adder9x;
		x17temp <= adder17x;
		x63temp <= sub63x;
		
-------------------2ª linha de deslocadores----------------	

		shift14x(outBits downto 1) <= sub7x(outBits - 1 downto 0);
		shift14x(0) <= '0';
		
		shift18x(outBits downto 1) <= adder9x(outBits - 1 downto 0);
		shift18x(0) <= '0';
		
		shift30x(outBits downto 1) <= sub15x(outBits - 1 downto 0);
		shift30x(0) <= '0';
		
		shift34x(outBits downto 1) <= adder17x(outBits - 1 downto 0);
		shift34x(0) <= '0';
		
		shift36x(outBits downto 2) <= adder9x(outBits - 2 downto 0);
		shift36x(1 downto 0) <= "00";
		
		shift40x(outBits downto 3) <= adder5x(outBits - 3 downto 0);
		shift40x(2 downto 0) <= "000";
		
		shift56x(outBits downto 3) <= sub7x(outBits - 3 downto 0);
		shift56x(2 downto 0) <= "000";
		
		shift60x(outBits downto 2) <= sub15x(outBits - 2 downto 0);
		shift60x(1 downto 0) <= "00";
		
		shift66x(outBits downto 1) <= adder33x(outBits - 1 downto 0);
		shift66x(0) <= '0';
		
		shift68x(outBits downto 2) <= adder17x(outBits - 2 downto 0);
		shift68x(1 downto 0) <= "00";
		
		shift72x(outBits downto 3) <= adder9x(outBits - 3 downto 0);
		shift72x(2 downto 0) <= "000";
		
		shift80x(outBits downto 4) <= adder5x(outBits - 4 downto 0);
		shift80x(3 downto 0) <= "0000";
		
---------------2ª linha de subtratores e somadores----------
		
		sub11x(outBits downto 0) <= shift16x - adder5x;
		sub13x(outBits downto 0) <= shift14x - x_resized;
		sub25x(outBits downto 0) <= shift32x - sub7x;
		sub39x(outBits downto 0) <= shift40x - x_resized;
		sub53x(outBits downto 0) <= shift60x - sub7x;
		
		adder19x(outBits downto 0) <= shift18x + x_resized;
		adder21x(outBits downto 0) <= adder17x + shift4x;
		adder23x(outBits downto 0) <= shift16x + sub7x;
		adder37x(outBits downto 0) <= shift36x + x_resized;
		adder41x(outBits downto 0) <= shift40x + x_resized;
		adder45x(outBits downto 0) <= shift40x + adder5x;
		adder85x(outBits downto 0) <= shift80x + adder5x;
			
-------------------2ª linha de resultados----------------		

		x13temp <= sub13x;
		x21temp <= adder21x;
		x30temp <= shift30x;
		x34temp <= shift34x;
		x53temp <= sub53x;
		x56temp <= shift56x;
		x60temp <= shift60x;
		x66temp <= shift66x;
		x68temp <= shift68x;
		x72temp <= shift72x;
		x80temp <= shift80x;
		x85temp <= adder85x;

-------------------3ª linha de deslocadores----------------
		
		shift26x(outBits downto 1) <= sub13x(outBits - 1 downto 0);
		shift26x(0) <= '0';
		
		shift38x(outBits downto 1) <= adder19x(outBits - 1 downto 0);
		shift38x(0) <= '0';
		
		shift42x(outBits downto 1) <= adder21x(outBits - 1 downto 0);
		shift42x(0) <= '0';
		
		shift46x(outBits downto 1) <= adder23x(outBits - 1 downto 0);
		shift46x(0) <= '0';
		
		shift50x(outBits downto 1) <= sub25x(outBits - 1 downto 0);
		shift50x(0) <= '0';
		
		shift74x(outBits downto 1) <= adder37x(outBits - 1 downto 0);
		shift74x(0) <= '0';
		
		shift78x(outBits downto 1) <= sub39x(outBits - 1 downto 0);
		shift78x(0) <= '0';
		
		shift82x(outBits downto 1) <= adder41x(outBits - 1 downto 0);
		shift82x(0) <= '0';
		
		shift84x(outBits downto 2) <= adder21x(outBits - 2 downto 0);
		shift84x(1 downto 0) <= "00";
		
		shift88x(outBits downto 3) <= sub11x(outBits - 3 downto 0);
		shift88x(2 downto 0) <= "000";
		
		shift90x(outBits downto 1) <= adder45x(outBits - 1 downto 0);
		shift90x(0) <= '0';
		
---------------3ª linha de subtratores e somadores----------
		
		sub77x(outBits downto 0) <= shift78x - x_resized;
		sub87x(outBits downto 0) <= shift88x - x_resized;
		
		adder43x(outBits downto 0) <= shift32x + sub11x;
		adder89x(outBits downto 0) <= shift88x + x_resized;
		
-------------------3ª linha de resultados----------------		

		x26temp <= shift26x;
		x38temp <= shift38x;
		x42temp <= shift42x;
		x46temp <= shift46x;
		x50temp <= shift50x;
		x74temp <= shift74x;
		x77temp <= sub77x;
		x78temp <= shift78x;
		x82temp <= shift82x;
		x84temp <= shift84x;
		x87temp <= sub87x;
		x88temp <= shift88x;
		x89temp <= adder89x;
		x90temp <= shift90x;
		
-------------------4ª linha de deslocadores----------------

		shift86x(outBits downto 1) <= adder43x(outBits - 1 downto 0);
		shift86x(0) <= '0';

-------------------4ª linha de resultados----------------
		
		x86temp <= shift86x;
		
-------------------Outputs-------------------------------

		x4	 <= x4temp;
		x9  <= x9temp;
		x13 <= x13temp;
		x17 <= x17temp;
		x21 <= x21temp;
		x26 <= x26temp;
		x30 <= x30temp;
		x34 <= x34temp;
		x38 <= x38temp;
		x42 <= x42temp;
		x46 <= x46temp;
		x50 <= x50temp;
		x53 <= x53temp;
		x56 <= x56temp;
		x60 <= x60temp;
		x63 <= x63temp;
		x66 <= x66temp;
		x68 <= x68temp;
		x72 <= x72temp;
		x74 <= x74temp;
		x77 <= x77temp;
		x78 <= x78temp;
		x80 <= x80temp;
		x82 <= x82temp;
		x84 <= x84temp;
		x85 <= x85temp;
		x86 <= x86temp;
		x87 <= x87temp;
		x88 <= x88temp;
		x89 <= x89temp;
		x90 <= x90temp;

end behavior;
