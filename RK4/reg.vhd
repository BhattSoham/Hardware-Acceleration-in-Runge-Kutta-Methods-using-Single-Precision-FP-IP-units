----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/08/2023 05:36:37 PM
-- Design Name: 
-- Module Name: reg - Behavioral
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
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg is
Port (
        clk: in std_logic;
        rs1 : in std_logic_vector(4 downto 0);
        regwr : in std_logic;
        wrdata: out std_logic_vector(31 downto 0)
--        x_out : out std_logic_vector(31 downto 0);
--        y_out: out std_logic_vector(31 downto 0)
        );
 end reg;
 
            
 
 
-- reg_x_in: inout STD_LOGIC_VECTOR(31 downto 0);
--           reg_y_in : inout STD_LOGIC_VECTOR(31 downto 0);
--           reg_h : inout STD_LOGIC_VECTOR(31 downto 0);
--           reg_p_in : inout STD_LOGIC_VECTOR(31 downto 0);
--           reg_p1_in : inout STD_LOGIC_VECTOR(31 downto 0);
--           reg_c_in : inout STD_LOGIC_VECTOR(31 downto 0);
--           reg_x_out: out STD_LOGIC_VECTOR(31 downto 0);
--           reg_y_out: out STD_LOGIC_VECTOR(31 downto 0)

-- );
--end reg;

architecture Behavioral of reg is

type regfile is array(15 downto 0) of std_logic_vector(31 downto 0);
signal r : regfile;
signal wridata: std_logic_vector(31 downto 0);

begin

writedata: process(clk, rs1, regwr, wridata)
begin
 if rising_edge(clk) then 
  if  regwr = '1' then 
     r(TO_INTEGER(unsigned(rs1))) <= wridata;
     end if;
   end if;      
   
    case rs1  is
      when "00001" =>
      wridata <= x"40000000";
       wrdata <= wridata;
       
      when "00010" =>
       wridata <= x"3F800000";
       wrdata <=  wridata; 
       
      when "00011" => 
      wridata <= x"3DCCCCCD";
       wrdata <=  wridata;
       
      when "00100" => 
      wridata <=  x"3D4CCCCD";
       wrdata <=  wridata;
       
      when "00101" =>
      wridata <= x"40000000";
       wrdata <= wridata;
       
      when "00110" =>
       wridata <= x"3C887A8D";
       wrdata <= wridata;
      
--      when "00111" =>
--        x_out <= r(7);
        
--      when "01000" =>
--        y_out <= r(8);  
       
      when others => null;
   
     end case;

 end process;

 
          



end Behavioral;
