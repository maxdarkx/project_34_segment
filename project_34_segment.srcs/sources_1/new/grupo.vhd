----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2017 08:07:25
-- Design Name: 
-- Module Name: grupo - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity grupo is --GRUPO N 01=8/ VIERNES=7
Port (
	sel: in STD_LOGIC_VECTOR(3 downto 0);
	hcount: in std_logic_vector(10 downto 0);
	vcount: in std_logic_vector(10 downto 0);
	paint: 	out std_logic
);
end grupo;

architecture Behavioral of grupo is

	component display_34 is
	generic
	(
		lw:   in integer := 10;
		dl:   in integer := 50;
		dh:   in integer := 100
		
	);
	Port (
		value:  in std_logic_vector(5 downto 0);
		hcount: in std_logic_vector(10 downto 0);
		vcount: in std_logic_vector(10 downto 0);
		paint:  out std_logic;
		posx: in integer := 0;
		posy: in integer := 0
			
	);
	end component;

	constant dl:  integer := 50; --largo del caracter
	constant dh:  integer := 100; --altura del caracter
	constant lw:  integer := 5; 	--ancho de las lineas
	constant esh: integer := 10; --espacio entre caracterers

	constant th: integer := 640;
	constant tv: integer := 480;

	constant CC1 : integer := 8; -- cantidad de letras para primera fila (grupo N01=8) 
	constant CC2 : integer := 7; --cantidad de letras para segunda fila (viernes=7)
	constant esl : integer := dl+lw; --espacio entre palabras

	constant EVU : integer := cc1*(dh+esh); -- espacio vertical utilizado
	constant EHU1: integer := cc1*(dl+esh) ; --Espacio horizontal total utilizado fila 1
	constant EHU2: integer := cc2*(dl+esh) ; --Espacio horizontal total utilizado fila 2


	signal d1,d10,d11,d12,d13,d14,d15,d16,d17: std_logic;
	signal d2,d20,d21,d22,d23,d24,d25,d26: std_logic;
	signal px1,px10,px11,px12,px13,px14,px15,px16,px17: integer;
	signal px2,px20,px21,px22,px23,px24,px25,px26: integer; 
	signal py,py2: integer;
begin


px1 <= 	0	 			when sel = "0000" else --0000	Izquierda – Arriba
		(th-ehu1)/2 	when sel = "0001" else --0110	Centrado arriba
		th-ehu1			when sel = "0010" else --1010	Derecha – Arriba
		0				when sel = "0011" else --1110	Izquierda – Centro
		(th-ehu1)/2 	when sel = "0100" else --0010	Centrado – Centro
		th-ehu1			when sel = "0101" else --0100	derecha – centro
		0	 			when sel = "0110" else --1000	Izquierda – Abajo
		(th-ehu1)/2 	when sel = "0111" else --1001	Centrado- Abajo
		th-ehu1;							   --1101	Derecha –abajo
		--1110	Una línea  diagonal desde extremo del lado izquierdo-abajo al extremos derecho-arriba del display  de 16 pixel de alto

px2 <= 	0	 			when sel = "0000" else --0000	Izquierda – Arriba
		(th-ehu2-1)/2 	when sel = "0001" else --0110	Centrado arriba
		th-ehu2-1		when sel = "0010" else --1010	Derecha – Arriba
		0				when sel = "0011" else --1110	Izquierda – Centro
		(th-ehu2-1)/2 	when sel = "0100" else --0010	Centrado – Centro
		th-ehu2-1		when sel = "0101" else --0100	derecha – centro
		0	 			when sel = "0110" else --1000	Izquierda – Abajo
		(th-ehu2-1)/2 	when sel = "0111" else --1001	Centrado- Abajo
		th-ehu2-1;							   --1101	Derecha –abajo
		--1110	Una línea  diagonal desde extremo del lado izquierdo-abajo al extremos derecho-arriba del display  de 16 pixel de alto

