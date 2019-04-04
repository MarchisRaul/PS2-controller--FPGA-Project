---------------------------------------------------------------------------------------------------
--
-- Title       : 
-- Design      : Prima_varianta
-- Author      : Windows User
-- Company     : D
--
---------------------------------------------------------------------------------------------------
--
-- File        : d:\facultate\Programe\Prima_varianta\Prima_varianta\compile\legare_totala.vhd
-- Generated   : Fri May 18 16:25:04 2018
-- From        : d:\facultate\Programe\Prima_varianta\Prima_varianta\src\legare_totala.bde
-- By          : Bde2Vhdl ver. 2.6
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity legare_totala is
  port(
       CLK_placuta : in std_logic;
       CLK_tastatura : in std_logic;
       biti_tastatura : in bit;
       anod_iesire : out std_logic_vector(3 downto 0);
       catod_iesire : out std_logic_vector(7 downto 0);
       test : out std_logic_vector(7 downto 0)
  );
end legare_totala;

architecture arch_unity of legare_totala is

use ieee.std_logic_arith.all;

use ieee.std_logic_arith.all;

---- Component declarations -----

component Afisare
  port (
       CLK_ps2 : in STD_LOGIC;
       Clock_placuta : in STD_LOGIC;
       IESIRE_BITI0 : in STD_LOGIC_VECTOR(7 downto 0);
       IESIRE_BITI1 : in STD_LOGIC_VECTOR(7 downto 0);
       PARITATE : in STD_LOGIC;
       STARE : in STD_LOGIC;
       IESIRE_TOTALA : out STD_LOGIC_VECTOR(7 downto 0);
       anod_iesire : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;
component bistSIreg
  port (
       CLK_PS2 : in STD_LOGIC;
       D : in BIT;
       COD_TASTA_ACTUAL : out BIT_VECTOR(7 downto 0);
       COD_TASTA_PREV : out BIT_VECTOR(7 downto 0);
       DATE_RECEPTIONATE : out STD_LOGIC;
       PARITATE_CORECTA : out BIT
  );
end component;

---- Signal declarations used on the diagram ----

signal paritate : std_logic;
signal receptie_date : std_logic;
signal temp_break : bit_vector (7 downto 0) := "11111111";
signal temp_make : bit_vector (7 downto 0) := "11111111";

begin

----  Component instantiations  ----

afisare_placuta : Afisare
  port map(
       CLK_ps2 => CLK_tastatura,
       Clock_placuta => CLK_placuta,
       IESIRE_BITI0 => to_stdlogicvector(temp_make( 7 downto 0 )),
       IESIRE_BITI1 => to_stdlogicvector(temp_break( 7 downto 0 )),
       IESIRE_TOTALA => catod_iesire,
       PARITATE => paritate,
       STARE => receptie_date,
       anod_iesire => anod_iesire
  );

preluare_cod : bistSIreg
  port map(
       CLK_PS2 => CLK_tastatura,
       COD_TASTA_ACTUAL => temp_make,
       COD_TASTA_PREV => temp_break,
       D => biti_tastatura,
       DATE_RECEPTIONATE => receptie_date,
       to_stdulogic(PARITATE_CORECTA) => paritate
  );


end arch_unity;
