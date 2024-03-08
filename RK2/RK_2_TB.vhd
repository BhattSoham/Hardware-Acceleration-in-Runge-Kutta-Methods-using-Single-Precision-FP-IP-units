----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/27/2023 10:25:52 PM
-- Design Name: 
-- Module Name: RK_2_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RK_2_TB is
--  Port ( );
end RK_2_TB;

architecture Behavioral of RK_2_TB is
component RK_2 is
Port (
   x_in: in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           x_out: out STD_LOGIC_VECTOR(31 downto 0);
           y_out: out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;
 
signal x_in:  STD_LOGIC_VECTOR(31 downto 0);
signal y_in : STD_LOGIC_VECTOR(31 downto 0);
signal  h :  STD_LOGIC_VECTOR(31 downto 0);
signal x_out:  STD_LOGIC_VECTOR(31 downto 0);
signal y_out:  STD_LOGIC_VECTOR(31 downto 0);


begin
uut: RK_2 PORT MAP (
x_in => x_in,
y_in => y_in,
h => h,
x_out => x_out,
y_out => y_out
);

proc: process
begin

x_in <= x"40000000";
y_in <= x"3F800000";
h <= x"3DCCCCCD";

wait for 10 ns;

end process;

end Behavioral;

