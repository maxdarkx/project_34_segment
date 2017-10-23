----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2017 16:22:42
-- Design Name: 
-- Module Name: test_imp_sim - Behavioral
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
use std.textio.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_imp_sim is
--Port ( );
end test_imp_sim;

architecture Behavioral of test_imp_sim is
component test_imp
Port ( 
       CLK : in  STD_LOGIC;
       --RST : in  STD_LOGIC;
      -- HS :  out  STD_LOGIC;
       --VS : out  STD_LOGIC;
       sel: in std_logic_vector(1 downto 0); -- selector entre grupo, cedulas, nombres y apellidos
       ori: in std_logic_vector(3 downto 0); --selector de la orientacion
       RGB : out  STD_LOGIC_VECTOR (11 downto 0)
    );

end component;
	
	SIGNAL CLK_100:STD_LOGIC:='0';
	SIGNAL sele : STD_LOGIC_VECTOR(1 downto 0):="00";
	SIGNAL origin : STD_LOGIC_VECTOR(3 downto 0):="0000";
	SIGNAL rgb_out: std_logic_vector(11 downto 0):= (others=>'0');
	--signal hs,vs: std_logic:='0';
	signal reset: std_logic:='1';
	signal hcount,vcount :integer := 0;
begin

test: test_imp port map(
    clk=>CLK_100,
    --rst=>reset,
    --hs=>hs,
    --vs=>vs,
    sel=>sele,
    ori=>origin,
    rgb=>rgb_out
);

clk_process: process
begin
    wait for 0.5ns;
    clk_100<=not(clk_100);
    
end process;

hvsync: process(clk_100)
begin
	if(clk_100'event and clk_100='1') then
		hcount<= hcount+1;
		if hcount=640 then
			hcount<=0;
			vcount<=vcount+1;
		end if;

		if (vcount=481) then
			vcount<=0;
		end if;
	end if;
end process;





process(hcount, vcount)
    file solucion: text;
    variable texto: line;
    variable color1,color2,color3: integer;
    variable temp: std_logic_vector (3 downto 0);
begin
	file_open(solucion, "resultados.mout",  write_mode);
	
	temp:= rgb_out(3) & rgb_out(2) & rgb_out(1) & rgb_out(0);
	color1:= conv_integer(temp);
	temp:= rgb_out(7) & rgb_out(6) & rgb_out(5) & rgb_out(4);
	color2:= conv_integer(temp);
	
	temp:= rgb_out(11) & rgb_out(10) & rgb_out(9) & rgb_out(8);
	color3:= conv_integer(temp);
	
	write (texto, color1);
	write (texto, color2);
	write (texto, color3);
	writeline (solucion, texto);
	file_close(solucion);
end process;



end Behavioral;
