-- MCU-Hcub de 8 pontos para DST-VII 
-- Rafael Santos; André Marcelo Coelho da Silva
-- Created: 18/12/2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_signed.all;


entity MCUHcubparaDSTVII8x8 is
port (

x 	: in std_logic_vector (8 downto 0);
--17 & 32 & 46 & 60 & 71 & 78 & 85 & 86
x17	: out std_logic_vector (15 downto 0);
x32 	: out std_logic_vector (15 downto 0);
x46 	: out std_logic_vector (15 downto 0);
x60	: out std_logic_vector (15 downto 0);
x71	: out std_logic_vector (15 downto 0);
x78 	: out std_logic_vector (15 downto 0);
x85 	: out std_logic_vector (15 downto 0);
x86	: out std_logic_vector (15 downto 0)
);


end entity;


architecture behavior of MCUHcubparaDSTVII8x8 is
		signal x_resized			: std_logic_vector(15 downto 0);
		
		-- First row
		signal shift8x 			: std_logic_vector(11 downto 0);
		signal shift16x 			: std_logic_vector(12 downto 0);
		signal shift32x 			: std_logic_vector(13 downto 0);
		
		signal sub15x 				: std_logic_vector(12 downto 0);
		
		signal adder17x 			: std_logic_vector(12 downto 0);
		
		
		-- Second row
		signal shift46x			: std_logic_vector(13 downto 0);
		signal shift60x			: std_logic_vector(14 downto 0);
		signal shift68x			: std_logic_vector(14 downto 0);
		
		signal sub43x				: std_logic_vector(14 downto 0);
		
		signal adder23x 			: std_logic_vector(12 downto 0);
		signal adder85x 			: std_logic_vector(14 downto 0);
		
		-- Third row
		signal shift78x			: std_logic_vector(13 downto 0);
		signal shift86x			: std_logic_vector(15 downto 0);
				
		signal sub71x 				: std_logic_vector(15 downto 0);
	
		signal adder39x 			: std_logic_vector(13 downto 0);
		
		signal x17temp				: std_logic_vector(15 downto 0);
		signal x32temp 			: std_logic_vector(15 downto 0);
		signal x46temp 			: std_logic_vector(15 downto 0);
		signal x60temp				: std_logic_vector(15 downto 0);
		signal x71temp				: std_logic_vector(15 downto 0);
		signal x78temp 			: std_logic_vector(15 downto 0);
		signal x85temp 			: std_logic_vector(15 downto 0);
		signal x86temp				: std_logic_vector(15 downto 0);

		
		function my_resize(x: std_logic_vector; new_size: integer) return std_logic_vector is
			variable resized: std_logic_vector(new_size - 1 downto 0);
			begin
				resized := std_logic_vector(resize(signed(x), new_size));
				return resized;
			end function my_resize;
		


begin 
						
--------------------- 1ª linha de deslocadores -----------		
		shift8x(11 downto 3) <= x_resized(8 downto 0); 
		shift8x(2 downto 0) <= "000";
		
		shift16x(12 downto 4) <= x(8 downto 0); 
		shift16x(3 downto 0) <= "0000";
		
		shift32x(13 downto 5) <= x(8 downto 0); 
		shift32x(4 downto 0) <= "00000";

-------------------1ª linha de somadores e subtratores----------------		
		
		sub15x(12 downto 0) <= shift16x - my_resize(x, 13);
		adder17x(12 downto 0) <= shift16x + my_resize(x, 13);
		
-------------------1ª linha de resultados----------------		
		
		x17temp <= my_resize(adder17x, 16);
		x32temp <= my_resize(shift32x, 16);
		
-------------------2ª linha de deslocadores----------------			
		
		shift46x(13 downto 1) <= adder23x(12 downto 0);
		shift46x(0) <= '0';
		
		shift60x(14 downto 2) <= sub15x(12 downto 0);
		shift60x(1 downto 0) <= "00";
		
		shift68x(14 downto 2) <= adder17x(12 downto 0);
		shift68x(1 downto 0) <= "00";
		
---------------2ª linha de subtratores e somadores----------		
		
		sub43x(14 downto 0) <= shift60x - my_resize(adder17x, 15);
		adder23x(12 downto 0) <= sub15x + my_resize(shift8x, 13);
		adder85x(14 downto 0) <= my_resize(adder17x, 15) + shift68x;
		
-------------------2ª linha de resultados----------------		

		x46temp <= my_resize(shift46x, 16);
		x60temp <= my_resize(shift60x, 16);
		x85temp <= my_resize(adder85x, 16);

-------------------3ª linha de deslocadores----------------			
		
		shift78x(13 downto 1) <= adder39x(12 downto 0);
		shift78x(0) <= '0';
		
		shift86x(15 downto 1) <= sub43x(14 downto 0);
		shift86x(0) <= '0';
		
---------------3ª linha de subtratores e somadores----------
		
		sub71x(15 downto 0) <= shift86x - my_resize(sub15x, 16); -- verificar se essa eh a ordem, considerando o arvore do Spiral
		adder39x(12 downto 0) <= adder23x + shift16x;
		
-------------------3ª linha de resultados----------------		

		x71temp <= sub71x;
		x78temp <= my_resize(shift78x, 16);
		x86temp <= shift86x;
		
-------------------***1º Resultado***------------------------		
--		x29temp(13 downto 0) <= s_adder1(13 downto 0);
--		x29temp(14) <= '0';
--		x29temp(15) <= '0';
-----------------------------FIM-----------------------------	
--
------------------***2º Resultado***-------------------------		
--
--		x55temp(14 downto 0) <= s_sub3(14 downto 0);
--		x55temp(15) <= '0';
-----------------------------FIM-----------------------------	
--
----------------***3º e 4º Resultados***--------------------			
--		x84temp(15 downto 2) <= s_sub2(13 downto 0);
--		x84temp(0) <= '0';
--		x84temp(1) <= '0';
--		
--		x74temp(15 downto 1) <= s_adder2(14 downto 0);
--		x74temp(0) <= '0';	
-----------------------------FIM-----------------------------		
		

		x17 <= x17temp;
		x32 <= x32temp;
		x46 <= x46temp;
		x60 <= x60temp;
		x71 <= x71temp;
		x78 <= x78temp;
		x85 <= x85temp;
		x86 <= x86temp;

end behavior;
