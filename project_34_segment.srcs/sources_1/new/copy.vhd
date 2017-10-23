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
           RGB : out  STD_LOGIC_VECTOR (11 downto 0));

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
    PORT ( 
    	   value:  in std_logic_vector(5 downto 0);
           hcount: in std_logic_vector(10 downto 0);
           vcount: in std_logic_vector(10 downto 0);
           paint:  out std_logic
           );
	end COMPONENT;
	
	
	-- Declaramos seales
	signal hcount : STD_LOGIC_VECTOR (10 downto 0);
	signal vcount : STD_LOGIC_VECTOR (10 downto 0);
    signal paint2 : STD_LOGIC;
    signal paint1 : STD_LOGIC;
    signal paint0 : STD_LOGIC;
	signal rgb_aux1 : STD_LOGIC_VECTOR (2 downto 0);
	signal rgb_aux2 : STD_LOGIC_VECTOR (11 downto 0);
	signal rgb_aux3 : STD_LOGIC_VECTOR (11 downto 0);
	signal conteo : std_logic_vector(9 downto 0);
	signal CLK_1Hz : STD_LOGIC:='0';
	signal count_clk : INTEGER:=0;
	signal clk_interno : STD_LOGIC;
	signal val: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101100";
	signal val1: STD_LOGIC_VECTOR(5 DOWNTO 0) := "101011";
	signal count_1hz: INTEGER := 0;

begin

   start:process(vcount)
   begin
   	if(vcount>0 and vcount<10 and hcount>0 and hcount<0) then
   		paint2<='1';
   	else
   		paint2<='0';
   	end if;

   end process;


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
	
	clk_button: process(clk_1hz)
	begin
	   if(clk_1hz'event and clk_1hz='1') then
           if(but='1' or RST='1') then
               if(val=0 or RST='1') then
                   val<="101100";
                   val1<="101011";
               else
                   val<=val-1;
                   val1<=val1-1;
               end if;
           end if;
       end if;
	end process;
	
	Display1: Display_34  
	GENERIC MAP (
		LW => 10,
		DL => 100,
		DH => 200,
		POSX => 50,
		POSY => 50)
	PORT MAP(
        value => val,
        hcount => hcount,
        vcount => vcount,
        paint => paint0
	);
	Display2: Display_34  
        GENERIC MAP (
            LW => 10,
            Dl => 100,
            Dh => 200,
            POSX => 200,
            POSY => 50)
        PORT MAP(
            value => val1,
            hcount => hcount,
            vcount => vcount,
            paint => paint1
        );
	
	
	rgb_aux1 <= 	"001" when paint2='1' else
	           		"100" when paint0='1' else
					"010" when paint1='1' else
				  	"000";
	rgb_aux3 <= rgb_aux1(2)&rgb_aux1(2)&rgb_aux1(2)&rgb_aux1(2)&rgb_aux1(1)&rgb_aux1(1)&rgb_aux1(1)&rgb_aux1(1)&rgb_aux1(0)&rgb_aux1(0)&rgb_aux1(0)&rgb_aux1(0);

	Inst_vga_ctrl_640x480_60Hz: vga_ctrl_640x480_60Hz PORT MAP(
		rst => RST,
		clk => clk_interno,
		rgb_in => rgb_aux3,
		HS => HS,
		VS => VS,
		hcount => hcount,
		vcount => vcount,
		rgb_out => rgb_aux2,
		blank => open
	);

	RGB <= rgb_aux2;

end Behavioral;