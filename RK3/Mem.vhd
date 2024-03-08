
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 07:31:54 PM
-- Design Name: 
-- Module Name: Mem - Behavioral
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
use IEEE. numeric_std. ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mem is
Port (    
           cont: in std_logic_vector(31 downto 0);
           addr : in std_logic_vector(11 downto 0);
           x_in: out STD_LOGIC_VECTOR(31 downto 0);
           y_in : out STD_LOGIC_VECTOR(31 downto 0);
           h : out STD_LOGIC_VECTOR(31 downto 0);
           p_in: out STD_LOGIC_VECTOR(31 downto 0);
           p1_in : out STD_LOGIC_VECTOR(31 downto 0);
           c_in: out STD_LOGIC_VECTOR(31 downto 0);
           r_in : out STD_LOGIC_VECTOR(31 downto 0);
           write_en: in std_logic;
           clock: in std_logic;
           flush : in std_logic;
           x_out: in STD_LOGIC_VECTOR(31 downto 0);
           y_out : in STD_LOGIC_VECTOR(31 downto 0);
           init: in std_logic  );
                               --cma_out: out STD_LOGIC_VECTOR(11 downto 0);
          
end Mem;

architecture Behavioral of Mem is
type mem_type is array (0 to 63 ) of std_logic_vector (31 downto 0);

 signal mem: mem_type;
--signal cma_in:  STD_LOGIC_VECTOR(11 downto 0) := "000000001100" ;
--signal cma_output:  STD_LOGIC_VECTOR(11 downto 0);

--signal   x_output:  STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
--signal  y_output :  STD_LOGIC_VECTOR(31 downto 0) := x"00000000";


begin
process(clock)
begin
if rising_edge(clock) then 
if ((write_en = '1') and (flush = '0')) then
     mem(TO_INTEGER(unsigned(addr))) <= cont;
  end if; 
end if;

if rising_edge(clock) then 
 if flush = '1' and write_en = '0' and init = '0'  then --- FLUSH MODE
  
  x_in <= mem(0);
  y_in <= mem(4) ;
  h <= mem(8);
  p_in <= mem(12);
  p1_in <= mem(16);
  c_in <= mem(20);
  r_in <= mem(24);
  
  end if;   
end if;

if rising_edge(clock)  then 
     

   if flush = '0' and write_en = '1' and init = '1'  then  ---UPDATE MODE

  
  mem(0) <= x_out;
  mem(4) <= y_out;
  
  
--   if (to_integer(unsigned(cma_in)) >= 12) then
  
  --if (to_integer(unsigned(cma_in)) >= 12) then
--    mem(to_integer(unsigned(cma_in))) <= x_out;
--  mem(to_integer(unsigned(cma_in)) + 4) <=  y_out;

   

end if;


 end if; 
--end if;   


  end process;


    
end Behavioral;
