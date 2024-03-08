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

entity RKMod1 is
Port (
   x_in: in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           p_in : in STD_LOGIC_VECTOR(31 downto 0);
           p1_in : in STD_LOGIC_VECTOR(31 downto 0);
           c_in : in STD_LOGIC_VECTOR(31 downto 0);
           x_out: out STD_LOGIC_VECTOR(31 downto 0);
           y_out: out STD_LOGIC_VECTOR(31 downto 0);
           clk: in std_logic
    );
end RKMod1;

architecture Behavioral of RKMod1 is
component k_block is
Port (      clk: in std_logic;
           x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           p_in : in STD_LOGIC_VECTOR(31 downto 0);
           k1 : out STD_LOGIC_VECTOR(31 downto 0);
           k2 : out STD_LOGIC_VECTOR(31 downto 0);
           k3 : out STD_LOGIC_VECTOR(31 downto 0);
           k4 : out STD_LOGIC_VECTOR(31 downto 0)
          -- clk: in std_logic
           );
end component;

COMPONENT RKMul1
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

COMPONENT RKmul2
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

COMPONENT fpu_addi1
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

COMPONENT fpu_addit2
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

COMPONENT fpu_addi3
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

COMPONENT RKFPU_fused
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

COMPONENT ADDI
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
signal s_axis_c_tvalid: std_logic := '1';
signal s_axis_a_tready9: std_logic := '1';
signal s_axis_b_tready9: std_logic := '1';
signal s_axis_a_tready10: std_logic := '1';
signal s_axis_b_tready10: std_logic := '1';
signal s_axis_a_tready11: std_logic := '1';
signal s_axis_b_tready11: std_logic := '1';
signal s_axis_a_tready12: std_logic := '1';
signal s_axis_b_tready12: std_logic := '1';
signal s_axis_a_tready13: std_logic := '1';
signal s_axis_b_tready13: std_logic := '1';
signal s_axis_a_tready14: std_logic := '1';
signal s_axis_b_tready14: std_logic := '1';
signal s_axis_c_tready: std_logic := '1';
signal s_axis_a_tready15: std_logic := '1';
signal s_axis_b_tready15: std_logic := '1';
signal m_axis_result_tvalid9: std_logic := '1';
signal m_axis_result_tvalid10: std_logic := '1';
signal m_axis_result_tvalid11: std_logic := '1';
signal m_axis_result_tvalid12: std_logic := '1';
signal m_axis_result_tvalid13: std_logic := '1';
signal m_axis_result_tvalid14: std_logic := '1';
signal m_axis_result_tvalid15: std_logic := '1';
signal add1: STD_LOGIC_VECTOR(31 downto 0) ;
signal sub1: STD_LOGIC_VECTOR(31 downto 0) ;
signal  x_output :  STD_LOGIC_VECTOR(31 downto 0);
signal y_output :  STD_LOGIC_VECTOR(31 downto 0) ;
signal k1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal k2: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal k3: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal k4: STD_LOGIC_VECTOR(31 downto 0)   := (others => '0');
signal   a: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal   b: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal   d: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal   e: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal   g: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');


            
begin
uut: k_block port map (
clk => clk,
x_in => x_in,
y_in => y_in,
h => h,
p_in => p_in,
k1 => k1,
k2 => k2,
k3 => k3,
k4 => k4 );
--clk => clk );

uut1 : RKMul1
  PORT MAP (
   aclk => clk,
   s_axis_a_tready => s_axis_a_tready9,
    s_axis_b_tready => s_axis_b_tready9,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => p1_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => k2,
   m_axis_result_tvalid => m_axis_result_tvalid9,
    m_axis_result_tdata => a
  );

uut2: RKmul2
  PORT MAP (
    aclk => clk,
    s_axis_a_tready => s_axis_a_tready10,
    s_axis_b_tready => s_axis_b_tready10,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => p1_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => k3,
     m_axis_result_tvalid => m_axis_result_tvalid10,
  --  m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => b
  );

uut3 : fpu_addi1
  PORT MAP (
   aclk => clk,
   s_axis_a_tready => s_axis_a_tready11,
    s_axis_b_tready => s_axis_b_tready11,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => k1,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => a,
     m_axis_result_tvalid => m_axis_result_tvalid11,
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => d
  );

uut4 : fpu_addit2
  PORT MAP (
   aclk => clk,
   s_axis_a_tready => s_axis_a_tready12,
    s_axis_b_tready => s_axis_b_tready12,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => d,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => b,
     m_axis_result_tvalid => m_axis_result_tvalid12,
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => e
  );

uut5 : fpu_addi3
  PORT MAP (
   aclk => clk,
   s_axis_a_tready => s_axis_a_tready13,
    s_axis_b_tready => s_axis_b_tready13,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => e,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => k4,
     m_axis_result_tvalid => m_axis_result_tvalid13,
  --  m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => g
  );

uut6 : RKFPU_fused
  PORT MAP (
    aclk => clk,
    s_axis_a_tready => s_axis_a_tready14,
    s_axis_b_tready => s_axis_b_tready14,
    s_axis_c_tready => s_axis_c_tready,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => c_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => g,
    s_axis_c_tvalid => s_axis_c_tvalid,
    s_axis_c_tdata => y_in,
     m_axis_result_tvalid => m_axis_result_tvalid14,
  --  m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => y_output
  );
uut7 : ADDI
  PORT MAP (
    aclk => clk,
    s_axis_a_tready => s_axis_a_tready15,
    s_axis_b_tready => s_axis_b_tready15,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid15,
--    m_axis_result_tvalid => m_axis_result_tvalid,
    m_axis_result_tdata => x_output
  );


  x_out <= x_output;
   y_out <= y_output;




end Behavioral;