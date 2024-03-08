------------------------------------------------------------------------------------------------------------------------------
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

entity RK3 is
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
end RK3;

architecture Behavioral of RK3 is
component K_block is
Port (      clk: in std_logic;
           x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           p_in : in STD_LOGIC_VECTOR(31 downto 0);
           p1_in : in STD_LOGIC_VECTOR(31 downto 0);
           k1 : out STD_LOGIC_VECTOR(31 downto 0);
           k2 : out STD_LOGIC_VECTOR(31 downto 0);
           k3 : out STD_LOGIC_VECTOR(31 downto 0)
          -- clk: in std_logic
           );
end component;

COMPONENT FPU_MUL5
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

COMPONENT FPU_ADD3
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

COMPONENT FPU_ADD4
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

COMPONENT FPU_ADD5
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

COMPONENT MAC4
  PORT (
 aclk : IN STD_LOGIC;
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tready : OUT STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tready : OUT STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_c_tvalid : IN STD_LOGIC;
    s_axis_c_tready : OUT STD_LOGIC;
    s_axis_c_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

--signal clk: std_logic := '1';
signal s_axis_a_tvalid: std_logic := '1';
signal s_axis_b_tvalid: std_logic := '1';
signal s_axis_c_tvalid: std_logic := '1';
signal s_axis_a_tready17: std_logic := '1';
signal s_axis_b_tready17: std_logic := '1';
signal s_axis_c_tready17: std_logic := '1';
signal s_axis_a_tready13: std_logic := '1';
signal s_axis_b_tready13: std_logic := '1';
signal s_axis_a_tready14: std_logic := '1';
signal s_axis_b_tready14: std_logic := '1';
signal s_axis_a_tready15: std_logic := '1';
signal s_axis_b_tready15: std_logic := '1';
signal s_axis_a_tready16: std_logic := '1';
signal s_axis_b_tready16: std_logic := '1';
signal m_axis_result_tvalid17: std_logic := '1';
signal m_axis_result_tvalid13: std_logic := '1';
signal m_axis_result_tvalid14: std_logic := '1';
signal m_axis_result_tvalid15: std_logic := '1';
signal m_axis_result_tvalid16: std_logic := '1';
signal  x_output :  STD_LOGIC_VECTOR(31 downto 0);
signal y_output :  STD_LOGIC_VECTOR(31 downto 0) ;
signal k1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal k2: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal k3: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal k4: STD_LOGIC_VECTOR(31 downto 0)   := (others => '0');
signal add1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal mac1: STD_LOGIC_VECTOR(31 downto 0)   := (others => '0');
signal k_out: STD_LOGIC_VECTOR(31 downto 0)   := (others => '0');



            
begin
uut: K_block port map (
clk => clk,
x_in => x_in,
y_in => y_in,
h => h,
p_in => p_in,
p1_in => p1_in,
k1 => k1,
k2 => k2,
k3 => k3);


uut6 : MAC4
  PORT MAP (
  aclk => clk,
    s_axis_a_tready => s_axis_a_tready17,
    s_axis_b_tready => s_axis_b_tready17,
    s_axis_c_tready => s_axis_c_tready17,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => k2,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => c_in,
    s_axis_c_tvalid => s_axis_c_tvalid,
    s_axis_c_tdata => k1,
     m_axis_result_tvalid => m_axis_result_tvalid17,
  --  m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => mac1
  
  );

uut2: FPU_ADD3
  PORT MAP (
    aclk => clk,
    s_axis_a_tready => s_axis_a_tready13,
    s_axis_b_tready => s_axis_b_tready13,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => mac1,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => k3,
     m_axis_result_tvalid => m_axis_result_tvalid13,
  --  m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => add1
  );

uut3 : FPU_MUL5
  PORT MAP (
   aclk => clk,
   s_axis_a_tready => s_axis_a_tready14,
    s_axis_b_tready => s_axis_b_tready14,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => add1,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => r_in,
     m_axis_result_tvalid => m_axis_result_tvalid14,
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => k_out
  );

uut4 : FPU_ADD4
  PORT MAP (
   aclk => clk,
   s_axis_a_tready => s_axis_a_tready15,
    s_axis_b_tready => s_axis_b_tready15,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => y_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => k_out,
     m_axis_result_tvalid => m_axis_result_tvalid15,
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => y_output
  );

uut5 : FPU_ADD5
  PORT MAP (
   aclk => clk,
   s_axis_a_tready => s_axis_a_tready16,
    s_axis_b_tready => s_axis_b_tready16,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid16,
  --  m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => x_output
  );


  x_out <= x_output;
   y_out <= y_output;




end Behavioral;