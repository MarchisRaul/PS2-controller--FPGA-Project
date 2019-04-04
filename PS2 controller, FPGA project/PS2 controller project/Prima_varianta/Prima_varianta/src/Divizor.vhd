library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Divizor_SEG is
port(Clock: in std_logic;
     Clock_Divizat: out std_logic_vector(1 downto 0));
end Divizor_SEG;

architecture Arch_Div_SEG of Divizor_SEG is
signal Num: std_logic_vector(16 downto 0);
begin
   process(Clock)
   begin
      if Clock ='1' and Clock'event then
		Num<=Num+1;
      end if;
   end process;
Clock_Divizat<=Num(16 downto 15);
End Arch_Div_SEG;
