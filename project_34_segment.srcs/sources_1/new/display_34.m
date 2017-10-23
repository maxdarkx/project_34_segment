function display_34 (lw,dw,dl,posx,posy)
	if nargin=1 
	(
		lw:   in integer := 10;
		dw:   in integer := 50;
		dl:   in integer := 100;
		posx: in integer := 0;
		posy: in integer := 0;
	)
	

	%Ancho de linea lw
	%Ancho del segmento dw (x)
	%Largo del segmento dl (y)

	%segmentos horizontales
	shx1 = posx;
	shx2 = posx + dw/2;
	
	shx3 = posx + dw/2;
	shx4 = posx + dw;

	shy1 = posy;
	shy2 = posy + lw;

	shy3 = posy + dl/2 - lw/2;
	shy4 = posy + dl/2 + lw/2;

	shy5 = posy + dl - lw;
	shy6 = posy + dl;


	%Segmentos Verticales
	svx1 = posx;
	svx2 = posx + lw;

	svx3 = posx + dw/2 - lw/2;
	svx4 = posx + dw/2 + lw/2;

	svx5 = posx + dw - lw;
	svx6 = posx + dw;
	
	svy1 = posy + lw;
	svy2 = posy + dl/4;

	svy3 = posy + dl/4;
	svy4 = posy + 2*dl/4;

	svy5 = posy + 2*dl/4;
	svy6 = posy + 3*dl/4;

	svy7 = posy + 3*dl/4;
	svy8 = posy + dl;

	%segmentos diagonales
	sd1 ;
	sd1u ;
	sd1d ;
    
    sd2 ;
    sd2u ;
    sd2d ;


	segments;

 sd1  = ( (posx - ( '0'&vcount(10 downto 1)))); %segmento 5
 sd1d =  sd1 - lw/2;
 sd1u =  sd1 + lw/2;
 
 sd2 = ( ('0'&vcount(10 downto 1)) + posx); %segmento 4
 sd2d = sd2 - lw/2;
 sd2u = sd2 + lw/2;

	%SEGMENTOS HORIZONTALES
	%  segmento 1
		if(segments(0)=='1' and (hcount>=shx1)and(hcount=shx2)and(vcount>=shy1)and(vcount=shy2)) 
			paint = '1';
	% segmento 2
		elseif (segments(1)=='1' and (hcount>=shx3)and(hcount=shx4)and(vcount>=shy1)and(vcount=shy2)) 
			paint = '1';
	% segmento 17
		elseif (segments(16)=='1' and (hcount>=shx1)and(hcount=shx2)and(vcount>=shy3)and(vcount=shy4)) 
			paint = '1';
	% segmento 18
		elseif (segments(17)=='1' and (hcount>=shx3)and(hcount=shx4)and(vcount>=shy3)and(vcount=shy4)) 
			paint = '1';
	% segmento 33
		elseif (segments(32)=='1' and (hcount>=shx1)and(hcount=shx2)and(vcount>=shy5)and(vcount=shy6)) 
			paint = '1';
	% segmento 34
		elseif (segments(33)=='1' and (hcount>=shx3)and(hcount=shx4)and(vcount>=shy5)and(vcount=shy6)) 
			paint = '1';

	%SEGMENTOS VERTICALES IZQUIERDOS

	% segmento 3
		elseif (segments(2)=='1' and (hcount>=svx1)and(hcount=svx2)and(vcount>=svy1)and(vcount=svy2)) 
			paint = '1';
	% segmento 10
		elseif (segments(9)=='1' and (hcount>=svx1)and(hcount=svx2)and(vcount>=svy3)and(vcount=svy4)) 
			paint = '1';
	% segmento 19
		elseif (segments(18)=='1' and (hcount>=svx1)and(hcount=svx2)and(vcount>=svy5)and(vcount=svy6)) 
			paint = '1';		
	% segmento 26
		elseif (segments(25)=='1' and (hcount>=svx1)and(hcount=svx2)and(vcount>=svy7)and(vcount=svy8)) 
			paint = '1';

	%SEGMENTOS VERTICALES DERECHOS

	% segmento 9
		elseif (segments(8)=='1' and (hcount>=svx5)and(hcount=svx6)and(vcount>=svy1)and(vcount=svy2)) 
			paint = '1';
	% segmento 16
		elseif (segments(15)=='1' and (hcount>=svx5)and(hcount=svx6)and(vcount>=svy3)and(vcount=svy4)) 
			paint = '1';
	% segmento 25
		elseif (segments(24)=='1' and (hcount>=svx5)and(hcount=svx6)and(vcount>=svy5)and(vcount=svy6)) 
			paint = '1';		
	% segmento 32
		elseif (segments(31)=='1' and (hcount>=svx5)and(hcount=svx6)and(vcount>=svy7)and(vcount=svy8)) 
			paint = '1';

	%SEGMENTOS VERTICALES CENTRALES

	% segmento 6
		elseif (segments(5)=='1' and (hcount>=svx3)and(hcount=svx4)and(vcount>=svy1)and(vcount=svy2)) 
			paint = '1';
	% segmento 13
		elseif (segments(12)=='1' and (hcount>=svx3)and(hcount=svx4)and(vcount>=svy3)and(vcount=svy4)) 
			paint = '1';
	% segmento 22
		elseif (segments(21)=='1' and (hcount>=svx3)and(hcount=svx4)and(vcount>=svy5)and(vcount=svy6)) 
			paint = '1';		
	% segmento 29
		elseif (segments(28)=='1' and (hcount>=svx3)and(hcount=svx4)and(vcount>=svy7)and(vcount=svy8)) 
			paint = '1';


	%SEGMENTOS DIAGONALES
	   %diagonal 5
		elseif ( segments(4)=='1' and hcount >= shx1 and hcount = shx2 and vcount = svy1 and vcount >= svy2 and hcount >= sd1d and  hcount = sd1u ) 
			paint = '1';
    %diagonal 4
        elseif ( segments(3)=='1' and hcount >= shx1 and hcount = shx2 and vcount = svy1 and vcount >= svy2 and hcount >= sd2d and  hcount = sd2u ) 
            paint = '1';


		else
			paint = '0';
		end
end