----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 08:33:41 PM
-- Design Name: 
-- Module Name: Control - Behavioral
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
use IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CU is
Port (

inst: in std_logic_vector(31 downto 0);
addr: out std_logic_vector(11 downto 0);
write_en: out std_logic;
flush: out std_logic;
init: out std_logic
 );
end CU;

architecture Behavioral of CU is

signal opcode: std_logic_Vector(6 downto 0) := "0001100";
signal rs1: std_logic_Vector(4 downto 0);
signal  rd: std_logic_Vector(4 downto 0) := "00000";
signal func3: std_logic_Vector(2 downto 0);
signal imm: std_logic_Vector(11 downto 0);
signal addr1: std_logic_Vector(11 downto 0); 
signal func: std_logic_Vector(2 downto 0);

begin

opcode <= inst(6 downto 0);
rd <= inst(11 downto 7);
func3 <= inst(14 downto 12);
rs1 <= inst(19 downto 15);
imm <= inst(31 downto 20);

process(func3, imm)
begin

 if (func3 = "000")  then    ---    EulerInit (func3 changed)
   write_en <= '1';
   flush <= '0';
       if (imm = "000000000000" ) then 
     addr1 <= imm;
    else
         addr1 <= std_logic_vector(unsigned(addr1) + 4);
   end if;
  end if;

  if (func3 = "110") then   --- EulerUpdate Flush mode
   write_en <= '0';
   flush <= '1';
   init <= '0';
   
   end if;
   
  
 
   if (func3 = "100")  then --- EulerUpdate Store mode
   write_en <= '1';
   flush <= '0';
   init <= '1';
   addr1 <= imm;
      end if;


 end process;
    addr <= addr1;
 --flush <= mflush; 

end Behavioral;