py <= 	0	 			when sel = "0000" else --0000	Izquierda – Arriba
		0 				when sel = "0001" else --0110	Centrado arriba
		0				when sel = "0010" else --1010	Derecha – Arriba
		(tv - EVU)/2	when sel = "0011" else --1110	Izquierda – Centro
		(tv - EVU)/2 	when sel = "0100" else --0010	Centrado – Centro
		(tv - EVU)/2	when sel = "0101" else --0100	derecha – centro
		tv - EVU		when sel = "0110" else --1000	Izquierda – Abajo
		tv - evu 		when sel = "0111" else --1001	Centrado- Abajo
		tv - evu;							   --1101	Derecha –abajo
											   --1110	Una línea  diagonal desde extremo del lado izquierdo-abajo al extremos derecho-arriba del display  de 16 pixel de alto
px10<=px1;
px11<=px1 + dl + esh;
px12<=px1 + 2*(dl + esh);
px13<=px1 + 3*(dl + esh);
px14<=px1 + 4*(dl + esh);
px15<=px1 + 5*(dl + esh)+esl;
px16<=px1 + 6*(dl + esh)+esl;
px17<=px1 + 7*(dl + esh)+esl;

px20<=px2;
px21<= px2 +dl + esh;
px22<=px2 + 2*(dl + esh);
px23<= px2 + 3*(dl + esh);
px24<=px2 + 4*(dl + esh);
px25<=px2 + 5*(dl + esh);


py2<=py2;



dd10: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "000110",--G
			hcount => hcount,
			vcount => vcount,
			paint => d10,
			POSX => px10,
			POSY => py
		);

dd11: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "010001",--R
			hcount => hcount,
			vcount => vcount,
			paint => d11,
			POSX =>  px11,
			POSY => py
		);

dd12: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "010100",--U
			hcount => hcount,
			vcount => vcount,
			paint => d12,
			POSX => px12,
			POSY => py
		);

dd13: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001111",--P
			hcount => hcount,
			vcount => vcount,
			paint => d13,
			POSX =>  px13,
			POSY => py
		);

dd14: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001110",--O
			hcount => hcount,
			vcount => vcount,
			paint => d14,
			POSX => px14,
			POSY => py
		);

dd15: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001101",--N
			hcount => hcount,
			vcount => vcount,
			paint => d15,
			POSX => px15,
			POSY => py
		);

dd16: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011010",--0
			hcount => hcount,
			vcount => vcount,
			paint => d16,
			POSX => px16,
			POSY => py
		);

dd17: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011011",--1
			hcount => hcount,
			vcount => vcount,
			paint => d17,
			POSX => px17,
			POSY => py
		);


dd20: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "010101",--V
			hcount => hcount,
			vcount => vcount,
			paint => d20,
			POSX => px20,
			POSY => py2
		);


dd21: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001000", --I
			hcount => hcount,
			vcount => vcount,
			paint => d21,
			POSX => px21,
			POSY => py2
		);

dd22: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "000100", --E
			hcount => hcount,
			vcount => vcount,
			paint => d22,
			POSX => px22,
			POSY => py2
		);

dd23: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "010001",--R
			hcount => hcount,
			vcount => vcount,
			paint => d23,
			POSX =>  px23,
			POSY => py2
		);

dd24: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001101", --N
			hcount => hcount,
			vcount => vcount,
			paint => d24,
			POSX =>  px24,
			POSY => py2
		);


dd25: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "000100", --E
			hcount => hcount,
			vcount => vcount,
			paint => d25,
			POSX =>  px25,
			POSY => py2
		);

dd26: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "010010", --S
			hcount => hcount,
			vcount => vcount,
			paint => d26,
			POSX =>  px26,
			POSY => py2
		);



d1<= d10 or d11 or d12 or d13 or d14 or d15 or d16 or d17;
d2<= d20 or d21 or d22 or d23 or d24 or d25 or d26;
paint<=d1 or d2;


end Behavioral;
