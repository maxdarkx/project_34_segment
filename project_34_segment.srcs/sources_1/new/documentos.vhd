----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2017 08:07:25
-- Design Name: 
-- Module Name: documentos - Behavioral
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

entity documentos is
Port (
	sel: in STD_LOGIC_VECTOR(3 downto 0);
	hcount: in std_logic_vector(10 downto 0);
	vcount: in std_logic_vector(10 downto 0);
	paint: 	out std_logic
	--se selecciona la posicion en la pantalla:
	--0000	Izquierda – Arriba
--0110	Centrado arriba
--1010	Derecha – Arriba
--1110	Izquierda – Centro
--0010	Centrado – Centro
--0100	derecha – centro
--1000	Izquierda – Abajo
--1001	Centrado- Abajo
--1101	Derecha –abajo
--1110	Una línea  diagonal desde extremo del lado izquierdo-abajo al extremos derecho-arriba del display  de 16 pixel de alto
);
end documentos;

architecture Behavioral of documentos is





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
		posx: in integer;
		posy: in integer
			
	);
	end component;

	constant dl:  integer := 50; --largo del caracter
	constant dh:  integer := 100; --altura del caracter
	constant lw:  integer := 5; 	--ancho de las lineas
	constant esh: integer := 10; --espacio entre caracterers

	constant th: integer := 640;
	constant tv: integer := 480;

	constant CC1 : integer := 10; -- cantidad de letras para maya 
	constant CC2 : integer := 10; --cantidad de letras para jaramillo

	constant EVU : integer := cc1*(dh+esh); -- espacio vertical utilizado
	constant EHU1: integer := cc1*(dl+esh) ; --Espacio horizontal total utilizado por la cedula 1
	constant EHU2: integer := cc2*(dl+esh) ; --Espacio horizontal total utilizado por la cedula 2
	signal px1,px10,px11,px12,px13,px14,px15,px16,px17,px18,px19: integer;
	signal px2,px20,px21,px22,px23,px24,px25,px26,px27,px28,px29: integer; 
	signal py,py2: integer;
	signal c1,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19 : std_logic;
	signal c2,c20,c21,c22,c23,c24,c25,c26,c27,c28,c29 : std_logic;
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
px15<=px1 + 5*(dl + esh);
px16<=px1 + 6*(dl + esh);
px17<=px1 + 7*(dl + esh);
px18<=px1 + 8*(dl + esh);
px19<=px1 + 4*(dl + esh);
px20<=px2;

py2<=py+dh+esh;

ced10: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "011011",--1
			hcount => hcount,
			vcount => vcount,
			paint => c10,
			POSX => px10,
			POSY => py
		);

ced11: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "011010",--0
			hcount => hcount,
			vcount => vcount,
			paint => c11,
			POSX => px11 ,
			POSY => py
		);
		
		

ced12: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "011011",--1
			hcount => hcount,
			vcount => vcount,
			paint => c12,
			POSX => px12,
			POSY => py
		);

ced13: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "100001",--7
			hcount => hcount,
			vcount => vcount,
			paint => c13,
			POSX =>  px13,
			POSY => py
		);

ced14: display_34 
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
			paint => c14,
			POSX => px14,
			POSY => py
		);

ced15: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011101",--3
			hcount => hcount,
			vcount => vcount,
			paint => c15,
			POSX => px15,
			POSY => py
		);

ced16: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "011011",--1
			hcount => hcount,
			vcount => vcount,
			paint => c16,
			POSX => px16,
			POSY => py
		);


ced17: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "100011",--9
			hcount => hcount,
			vcount => vcount,
			paint => c17,
			POSX => px17,
			POSY => py
		);

ced18: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "100000",--6
			hcount => hcount,
			vcount => vcount,
			paint => c18,
			POSX => px18,
			POSY => py
		);

ced19: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "100000",--6
			hcount => hcount,
			vcount => vcount,
			paint => c19,
			POSX => px19,
			POSY => py
		);


ced20: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "011011",--1
			hcount => hcount,
			vcount => vcount,
			paint => c20,
			POSX => px20,
			POSY => py2
		);


px21<= px2 +dl + esh;
ced21: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c21,
			POSX =>px21,
			POSY => py2
		);
px22<=px2 + 2*(dl + esh);
ced22: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c22,
			POSX => px22,
			POSY => py2
		);
px23<= px2 + 3*(dl + esh);
ced23: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c23,
			POSX => px23,
			POSY => py2
		);
px24<=px2 + 4*(dl + esh);
ced24: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c24,
			POSX => px24 ,
			POSY => py2
		);

px25<=px2 + 5*(dl + esh);
ced25: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c25,
			POSX =>  px25,
			POSY => py2
		);
px26<=px2 + 6*(dl + esh);
ced26: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c26,
			POSX =>  px26,
			POSY => py2
		);
px27<=px2 + 7*(dl + esh);
ced27: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c27,
			POSX => px27 ,
			POSY => py2
		);
px28<=px2 + 8*(dl + esh);
ced28: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c28,
			POSX => px28,
			POSY => py
		);
px29<=px2 + 9*(dl + esh);
ced29: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011011",
			hcount => hcount,
			vcount => vcount,
			paint => c29,
			POSX => px29,
			POSY => py
		);


c1<= c10 or c11 or c12 or c13 or c14 or c15 or c16 or c17 or c18 or c19;
c2<= c20 or c21 or c22 or c23 or c24 or c25 or c26 or c27 or c28 or c29;
paint<=c1 or c2;


end Behavioral;
