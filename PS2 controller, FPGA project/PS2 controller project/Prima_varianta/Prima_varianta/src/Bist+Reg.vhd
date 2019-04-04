library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all; 

entity bistSIreg is
	port(
	CLK_PS2 : in std_logic; 
	D : in bit;	 	-- D acesta reprezinta bit cu bit informatia venita de la tastatura
	COD_TASTA_ACTUAL : out bit_vector(7 downto 0);
	COD_TASTA_PREV : out bit_vector(7 downto 0);
	DATE_RECEPTIONATE: out std_logic;
	PARITATE_CORECTA: out bit);
end; 

architecture arch_bist of bistSIreg is		

signal Bistabil_trecere : std_logic_vector ( 1 downto 0);  
signal RECEPTIE_BITI_DATE: std_logic_vector(10 downto 0);
signal bit_paritate:bit;  
	 
begin
			 
	
	process(CLK_PS2, D)
	variable count : std_logic_vector(3 downto 0) := "0000";
	variable RECEPTIE_BITI : bit_vector(10 downto 0) := "11111111111";  
	variable temp_prev : bit_vector(7 downto 0) := "11111111";
	variable temp_actual : bit_vector(7 downto 0) := "11111111";	

	begin
		if (CLK_PS2'event and CLK_PS2 = '0') then
			count := count + "0001";
			RECEPTIE_BITI := RECEPTIE_BITI sll 1;
			RECEPTIE_BITI(0) := D;
         DATE_RECEPTIONATE <= '0';			
			if (count = "1011") then                             
			temp_prev := temp_actual;		 	-- temp_prev este F0, adica break code
			temp_actual(0) :=RECEPTIE_BITI(9); 
			temp_actual(1) :=RECEPTIE_BITI(8);
			temp_actual(2) :=RECEPTIE_BITI(7);
			temp_actual(3) :=RECEPTIE_BITI(6);					
			temp_actual(4) :=RECEPTIE_BITI(5);
			temp_actual(5) :=RECEPTIE_BITI(4);
			temp_actual(6) :=RECEPTIE_BITI(3);
			temp_actual(7) :=RECEPTIE_BITI(2);	
			PARITATE_CORECTA <= RECEPTIE_BITI(9) xor RECEPTIE_BITI(8) xor RECEPTIE_BITI(7) xor RECEPTIE_BITI(6) xor RECEPTIE_BITI(5) xor RECEPTIE_BITI(4) xor RECEPTIE_BITI(3) xor RECEPTIE_BITI(2) xor RECEPTIE_BITI(1);	
			DATE_RECEPTIONATE <= '1';				
			RECEPTIE_BITI := "11111111111";
			count:="0000";
			end if;
				
		end if;		
		
		COD_TASTA_PREV <= temp_prev; -- F0
		COD_TASTA_ACTUAL <= temp_actual;   --Make - code
		
	end process; 
	
	


end arch_bist;
		