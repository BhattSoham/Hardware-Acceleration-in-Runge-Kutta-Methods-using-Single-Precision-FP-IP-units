----------------------------------------------------------------------------------3C888F86
-- Company: Rowan University.
-- Engineer: Soham Bhattacharya.
-- 
-- Create Date: 11/04/2022 05:04:36 PM
-- Design Name: 
-- Module Name: RKMod - Behavioral
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
use IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RK_2 is
Port (
   x_in: in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           x_out: out STD_LOGIC_VECTOR(31 downto 0);
           y_out: out STD_LOGIC_VECTOR(31 downto 0)
    );
end RK_2;

architecture Behavioral of RK_2 is
component k_block is
Port ( x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           k_output : out STD_LOGIC_VECTOR(31 downto 0)
          
           );
end component;

COMPONENT FPU_ADD4
  PORT (
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
   m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT FPU_ADD5
  PORT (
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
   m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;


--signal clk: std_logic := '1';
signal s_axis_a_tvalid: std_logic := '0';
signal s_axis_b_tvalid: std_logic := '0';
signal s_axis_c_tvalid: std_logic := '0';
signal m_axis_result_tvalid1: std_logic := '0';
signal m_axis_result_tvalid2: std_logic := '0';
signal   x: std_logic_vector(31 downto 0) := (others => '0');
signal   y: std_logic_vector(31 downto 0) := (others => '0');
signal add1: STD_LOGIC_VECTOR(31 downto 0) ;
signal   K: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal   x_output: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal   y_output: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');


            
begin
x <= x_in;
y <= y_in;

uut: k_block port map (
x_in => x,
y_in => y,
h => h,
k_output => K);
--clk => clk );

uut1 : FPU_ADD4
  PORT MAP (
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => K,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => y,
   m_axis_result_tvalid => m_axis_result_tvalid1,
    m_axis_result_tdata => y_output
  );

uut2: FPU_ADD5
  PORT MAP (
  --  aclk => clk,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid2,
  --  m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => x_output
  );

  x_out <= x_output;
   y_out <= y_output;




end Behavioral;