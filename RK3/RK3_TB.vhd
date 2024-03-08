----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2023 02:52:35 PM
-- Design Name: 
-- Module Name: RK3_TB - Behavioral
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

entity RK3_TB is
--  Port ( );
end RK3_TB;

architecture Behavioral of RK3_TB is
component RK3 is 
Port (
   x_in: in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           p_in : in STD_LOGIC_VECTOR(31 downto 0);
           p1_in : in STD_LOGIC_VECTOR(31 downto 0);
           c_in : in STD_LOGIC_VECTOR(31 downto 0);
           r_in : in STD_LOGIC_VECTOR(31 downto 0); 
           x_out: out STD_LOGIC_VECTOR(31 downto 0);
           y_out: out STD_LOGIC_VECTOR(31 downto 0);
           clk: in std_logic
    );
end component;

constant clock_period : time := 10 ns;

 signal x_in:  STD_LOGIC_VECTOR(31 downto 0);
 signal y_in :  STD_LOGIC_VECTOR(31 downto 0);
 signal h :  STD_LOGIC_VECTOR(31 downto 0);
 signal p_in : STD_LOGIC_VECTOR(31 downto 0);
 signal p1_in :STD_LOGIC_VECTOR(31 downto 0);
 signal c_in : STD_LOGIC_VECTOR(31 downto 0);
 signal r_in :  STD_LOGIC_VECTOR(31 downto 0); 
 signal x_out:  STD_LOGIC_VECTOR(31 downto 0);
 signal y_out:  STD_LOGIC_VECTOR(31 downto 0);
 signal  clk:  std_logic := '1';

begin
uut: RK3 port map (
clk => clk,
x_in => x_in,
y_in => y_in,
h => h,
p_in => p_in,
c_in => c_in,
p1_in => p1_in,
r_in => r_in,
x_out => x_out,
y_out => y_out);

RK3_clock: process
begin
clk <= '0';
wait for clock_period/2;
  clk <= '1';
wait for clock_period/2;
   end process;

proc: process
begin 
x_in <= x"40066666";
y_in <= x"3fa4eafe";
h <= x"3DCCCCCD";
p_in <= x"3F000000";
p1_in <= x"40000000"; 
c_in <= x"40800000";
r_in <= x"3E2AB368";

wait for clock_period * 100;
wait;

end process;



end Behavioral;
