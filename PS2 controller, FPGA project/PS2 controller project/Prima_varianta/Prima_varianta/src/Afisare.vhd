 library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Afisare is
	port( Clock_placuta: in std_logic;
	STARE: in std_logic;   
	PARITATE :in bit;
			IESIRE_BITI0: in bit_vector(7 downto 0);	-- apelam cu make code		
			IESIRE_BITI1: in bit_vector(7 downto 0);	 -- apelam cu break code
			IESIRE_TOTALA: out std_logic_vector(7 downto 0);
			anod_iesire: out std_logic_vector(3 downto 0);
			CLK_ps2: in std_logic);
end entity;

architecture ARH_SEG of Afisare is 	 

signal bcd1, bcd2, bcd3, bcd4 : std_logic_vector(7 downto 0);

component Divizor_SEG
port(Clock: in std_logic;
     Clock_Divizat: out std_logic_vector(1 downto 0));
end component;

signal Clock_Divizat : std_logic_vector (1 downto 0);

begin
div_frecventa : Divizor_SEG port map (Clock_placuta, Clock_Divizat); 

alt_proc: process(CLK_ps2)
variable cod1 : std_logic_vector (7 downto 0) := "11111111";
variable cod2 : std_logic_vector (7 downto 0) := "11111111";
variable cod3 : std_logic_vector (7 downto 0) := "11111111"; 
variable cod_trebuinta : std_logic_vector (7 downto 0) := "11111111";
begin	
if (stare='1' and paritate='1' and IESIRE_BITI1="11110000" and CLK_PS2'event and CLK_PS2='1' ) then 	-- ultimele 2 verificari sunt pentru ca, dupa ce se genereaza F01C de exemplu, clock-ul tastaturii ramane la 1 mereu pana urmeaza o alta tasta
		cod3 := cod2;
		cod2 := cod1;
 		cod1 := cod_trebuinta;	-- cod_trebuinta inca e VECHEA VALOAREA, dupa case o sa primeasca noua tasta apasata
	 case IESIRE_BITI0 is
				when "01000101" => cod_trebuinta := "10000001"; -- 0
				when "00010110" => cod_trebuinta := "11001111"; -- 1
				when "00011110" => cod_trebuinta := "10010010"; -- 2
				when "00100110" => cod_trebuinta := "10000110"; -- 3
				when "00100101" => cod_trebuinta := "11001100"; -- 4				 
				when "00101110" => cod_trebuinta := "10100100"; -- 5
            when "00110110" => cod_trebuinta := "10100000"; -- 6
				when "00111101" => cod_trebuinta := "10001111"; -- 7
				when "00111110" => cod_trebuinta := "10000000"; -- 8
				when "01000110" => cod_trebuinta := "10000100"; -- 9
				when "00100100" => cod_trebuinta := "10110000"; -- E
				when "00101011" => cod_trebuinta := "10111000"; -- F
				when "00111100" => cod_trebuinta := "11000001"; -- U
				when "01000011" => cod_trebuinta := "11001111"; -- I
				when "01000100" => cod_trebuinta := "10000001"; -- O
				when "01001101" => cod_trebuinta := "10011000"; -- P
				when "00110011" => cod_trebuinta := "11001000"; -- H
				when "01001011" => cod_trebuinta := "11110001"; -- L
				when "00011100" => cod_trebuinta := "10001000"; -- A
				when "00110101" => cod_trebuinta := "11000100"; -- Y
				when "00110010" => cod_trebuinta := "11100000"; -- b 
		      when "00100001" => cod_trebuinta := "10110001"; -- C
		      when "00100011" => cod_trebuinta := "11000010"; -- d
				when "00110001" => cod_trebuinta := "11101010"; -- n
				when "00011011" => cod_trebuinta := "10100100"; -- S
				when "00110100" => cod_trebuinta := "10000100"; -- G
				when "00111011" => cod_trebuinta := "11000011"; -- J
				when "01001001" => cod_trebuinta := "01111111"; --.
				when "01011010" => cod_trebuinta := "11111111"; -- ENTER KEY 
				                   cod3 := "11111111";
		                         cod2 := "11111111";
 		                         cod1 := "11111111";
				when others => cod_trebuinta := "10110000"; --doar acestea le putem afisa => restul le punem la 00000000
	end case;
	end if;
bcd4 <= cod3;
bcd3 <= cod2;
bcd2 <= cod1;
bcd1 <= cod_trebuinta;
end process;


PROCES: process(Clock_Divizat, bcd4, bcd3, bcd2, bcd1)

begin	   


	
	case Clock_Divizat is
		when "00" => anod_iesire(0)<='0' ; anod_iesire(1)<='1' ; anod_iesire(2)<='1'; anod_iesire(3)<='1';	IESIRE_TOTALA <= bcd4;
		when "01" => anod_iesire(0)<='1' ; anod_iesire(1)<='0' ; anod_iesire(2)<='1'; anod_iesire(3)<='1';	IESIRE_TOTALA <= bcd3;
		when "10" => anod_iesire(0)<='1' ; anod_iesire(1)<='1' ; anod_iesire(2)<='0'; anod_iesire(3)<='1';	IESIRE_TOTALA <= bcd2;
		when "11" => anod_iesire(0)<='1' ; anod_iesire(1)<='1' ; anod_iesire(2)<='1'; anod_iesire(3)<='0'; IESIRE_TOTALA <= bcd1;
		when others => anod_iesire(0)<='1' ; anod_iesire(1)<='1' ; anod_iesire(2)<='1'; anod_iesire(3)<='1';	-- Nu conteaza ..
	end case;

	  
	 end process;


end ARH_SEG;
