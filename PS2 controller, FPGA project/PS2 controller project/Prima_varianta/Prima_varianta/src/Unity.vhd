library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity legare_totala is
	port(biti_tastatura : in bit;	
	CLK_tastatura : in std_logic;
	CLK_placuta : in std_logic;
	catod_iesire : out std_logic_vector(7 downto 0);
	anod_iesire : out std_logic_vector(3 downto 0);
	test : out std_logic_vector(7 downto 0));
end;
	
architecture arch_unity of legare_totala is	

signal temp_break, temp_make : bit_vector (7 downto 0) := "11111111";
signal paritate : bit;					
signal receptie_date : std_logic;

component bistSIreg 
	port(
	CLK_PS2 : in std_logic; 
	D : in bit;	 	-- D acesta reprezinta bit cu bit informatia venita de la tastatura
	COD_TASTA_ACTUAL : out bit_vector(7 downto 0);
	COD_TASTA_PREV : out bit_vector(7 downto 0);
	DATE_RECEPTIONATE: out std_logic;
	PARITATE_CORECTA: out bit);
end component;

component Afisare
	port( Clock_placuta: in std_logic;
	        STARE: in std_logic; 
        	PARITATE : in bit;
			IESIRE_BITI0: in bit_vector(7 downto 0);	-- apelam cu make code		
			IESIRE_BITI1: in bit_vector(7 downto 0);	 -- apelam cu break code
			IESIRE_TOTALA: out std_logic_vector(7 downto 0);
			anod_iesire: out std_logic_vector(3 downto 0);
			CLK_ps2: in std_logic);
end component;


begin				
	preluare_cod : bistSIreg port map (CLK_tastatura, biti_tastatura, temp_make, temp_break, receptie_date, paritate); 
	afisare_placuta : Afisare port map (CLK_placuta, receptie_date, paritate, temp_make, temp_break, catod_iesire, anod_iesire, CLK_tastatura); 
	
	
end;