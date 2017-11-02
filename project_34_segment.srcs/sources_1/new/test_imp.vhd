----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2017 16:33:25
-- Design Name: 
-- Module Name: test_imp - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_imp is
Port ( 
       CLK :   in  STD_LOGIC;
       hcount: in  STD_LOGIC_VECTOR (10 downto 0);  --poner para simular
       vcount: in  STD_LOGIC_VECTOR (10 downto 0);	--poner para simular
     --  RST : in  STD_LOGIC;	--quitar para simulacion
     --  HS :  out  STD_LOGIC; --quitar para simulacion
     -- VS : out  STD_LOGIC;	--quitar para simulacion
       sel: in std_logic_vector(1 downto 0); -- selector entre grupo, cedulas, nombres y apellidos
       ori: in std_logic_vector(3 downto 0); --selector de la orientacion
       RGB : out  STD_LOGIC_VECTOR (11 downto 0)
    );

end test_imp;

architecture Behavioral of test_imp is

	COMPONENT vga_ctrl_640x480_60Hz
	PORT(
			rst : IN std_logic;
			clk : IN std_logic;
			rgb_in : IN std_logic_vector(11 downto 0);          
			HS : OUT std_logic;
			VS : OUT std_logic;
			hcount : OUT std_logic_vector(10 downto 0);
			vcount : OUT std_logic_vector(10 downto 0);
			rgb_out : OUT std_logic_vector(11 downto 0);
			blank : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT display_34 
	GENERIC ( 
		lw:   in integer := 10;
		dl:   in integer := 50;
		dh:   in integer := 100
    ); 
    PORT
    ( 
	    value:  in 	std_logic_vector(5 downto 0);
        hcount: in 	std_logic_vector(10 downto 0);
        vcount: in 	std_logic_vector(10 downto 0);
        paint:  out std_logic;
		posx: 	in 	integer;
		posy: 	in 	integer
    );
	end COMPONENT;
	
	component nombres
	Port 
	(
		hcount: in 	std_logic_vector(10 downto 0);
		vcount: in 	std_logic_vector(10 downto 0);
		sel: 	in 	STD_LOGIC_VECTOR(3 downto 0);
		value:  out	std_logic_vector(5 downto 0);
		posx: 	out integer;
		posy: 	out integer
	);
	end component;

	component documentos
	Port 
	(
		hcount: in 	std_logic_vector(10 downto 0);
		vcount: in 	std_logic_vector(10 downto 0);
		sel: 	in 	STD_LOGIC_VECTOR(3 downto 0);
		value:  out	std_logic_vector(5 downto 0);
		posx: 	out integer;
		posy: 	out integer
	);
	end component;

	component apellidos
	Port 
	(
		hcount: in 	std_logic_vector(10 downto 0);
		vcount: in 	std_logic_vector(10 downto 0);
		sel: 	in 	STD_LOGIC_VECTOR(3 downto 0);
		value:  out	std_logic_vector(5 downto 0);
		posx: 	out integer;
		posy: 	out integer
	);
	end component;

	component grupo
	Port 
	(
		hcount: in 	std_logic_vector(10 downto 0);
		vcount: in 	std_logic_vector(10 downto 0);
		sel: 	in 	STD_LOGIC_VECTOR(3 downto 0);
		value:  out	std_logic_vector(5 downto 0);
		posx: 	out integer;
		posy: 	out integer
	);
	end component;
	
	-- Declaramos seales
	signal val,val1,val2,val3,val4: STD_LOGIC_VECTOR(5 downto 0):=(others=>'0') ;
	--signal hcount : STD_LOGIC_VECTOR (10 downto 0):=(others=>'0'); --comentar para simular
	--signal vcount : STD_LOGIC_VECTOR (10 downto 0):=(others=>'0'); --comentar para simular
    signal paint0,paint1,paint2,paint3 : STD_LOGIC:='0';
    signal rgb_x: std_logic:='0';
    signal rgb_aux : STD_LOGIC_VECTOR (11 downto 0):=(others=>'0');
    signal rgb_auxx : STD_LOGIC_VECTOR (11 downto 0):=(others=>'0');
	signal rgb_aux1 : STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal rgb_aux2 : STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal rgb_aux3 : STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal CLK_1Hz : STD_LOGIC:='0';
	signal count_clk : INTEGER:=0;
	signal count_color: integer:=0;
	signal clk_interno : STD_LOGIC:='0';
	signal count_1hz: INTEGER := 0;
	signal px,px1,px2,px3,px4: integer:=0;
	signal py,py1,py2,py3,py4: integer:=0;
	signal cont: std_logic_vector(3 downto 0):="0000";
	signal cont1: std_logic_vector(3 downto 0):="0000";

begin


--______________________________________________________________
--comentar para simular
--______________________________________________________________
 --	CLK_50MHZ: process (CLK)
 --   begin  
 --       if (CLK'event and CLK = '1') then
 --           clk_interno <= NOT clk_interno;
 --       end if;
 --   end process;
	

	--CLK_DIV: process (clk_interno)
	--begin
	--	if(clk_interno'event and clk_interno='1') then
	--		if (count_clk = 5000000) then
	--			count_clk <= 0;
	--			CLK_1Hz <= not CLK_1Hz;
	--		else
	--			count_clk <= count_clk +1;
	--		end if;
	--	end if;
	--end process;

	--Inst_vga_ctrl_640x480_60Hz: vga_ctrl_640x480_60Hz PORT MAP(
	--	rst => RST,
	--	clk => clk_interno,
	--	rgb_in => rgb_aux,
	--	HS => HS,
	--	VS => VS,
	--	hcount => hcount,
	--	vcount => vcount,
	--	rgb_out => rgb_auxx,
	--	blank => open
	--);
--________________________________________________________________	



	lista1:  apellidos 
	port MAP(
		hcount	=> hcount,
		vcount	=> vcount,
		sel 	=> ori,
		value 	=> val1,
		posx	=> px1,
		posy	=> py1
	); 

	lista2:  documentos 
	port MAP(
		hcount	=> hcount,
		vcount	=> vcount,
		sel 	=> ori,
		value 	=> val2,
		posx	=> px2,
		posy	=> py2
	); 
	 
	
	lista3:  nombres			
	port MAP(
		hcount	=> hcount,
		vcount	=> vcount,
		sel 	=> ori,
		value 	=> val3,
		posx	=> px3,
		posy	=> py3
	); 
	 

	lista4:  grupo		
	port MAP(
		hcount	=> hcount,
		vcount	=> vcount,
		sel 	=> ori,
		value 	=> val4,
		posx	=> px4,
		posy	=> py4
	); 

	mostrar: display_34
	port map(
		value  => val,--J
		hcount => hcount,
		vcount => vcount,
		paint => paint0,
		POSX => px,
		POSY => py
	);


	 
	px <= 	px1 when sel= "00" else --APELLIDOS
			px2 when sel= "01" else --CEDULAS
	        px3 when sel= "10" else --NOMBRES
			px4 when sel= "11" else --GRUPO
			0; --modificar con degradado process
	py <= 	py1 when sel= "00" else --APELLIDOS
			py2 when sel= "01" else --CEDULAS
	        py3 when sel= "10" else --NOMBRES
			py4 when sel= "11" else --GRUPO
			0; --modificar con degradado process
	val <= 	val1 when sel= "00" else --APELLIDOS
			val2 when sel= "01" else --CEDULAS
	        val3 when sel= "10" else --NOMBRES
			val4 when sel= "11" else --GRUPO
			"100100"; --modificar con degradado process



--rgb_aux<="000000000000" when paint0 = '0' else
--         "111100000000";   
color: process(sel,paint0,hcount)
	constant apellidos: std_logic_vector(11 downto 0):="111100000000";
	constant cedulas: std_logic_vector(11 downto 0):="000011110000";
	constant nombres: std_logic_vector(11 downto 0):="000000001111";
	constant grupo: std_logic_vector(11 downto 0):="100010001000";
	variable letra: std_logic_vector(11 downto 0):="000000000000";
	variable fondo: std_logic_vector(11 downto 0):="000000000000";
	variable svy,svx,m,sd,sdd,sdu,adiag,vald: integer;
begin
	if(hcount=0) then
		cont<="0000";
		cont1<="0000";
	else
		if(cont = 0)then
			cont1<=cont1 + '1';
		end if;

		cont<=cont + '1';
	end if;


	if ori="1000" then --diagonal de izquierda a derecha
		vald:=conv_integer(vcount);
		svy:=480;
		svx:=640;
		adiag:=50;
		sd := -(vald*svx/svy)+svx;
        sdd:= sd - adiag;
        sdu:= sd + adiag;

        if (hcount>=sdd and hcount <= sdu) then
        	rgb_aux<=apellidos;
        else
        	rgb_aux<=not apellidos;
    	end if;

	else

		if paint0='1' then
			if sel= "00" then --APELLIDOS
				letra:=apellidos;
			elsif sel= "01" then --CEDULAS
				letra:=cedulas;
			elsif sel= "10" then --NOMBRES
				letra:=nombres;
			else --GRUPO
				letra:=grupo;
			end if;
			rgb_aux<=letra;
		else
			if sel= "00" then --APELLIDOS
				fondo:= not apellidos;
			elsif sel= "01" then --CEDULAS
				fondo:= not  cedulas;
			elsif sel= "10" then --NOMBRES
				fondo:= not nombres;
			else --GRUPO
				fondo:=not grupo;
			end if;

			rgb_aux<=fondo+cont1;
		end if;
	end if;
end process;


	
	--rgb_aux <= paint0 & paint0 & paint0 & paint0 & paint0 & paint0 & paint0 & paint0 & paint0 & paint0 & paint0 & paint0;



	--RGB <= rgb_auxx;  --para trabajo normal
	rgb <=rgb_aux;  --solo para simulacion

end Behavioral;