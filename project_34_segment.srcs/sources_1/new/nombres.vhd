----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2017 08:07:25
-- Design Name: 
-- Module Name: nombres - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- ANNitional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity nombres is --JUAN CARLOS=10/ MAURICIO=8
port(
	hcount: in 	std_logic_vector(10 downto 0);
	vcount: in 	std_logic_vector(10 downto 0);
	sel: 	in 	STD_LOGIC_VECTOR(3 downto 0);
	value:  out	std_logic_vector(5 downto 0);
	posx: 	out integer;
	posy: 	out integer
	);
end nombres;

architecture Behavioral of nombres is

	constant dl:  integer := 30; --largo del caracter
	constant dh:  integer := 60; --altura del caracter
	constant lw:  integer := 3; 	--ancho de las lineas
	constant esh: integer := 3; --espacio entre caracterers

	constant th: integer := 640;
	constant tv: integer := 480;

	constant CC1 : integer := 10; -- cantidad de letras para primera fila (grupo N01=8) 
	constant CC2 : integer := 8; --cantidad de letras para segunda fila (viernes=7)
	constant esl : integer := dl+lw; --espacio entre palabras

	constant EVU : integer := cc1*(dh+esh); -- espacio vertical utilizado
	constant EHU1: integer := cc1*(dl+esh) ; --Espacio horizontal total utilizado fila 1
	constant EHU2: integer := cc2*(dl+esh) ; --Espacio horizontal total utilizado fila 2
 
	
begin


checker: process(hcount,vcount,sel)
variable px1,px10,px11,px12,px13,px14,px15,px16,px17,px18,px19,px101: integer:=0;
variable px2,px20,px21,px22,px23,px24,px25,px26,px27,px28,px29,px201: integer:=0;
variable py1,py2,py3: integer;
begin





case sel is
when "0000" =>	 			--0000	Izquierda – Arriba

	px1 := 	0;	 		
	px2 := 	0;
	py1 := 	0;
when "0001" =>				 --0001	Centrado arriba
	px1 := (th-ehu1-1)/2;
	px2 := (th-ehu2-1)/2; 
	py1 :=	0;
when "0010"	=>				 --0010	Derecha – Arriba
	px1 := th-ehu1-1;
	px2 := th-ehu2-1;
	py1 := 0;
when "0011"	=>				 --0011	Izquierda – Centro		
	px1 := 0;
	px2 := 0;
	py1 := (tv - EVU)/2;
when "0100"	=>				 --0100 Centrado – Centro
	px1 := (th-ehu1-1)/2 ;
	px2 := (th-ehu2-1)/2;
	py1 := (tv - EVU)/2;
when "0101"	=>				 --0101 derecha – centro
	px1 := th-ehu1-1;
	px2 := th-ehu2-1;
	py1 := (tv - EVU)/2;
when "0110"	=>				--0110 Izquierda – Abajo
	px1 := 0;
	px2 := 0;
	py1 := tv - EVU;
when "0111"	=>	
	px1 := (th-ehu1)/2;		--0111 Centrado- Abajo
	px2 := (th-ehu2)/2 ;
	py1 := tv - EVU;
when others	=>				--1000 Derecha –abajo
	px1 := th-ehu1;
	px2 := th-ehu2;
	py1 := tv - EVU;							   
end case;

py2:=py1+dh+esl;											   --1110	Una línea  diagonal desde extremo del lado izquierdo-abajo al extremos derecho-arriba del display  de 16 pixel de alto
py3:=py1+2*dh;

px10:= px1;
px11:= px1 + dl + esh;
px12:= px1 + 2*(dl + esh);
px13:= px1 + 3*(dl + esh);
px14:= px1 + 4*(dl + esh)+esl;
px15:= px1 + 5*(dl + esh)+esl;
px16:= px1 + 6*(dl + esh)+esl;
px17:= px1 + 7*(dl + esh)+esl;
px18:= px1 + 8*(dl + esh)+esl;
px19:= px1 + 9*(dl + esh)+esl;
px101:=px1 + 10*(dl + esh);

px20:= px2;
px21:= px2 +dl + esh;
px22:= px2 + 2*(dl + esh);
px23:= px2 + 3*(dl + esh);
px24:= px2 + 4*(dl + esh);
px25:= px2 + 5*(dl + esh);
px26:= px2 + 6*(dl + esh);
px27:= px2 + 7*(dl + esh);
px201:= px2 + 8*(dl + esh);

if (vcount > py1) and (vcount <py2) then
	posy<=py1;

	if    hcount>px10 and hcount<px11 then
		posx<=px10;
		value<="001001"; --J
	elsif hcount>px11 and hcount<px12 then
		posx<=px11;
		value<="010100"; --u
	elsif hcount>px12 and hcount<px13 then
		posx<=px12;
		value<="000000"; --a
	elsif hcount>px13 and hcount<px14 then
		posx<=px13;
		value<="001101"; --n
	elsif hcount>px14 and hcount<px15 then
		posx<=px14;
		value<="000010"; --c
	elsif hcount>px15 and hcount<px16 then
		posx<=px15;
		value<="000000"; --a
	elsif hcount>px16 and hcount<px17 then
		posx<=px16;
		value<="010001"; --r
	elsif hcount>px17 and hcount<px18 then
		posx<=px17;
		value<="001011"; --l
	elsif hcount>px18 and hcount<px19 then
		posx<=px18;
		value<="001110"; --o
	elsif  hcount>px19 and hcount<px101 then
		posx<=px19;
		value<="010010"; --s
	else
		posx<=px10;
		value<="100100"; --error
	end if;	
elsif vcount > py2 and vcount <py3 then
	posy<=py2;
	if    hcount>px20 and hcount<px21 then
		posx<=px20;
		value<="001100"; --m
	elsif hcount>px21 and hcount<px22 then
		posx<=px21;
		value<="000000"; --a
	elsif hcount>px22 and hcount<px23 then
		posx<=px22;
		value<="010100"; --u
	elsif hcount>px23 and hcount<px24 then
		posx<=px23;
		value<="010001"; --r
	elsif hcount>px24 and hcount<px25 then
		posx<=px24;
		value<="001000"; --i
	elsif hcount>px25 and hcount<px26 then
		posx<=px25;
		value<="000010"; --c
	elsif hcount>px26 and hcount<px27 then
		posx<=px26;
		value<="001000"; --i
	elsif hcount>px27 and hcount<px201 then
		posx<=px27;
		value<="001110"; --o
	else
		posx<=px20;
		value<="100100"; --error
	end if;
else
	posy<=py1;
end if;

end process;


end Behavioral;
