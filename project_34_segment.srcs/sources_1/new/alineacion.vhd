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
       CLK : in  STD_LOGIC;
       RST : in  STD_LOGIC;
       but:  in std_logic;
       HS :  out  STD_LOGIC;
       VS : out  STD_LOGIC;
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
		dh:   in integer := 100;
		posx: in integer := 0;
		posy: in integer := 0
         	); 
    PORT
    ( 
	   value:  in std_logic_vector(5 downto 0);
       hcount: in std_logic_vector(10 downto 0);
       vcount: in std_logic_vector(10 downto 0);
       paint:  out std_logic
    );
	end COMPONENT;
	
	component apellidos
	Port (
		sel: in STD_LOGIC_VECTOR(3 downto 0);
		hcount: in std_logic_vector(10 downto 0);
		vcount: in std_logic_vector(10 downto 0);
		paint: 	out std_logic
	);
	end component;
	
	component nombres
	Port (
		sel: in STD_LOGIC_VECTOR(3 downto 0);
		hcount: in std_logic_vector(10 downto 0);
		vcount: in std_logic_vector(10 downto 0);
		paint: 	out std_logic
	);
	end component;

	component grupo
	Port (
		sel: in STD_LOGIC_VECTOR(3 downto 0);
		hcount: in std_logic_vector(10 downto 0);
		vcount: in std_logic_vector(10 downto 0);
		paint: 	out std_logic
	);
	end component;

	component documentos
	Port (
		sel: in STD_LOGIC_VECTOR(3 downto 0);
		hcount: in std_logic_vector(10 downto 0);
		vcount: in std_logic_vector(10 downto 0);
		paint: 	out std_logic
	);
	end component;
	
	-- Declaramos seales
	signal hcount : STD_LOGIC_VECTOR (10 downto 0);
	signal vcount : STD_LOGIC_VECTOR (10 downto 0);
    signal paint0,paint1,paint2,paint3 : STD_LOGIC;
    signal rgb_x: std_logic;
    signal rgb_aux : STD_LOGIC_VECTOR (11 downto 0);
    signal rgb_auxx : STD_LOGIC_VECTOR (11 downto 0);
	signal rgb_aux1 : STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal rgb_aux2 : STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal rgb_aux3 : STD_LOGIC_VECTOR (3 downto 0):="0000";
	signal CLK_1Hz : STD_LOGIC:='0';
	signal count_clk : INTEGER:=0;
	signal count_color: integer:=0;
	signal clk_interno : STD_LOGIC;
	signal count_1hz: INTEGER := 0;


begin

 	CLK_50MHZ: process (CLK)
    begin  
        if (CLK'event and CLK = '1') then
            clk_interno <= NOT clk_interno;
        end if;
    end process;
	

	CLK_DIV: process (clk_interno)
	begin
		if(clk_interno'event and clk_interno='1') then
			if (count_clk = 5000000) then
				count_clk <= 0;
				CLK_1Hz <= not CLK_1Hz;
			else
				count_clk <= count_clk +1;
			end if;
		end if;
	end process;
	
	lista1:  apellidos port MAP(
			sel=> 	 ori,
			hcount=> hcount,
			vcount=> vcount,
			paint=> paint0
		); 

	lista2:  documentos port MAP(
		sel=> 	 ori,
		hcount=> hcount,
		vcount=> vcount,
		paint=> paint1
	); 
	
	lista3:  nombres port MAP(
		sel=> 	 ori,
		hcount=> hcount,
		vcount=> vcount,
		paint=> paint2
	); 

	lista4:  grupo port MAP(
		sel=> 	 ori,
		hcount=> hcount,
		vcount=> vcount,
		paint=> paint3
	); 
	rgb_x <= 		paint0 when sel= "00" else --APELLIDOS
					paint1 when sel= "01" else --CEDULAS
	           		paint2 when sel= "10" else --NOMBRES
					paint3 when sel= "11" else --GRUPO
				  	'0'; --modificar con degradado process



	degradador: process(rgb_aux1,rgb_aux3,paint1,paint2,paint3)			  	
	begin
		if (paint0='1') then
			if(rgb_aux1<"1111") then
				rgb_aux1 <= rgb_aux1+'1';
			else
				rgb_aux1 <= "0000";
			end if;
		elsif paint1='1' then
			if(rgb_aux1<"1111") then
				rgb_aux1 <= rgb_aux1+'1';
			else
				rgb_aux1 <= "0000";
			end if;
					
		elsif (paint2='1') then
			if(rgb_aux2<"1111") then
				rgb_aux2 <= rgb_aux2+'1';
			else
				rgb_aux2 <= "0000";
			end if;
		elsif (paint3='1') then
			if(rgb_aux3<"1111") then
				rgb_aux3 <= rgb_aux3+'1';
			else
				rgb_aux3 <= "0000";
			end if;
		end if;
			
			
	end process;
	rgb_aux <= rgb_aux1(3)&rgb_aux1(2)&rgb_aux1(1)&rgb_aux1(0)&rgb_aux2(3)&rgb_aux2(2)&rgb_aux2(1)&rgb_aux2(0)&rgb_aux3(3)&rgb_aux3(2)&rgb_aux3(1)&rgb_aux3(0);

	Inst_vga_ctrl_640x480_60Hz: vga_ctrl_640x480_60Hz PORT MAP(
		rst => RST,
		clk => clk_interno,
		rgb_in => rgb_aux,
		HS => HS,
		VS => VS,
		hcount => hcount,
		vcount => vcount,
		rgb_out => rgb_auxx,
		blank => open
	);

	RGB <= rgb_auxx;

end Behavioral;