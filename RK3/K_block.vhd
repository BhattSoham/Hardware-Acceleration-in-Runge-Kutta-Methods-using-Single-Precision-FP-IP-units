----------------------------------------------------------------------------------
-- Company: Rowan University.
-- Engineer: Soham Bhattacharya.
-- 
-- Create Date: 11/03/2022 10:54:58 PM
-- Design Name: 
-- Module Name: K_Block - Behavioral
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

entity K_block is
Port (     clk: in std_logic;
           x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           p_in : in STD_LOGIC_VECTOR(31 downto 0);
           p1_in : in STD_LOGIC_VECTOR(31 downto 0);
           k1 : out STD_LOGIC_VECTOR(31 downto 0);
           k2 : out STD_LOGIC_VECTOR(31 downto 0);
           k3 : out STD_LOGIC_VECTOR(31 downto 0)
        --   clk: in std_logic
           );
end K_block;

architecture Behavioral of K_block is
component func is
    Port ( x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
         clk: in std_logic;
           f : out STD_LOGIC_VECTOR(31 downto 0)
           );
end component;

COMPONENT FPU_ADD2
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

COMPONENT MAC1
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

COMPONENT MAC2
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

COMPONENT FPU_MUL2
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

COMPONENT MAC3
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

COMPONENT FPU_MUL3
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

COMPONENT FPU_MUL4
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

COMPONENT FPU_SUB2
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



--signal clk : std_logic := '1';
signal s_axis_a_tvalid: std_logic := '1';
signal s_axis_b_tvalid: std_logic := '1';
signal s_axis_a_tready4: std_logic := '1';
signal s_axis_b_tready4: std_logic := '1';
signal s_axis_c_tvalid: std_logic := '1';
signal s_axis_a_tready5: std_logic := '1';
signal s_axis_b_tready5: std_logic := '1';
signal s_axis_c_tready5: std_logic := '1';
signal s_axis_a_tready6: std_logic := '1';
signal s_axis_b_tready6: std_logic := '1';
signal s_axis_c_tready6: std_logic := '1';
signal s_axis_a_tready7: std_logic := '1';
signal s_axis_b_tready7: std_logic := '1';
signal s_axis_a_tready8: std_logic := '1';
signal s_axis_b_tready8: std_logic := '1';
signal s_axis_a_tready9: std_logic := '1';
signal s_axis_b_tready9: std_logic := '1';
signal s_axis_c_tready9: std_logic := '1';
signal s_axis_a_tready10: std_logic := '1';
signal s_axis_b_tready10: std_logic := '1';
signal s_axis_a_tready11: std_logic := '1';
signal s_axis_b_tready11: std_logic := '1';
signal m_axis_result_tvalid4 :  STD_LOGIC := '1';
signal m_axis_result_tvalid5 :  STD_LOGIC := '1';
signal m_axis_result_tvalid6 :  STD_LOGIC := '1';
signal m_axis_result_tvalid7 :  STD_LOGIC := '1';
signal m_axis_result_tvalid8 :  STD_LOGIC := '1';
signal m_axis_result_tvalid9 :  STD_LOGIC := '1';
signal m_axis_result_tvalid10 :  STD_LOGIC := '1';
signal m_axis_result_tvalid11 :  STD_LOGIC := '1';
--signal m_axis_result_tready: std_logic := '0';
signal k1_output: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal k2_output: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal k3_output: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal add1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal sub1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal add3: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal add4: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal add5: STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); 
signal fused3: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal fused4: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal fused5: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal fused6: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal K11: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal K22: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal K33: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal K44: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');


begin
f1: func
 Port map (
 x_in => x_in,
y_in => y_in,
clk => clk,
f => K11 );

uut1: FPU_MUL2
 Port map (
  aclk => clk,
  s_axis_a_tready => s_axis_a_tready4,
    s_axis_b_tready => s_axis_b_tready4,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => K11,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid4,
    --m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => k1_output
  );
 

  
 uut2: MAC1
 Port map (
  aclk => clk,
   s_axis_a_tready => s_axis_a_tready5,
    s_axis_b_tready => s_axis_b_tready5,
    s_axis_c_tready => s_axis_c_tready5,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => p_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
    s_axis_c_tvalid => s_axis_c_tvalid,
    s_axis_c_tdata => x_in, 
    m_axis_result_tvalid => m_axis_result_tvalid5, 
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => fused3
  ); 
 
  uut3: MAC2
 Port map (
  aclk => clk,
   s_axis_a_tready => s_axis_a_tready6,
    s_axis_b_tready => s_axis_b_tready6,
    s_axis_c_tready => s_axis_c_tready6,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => p_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => k1_output,
    s_axis_c_tvalid => s_axis_c_tvalid,
    s_axis_c_tdata => y_in, 
    m_axis_result_tvalid => m_axis_result_tvalid6, 
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => fused4
  ); 
 
 
f2: func
 Port map (
 clk => clk,
 x_in => fused3,
y_in => fused4,
f => K22 );


uut4: FPU_MUL3
 Port map (
  aclk => clk,
  s_axis_a_tready => s_axis_a_tready7,
    s_axis_b_tready => s_axis_b_tready7,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => K22,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid7,
    --m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => k2_output
  );

  
uut5: FPU_ADD2
 Port map (
  aclk => clk,
  s_axis_a_tready => s_axis_a_tready8,
    s_axis_b_tready => s_axis_b_tready8,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid8,
    --m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => add1
  );
  
  
   uut6: MAC3
 Port map (
  aclk => clk,
   s_axis_a_tready => s_axis_a_tready9,
    s_axis_b_tready => s_axis_b_tready9,
    s_axis_c_tready => s_axis_c_tready9,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => k2_output,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => p1_in,
    s_axis_c_tvalid => s_axis_c_tvalid,
    s_axis_c_tdata => y_in, 
    m_axis_result_tvalid => m_axis_result_tvalid9, 
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => fused5
  ); 

 uut7: FPU_SUB2
 Port map (
  aclk => clk,
  s_axis_a_tready => s_axis_a_tready10,
    s_axis_b_tready => s_axis_b_tready10,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => fused5,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => k1_output,
     m_axis_result_tvalid => m_axis_result_tvalid10,
    --m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => sub1
  );
 
  f4: func
 Port map (
 clk => clk,
 x_in => add1,
y_in => sub1,
--clk => clk,
f => K44 ); 

  
uut8: FPU_MUL4
 Port map (
  aclk => clk,
  s_axis_a_tready => s_axis_a_tready11,
    s_axis_b_tready => s_axis_b_tready11,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => K44,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid11,
    --m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => k3_output
  );
  

  

k1 <= k1_output ;
k2 <= k2_output ;
k3 <= k3_output;


end Behavioral;