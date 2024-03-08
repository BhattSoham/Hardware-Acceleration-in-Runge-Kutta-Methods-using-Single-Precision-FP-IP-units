
-- Engineer: Soham Bhattacharya.
-- 
-- Create Date: 11/03/2022 05:17:08 PM
-- Design Name: 
-- Module Name: FEB1 - Behavioral
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

entity func is
    Port ( clk: in std_logic;
           x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
          --           add1: inout STD_LOGIC_VECTOR(31 downto 0);
--           sub1: inout STD_LOGIC_VECTOR(31 downto 0);
           f : out STD_LOGIC_VECTOR(31 downto 0)
         --  clk: in std_logic
           );
end func;



architecture Behavioral of func is
COMPONENT fpu_add
  PORT (
  aclk : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tready : OUT STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tready : OUT STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT fpu_sub
  PORT (
 aclk : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tready : OUT STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tready : OUT STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT fpu_mul
  PORT (
 aclk : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tready : OUT STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tready : OUT STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

--signal clk: std_logic := '1';
signal s_axis_a_tvalid: std_logic := '1';
signal s_axis_b_tvalid: std_logic := '1';
signal s_axis_a_tready1: std_logic := '1';
signal s_axis_b_tready1: std_logic := '1';
signal s_axis_a_tready2: std_logic := '1';
signal s_axis_b_tready2: std_logic := '1';
signal s_axis_a_tready3: std_logic := '1';
signal s_axis_b_tready3: std_logic := '1';
signal add1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal sub1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal m_axis_result_tvalid1: std_logic := '0';
signal m_axis_result_tvalid2: std_logic := '0';
signal m_axis_result_tvalid3: std_logic := '0';
signal func: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');


begin 
 
uut: fpu_add
  PORT MAP (
    aclk => clk,
    s_axis_a_tready => s_axis_a_tready1,
    s_axis_b_tready => s_axis_b_tready1,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => y_in,
    m_axis_result_tvalid => m_axis_result_tvalid1,
    m_axis_result_tdata => add1
  );


uut1: fpu_sub
  PORT MAP (
    aclk => clk,
    s_axis_a_tready => s_axis_a_tready2,
    s_axis_b_tready => s_axis_b_tready2,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => y_in,
   m_axis_result_tvalid => m_axis_result_tvalid2,
    m_axis_result_tdata => sub1
  );

uut2 : fpu_mul
  PORT MAP (
   aclk => clk,
      s_axis_a_tready => s_axis_a_tready3,
    s_axis_b_tready => s_axis_b_tready3,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => add1,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => sub1,
    m_axis_result_tvalid => m_axis_result_tvalid3,
    m_axis_result_tdata => func
  );
   
 
f <= func ;

 

end Behavioral;
