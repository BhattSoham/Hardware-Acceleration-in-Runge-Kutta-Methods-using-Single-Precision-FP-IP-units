----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2023 07:30:53 PM
-- Design Name: 
-- Module Name: Top - Behavioral
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

entity Top is
 Port (

 clock: in std_logic;
 inst: in std_logic_vector(31 downto 0);
 cont: out std_logic_vector(31 downto 0);
 addr: out std_logic_vector(11 downto 0);
 x_out: out std_logic_vector(31 downto 0);
 y_out: out std_logic_vector(31 downto 0); 
  initial: out std_logic
 );
end Top;

architecture Behavioral of Top is

component Mem is
Port (   
           cont: in std_logic_vector(31 downto 0);
           addr : in std_logic_vector(11 downto 0);
           x_in: out STD_LOGIC_VECTOR(31 downto 0);
           y_in : out STD_LOGIC_VECTOR(31 downto 0);
           h : out STD_LOGIC_VECTOR(31 downto 0);
           p_in : out STD_LOGIC_VECTOR(31 downto 0);
           p1_in : out STD_LOGIC_VECTOR(31 downto 0);
           c_in : out STD_LOGIC_VECTOR(31 downto 0);
           write_en: in std_logic;
           clock: in std_logic;
           flush : in std_logic;
           init: in std_logic;
           x_out: in STD_LOGIC_VECTOR(31 downto 0);
           y_out : in STD_LOGIC_VECTOR(31 downto 0)
          
            );
end component;

component reg is
Port (
        clk: in std_logic;
        rs1 : in std_logic_vector(4 downto 0);
        regwr : in std_logic;
        wrdata: out std_logic_vector(31 downto 0)
--        x_out : out std_logic_vector(31 downto 0);
--        y_out: out std_logic_vector(31 downto 0)
        );
 end component;

component Control is
Port (

inst: in std_logic_vector(31 downto 0);
addr: out std_logic_vector(11 downto 0);
flush: out std_logic;
write_en: out std_logic;
init: out std_logic
 );
end component;

component RKMod1 is
Port (
  clk: in std_logic;
   x_in: in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           p_in : in STD_LOGIC_VECTOR(31 downto 0);
           p1_in : in STD_LOGIC_VECTOR(31 downto 0);
           c_in : in STD_LOGIC_VECTOR(31 downto 0);
           x_out: out STD_LOGIC_VECTOR(31 downto 0);
           y_out: out STD_LOGIC_VECTOR(31 downto 0)
        --   clk : in std_logic
           --aclk: in std_logic
    );
end component;
 
signal clk: std_logic;
signal addr1: std_logic_vector(11 downto 0);
signal wdata:  std_logic_vector(31 downto 0);
signal  rs :  std_logic_vector(4 downto 0);
signal flush : std_logic;
signal write_en: std_logic;
signal   x_in1:  STD_LOGIC_VECTOR(31 downto 0);
signal  y_in1 :  STD_LOGIC_VECTOR(31 downto 0);
signal    h1 :  STD_LOGIC_VECTOR(31 downto 0);
signal  p_in1 :  STD_LOGIC_VECTOR(31 downto 0);
signal  p1_in1 :  STD_LOGIC_VECTOR(31 downto 0);
signal   c_in1 :  STD_LOGIC_VECTOR(31 downto 0);
signal x_output:  STD_LOGIC_VECTOR(31 downto 0);
signal y_output :  STD_LOGIC_VECTOR(31 downto 0);
signal init : std_logic;

signal  init_flag :  std_logic;
--signal inst:  std_logic_vector(31 downto 0);
begin

uut1: Mem port map (

cont => wdata,
addr =>  addr1,
write_en => write_en,
clock => clk,
x_in => x_in1,
y_in => y_in1,
h => h1,
p_in => p_in1,
c_in => c_in1,
p1_in => p1_in1,
flush => flush,
init => init,
x_out => x_output,
y_out => y_output
);

uut2: reg port map (
 clk => clk,
 rs1 => inst(19 downto 15), 
 regwr => write_en,
 wrdata => wdata
);

uut3: Control port map (

inst => inst,
addr => addr1,
flush => flush,
write_en => write_en,
init => init );

uut4: RKMod1 port map (
clk => clock,
x_in => x_in1,
y_in => y_in1,
h => h1,
p_in => p_in1,
c_in => c_in1,
p1_in => p1_in1,
x_out => x_output,
y_out => y_output
--clk => clock
);
clk <= clock;
cont <= wdata;
--addr1 <= inst(31 downto 20);
addr <= addr1;
initial <= init;
x_out <= x_output;
y_out <= y_output;



end Behavioral;