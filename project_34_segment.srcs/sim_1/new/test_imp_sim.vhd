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
       hcount: in  STD_LOGIC_VECTOR (10 downto 0);  --para simular
       vcount: in  STD_LOGIC_VECTOR (10 downto 0);	--para simular
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
	--signal reset: std_logic:='1';
	signal hcount,vcount : STD_LOGIC_VECTOR (10 downto 0) := (others=>'0');

	
begin



test: test_imp port map(
    clk=>clk_100,
    hcount=>hcount,
    vcount=>vcount,
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

		
		hcount<= hcount+'1';
		if hcount=640 then
			hcount<= "00000000000";
			vcount<=vcount+'1';
			if(vcount>480) then
				vcount<= "00000000000";
			end if;
			
		end if;
	end if;
end process;





process(hcount)
	variable texto1: line;
    variable color1,color2,color3: integer;
    variable temp: std_logic_vector (11 downto 0);
    file solucion: text;
    variable c: std_logic:='0';
begin
	file_open(solucion, "resultados.m",  append_mode);
	temp:= rgb_out;
	color1:= conv_integer(temp);
	--temp:= rgb_out(7) & rgb_out(6) & rgb_out(5) & rgb_out(4);
	--color2:= conv_integer(temp);
	--temp:= rgb_out(11) & rgb_out(10) & rgb_out(9) & rgb_out(8);
	--color3:= conv_integer(temp);
	
	if(vcount=0 and hcount=0 and c='0') then
		write(texto1,string'("clear all;"));
		writeline(solucion,texto1);
		write(texto1,string'("close all;"));
		writeline(solucion,texto1);
		write(texto1,string'("clc;"));
		writeline(solucion,texto1);
		write(texto1,string'("a=["));
		c:= not c;
		--write(texto1,string'(""));
	end if;





	write (texto1, color1);

	if(hcount<640)then
		write (texto1, string'(","));
	else
		if (vcount<=480) then
			write (texto1, string'(";"));
			write(texto1, string'("   %("));
			write(texto1, conv_integer(hcount));
			write(texto1, string'(","));
			write(texto1, conv_integer(vcount));
			write(texto1, string'(")"));
			writeline (solucion, texto1);

			if (vcount=480) then
				write (texto1, string'("];"));
				writeline (solucion, texto1);
				write(texto1,string'("imshow(a);"));
				writeline (solucion, texto1);
				write(texto1,string'("impixelinfo();"));
				writeline (solucion, texto1);
				file_close(solucion);
			end if;
			
			
			
		end if;
	end if;

	
	--write (texto1, color2);
	--write (texto1, string'(","));
	--write (texto1, color3);
	--write (texto1, string'(") "));

	
	
end process;



end Behavioral;
