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
       RST : in  STD_LOGIC;
       HS :  out  STD_LOGIC;
       VS : out  STD_LOGIC;
       sel: in std_logic_vector(1 downto 0); -- selector entre grupo, cedulas, nombres y apellidos
       ori: in std_logic_vector(3 downto 0); --selector de la orientacion
       RGB : out  STD_LOGIC_VECTOR (11 downto 0)
    );

end component;
	
	SIGNAL CLK_100:STD_LOGIC:='0';
	SIGNAL sele : STD_LOGIC_VECTOR(1 downto 0):="00";
	SIGNAL origin : STD_LOGIC_VECTOR(3 downto 0):="0000";
	SIGNAL rgb_out: std_logic_vector(11 downto 0):= (others=>'0');
	signal hs,vs: std_logic:='0';
	signal reset: std_logic:='1';
begin

test: test_imp port map(
    clk=>CLK_100,
    rst=>reset,
    hs=>hs,
    vs=>vs,
    sel=>sele,
    ori=>origin,
    rgb=>rgb_out
);


process(clk_100)
    file solucion: text;
    variable texto: line;
    variable color1,color2,color3: std_logic_vector(0 downto 4);
begin
	file_open(solucion, "resultados.mout",  write_mode);
	reset<='0';
	for i in 0 to 1 loop --sel
		origin<= "0000";
		for j in 0 to 3 loop --ori

			--color1:= rgb_out(3) & rgb_out(2) & rgb_out(1) & rgb_out(0);
--			color2:= rgb_out(7) & rgb_out(6) & rgb_out(5) & rgb_out(4);
--			color3:= rgb_out(11) & rgb_out(10) & rgb_out(9) & rgb_out(8);

			--write (texto, color1);
    		--writeline (solucion, texto);
            origin<=origin + 1;
		end loop;
		sele<= sele +1;
	end loop;
end process;

clk_process: process
begin
    wait for 0.5ns;
    clk_100<=not(clk_100);
    
end process;



end Behavioral;
