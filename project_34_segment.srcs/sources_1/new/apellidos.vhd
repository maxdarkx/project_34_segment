----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2017 08:07:25
-- Design Name: 
-- Module Name: apellidos - Behavioral
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

entity apellidos is
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
end apellidos;

architecture Behavioral of apellidos is
	component display_34 is
	generic
	(
		lw:   integer := 10;
		dl:   integer := 50;
		dh:   integer := 100
		
	);
	Port (
		value:  in std_logic_vector(5 downto 0);
		hcount: in std_logic_vector(10 downto 0);
		vcount: in std_logic_vector(10 downto 0);
		paint:  out std_logic;
		posx: in integer ;
		posy: in integer 
			
	);
	end component;

	constant dl:  integer := 50; --largo del caracter
	constant dh:  integer := 100; --altura del caracter
	constant lw:  integer := 5; 	--ancho de las lineas
	constant esh: integer := 10; --espacio entre caracterers

	constant th: integer := 640;
	constant tv: integer := 480;

	constant CCM : integer := 4; -- cantidad de letras para maya 
	constant CCJ : integer := 8; --cantidad de letras para jaramillo
	constant cf :integer := 2;

	constant EVU : integer := cf*(dh+esh); -- espacio vertical utilizado
	constant EHUM: integer := CCM*(dl+esh) ; --Espacio horizontal total utilizado por el apellido maya
	constant EHUJ: integer := CCj*(dl+esh) ; --Espacio horizontal total utilizado por el apellido jaramillo

	signal m0,m1,m2,m3 : std_logic;
	signal j0,j1,j2,j3,j4,j5,j6,j7,j8 : std_logic;
	signal px1,px10,px11,px12,px13: integer;
	signal px2,px20,px21,px22,px23,px24,px25,px26,px27,px28: integer; 
	signal py,py2: integer;
begin


px1 <= 	0	 			when sel = "0000" else --0000	Izquierda – Arriba
		(th-ehum)/2 	when sel = "0001" else --0110	Centrado arriba
		th-ehum			when sel = "0010" else --1010	Derecha – Arriba
		0				when sel = "0011" else --1110	Izquierda – Centro
		(th-ehum)/2 	when sel = "0100" else --0010	Centrado – Centro
		th-ehum			when sel = "0101" else --0100	derecha – centro
		0	 			when sel = "0110" else --1000	Izquierda – Abajo
		(th-ehum)/2 	when sel = "0111" else --1001	Centrado- Abajo
		th-ehum;							   --1101	Derecha –abajo
		--1110	Una línea  diagonal desde extremo del lado izquierdo-abajo al extremos derecho-arriba del display  de 16 pixel de alto

px2 <= 	0	 			when sel = "0000" else --0000	Izquierda – Arriba
		(th-ehuj-1)/2 	when sel = "0001" else --0110	Centrado arriba
		th-ehuj-1		when sel = "0010" else --1010	Derecha – Arriba
		0				when sel = "0011" else --1110	Izquierda – Centro
		(th-ehuj-1)/2 	when sel = "0100" else --0010	Centrado – Centro
		th-ehuj-1		when sel = "0101" else --0100	derecha – centro
		0	 			when sel = "0110" else --1000	Izquierda – Abajo
		(th-ehuj-1)/2 	when sel = "0111" else --1001	Centrado- Abajo
		th-ehuj-1;							   --1101	Derecha –abajo
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
--px14<=px1 + 4*(dl + esh);
--px15<=px1 + 5*(dl + esh);
--px16<=px1 + 6*(dl + esh);
--px17<=px1 + 7*(dl + esh);
--px18<=px1 + 8*(dl + esh);
--px19<=px1 + 4*(dl + esh);

px21<= px2 +dl + esh;
px22<=px2 + 2*(dl + esh);
px23<= px2 + 3*(dl + esh);
px24<=px2 + 4*(dl + esh);
px25<=px2 + 5*(dl + esh);
px26<=px2 + 6*(dl + esh);
px27<=px2 + 7*(dl + esh);
px28<=px2 + 8*(dl + esh);
--px29<=px2 + 9*(dl + esh);

py2<=py2;

mm0: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh
			)
		Port map 
		(
			value  => "001100",
			hcount => hcount,
			vcount => vcount,
			paint => m0,
			POSX => px10,
			POSY => py
		);

mm1: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "000000",
			hcount => hcount,
			vcount => vcount,
			paint => m1,
			POSX => px11,
			POSY => py
		);

mm2: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "011000",
			hcount => hcount,
			vcount => vcount,
			paint => m2,
			POSX =>  px12,
			POSY => py
		);

mm3: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "000000",
			hcount => hcount,
			vcount => vcount,
			paint => m3,
			POSX => px13,
			POSY => py
		);



jj0: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001001",
			hcount => hcount,
			vcount => vcount,
			paint => j0,
			POSX => px20,
			POSY => py2
		);

jj1: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "000000",
			hcount => hcount,
			vcount => vcount,
			paint => j1,
			POSX => px21,
			POSY => py2
		);

jj2: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "010001",
			hcount => hcount,
			vcount => vcount,
			paint => j2,
			POSX =>  px22,
			POSY => py2
		);

jj3: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "000000",
			hcount => hcount,
			vcount => vcount,
			paint => j3,
			POSX =>  px23,
			POSY => py2
		);


jj4: display_34 
		GENERIC MAP (
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001100",
			hcount => hcount,
			vcount => vcount,
			paint => j4,
			POSX =>  px24,
			POSY => py2
		);

jj5: display_34 

		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001000",
			hcount => hcount,
			vcount => vcount,
			paint => j5,
			POSX =>  px25,
			POSY => py2
		);

jj6: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001011",
			hcount => hcount,
			vcount => vcount,
			paint => j6,
			POSX =>  px26,
			POSY => py2
		);

jj7: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001011",
			hcount => hcount,
			vcount => vcount,
			paint => j7,
			POSX => px27,
			POSY => py2
		);

jj8: display_34 
		GENERIC MAP
		(
			LW => lw,
			DL => dl,
			DH => dh)
		Port map 
		(
			value  => "001110",
			hcount => hcount,
			vcount => vcount,
			paint => j8,
			POSX => px28,
			POSY => py2
		);



paint<=m0 or m1 or m2 or m3 or j0 or j1 or j2 or j3 or j4 or j5 or j6 or j7 or j8;


end Behavioral;
