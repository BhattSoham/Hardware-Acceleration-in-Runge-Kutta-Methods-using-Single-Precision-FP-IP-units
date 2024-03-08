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

entity k_block is
Port (     clk: in std_logic;
           x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           p_in : in STD_LOGIC_VECTOR(31 downto 0);
           k1 : out STD_LOGIC_VECTOR(31 downto 0);
           k2 : out STD_LOGIC_VECTOR(31 downto 0);
           k3 : out STD_LOGIC_VECTOR(31 downto 0);
           k4 : out STD_LOGIC_VECTOR(31 downto 0)
        --   clk: in std_logic
           );
end k_block;

architecture Behavioral of k_block is
component func is
    Port ( x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
         clk: in std_logic;
--           add1: inout STD_LOGIC_VECTOR(31 downto 0);
--           sub1: inout STD_LOGIC_VECTOR(31 downto 0);
           f : out STD_LOGIC_VECTOR(31 downto 0)
           );
end component;

COMPONENT fpu_add1
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

COMPONENT fpu_fused1
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

--COMPONENT fpu_add2
--  PORT (
--    aclk : IN STD_LOGIC;
--    s_axis_a_tvalid : IN STD_LOGIC;
--    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
--    s_axis_b_tvalid : IN STD_LOGIC;
--    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
--  --  m_axis_result_tready : IN STD_LOGIC;
--    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
--  );
--END COMPONENT;

COMPONENT fpu_fused2
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

COMPONENT fpu_add3
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

COMPONENT fpu_fused3
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
signal s_axis_c_tready8: std_logic := '1';
signal m_axis_result_tvalid4 :  STD_LOGIC := '1';
signal m_axis_result_tvalid5 :  STD_LOGIC := '1';
signal m_axis_result_tvalid6 :  STD_LOGIC := '1';
signal m_axis_result_tvalid7 :  STD_LOGIC := '1';
signal m_axis_result_tvalid8 :  STD_LOGIC := '1';
--signal m_axis_result_tready: std_logic := '0';
signal add1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal sub1: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal add3: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal add4: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal add5: STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); 
signal fused3: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal fused4: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal fused5: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
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
--add1 => add1,
--sub1 => sub1,
f => K11 );

uut1: fpu_add1
 Port map (
  aclk => clk,
  s_axis_a_tready => s_axis_a_tready4,
    s_axis_b_tready => s_axis_b_tready4,
    --s_axis_c_tready => s_axis_c_tready4,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => p_in,
     m_axis_result_tvalid => m_axis_result_tvalid4,
    --m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => add3
  );
 

  
 uut2: fpu_fused1 
 Port map (
  aclk => clk,
   s_axis_a_tready => s_axis_a_tready5,
    s_axis_b_tready => s_axis_b_tready5,
    s_axis_c_tready => s_axis_c_tready5,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => p_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => K11,
    s_axis_c_tvalid => s_axis_c_tvalid,
    s_axis_c_tdata => y_in, 
    m_axis_result_tvalid => m_axis_result_tvalid5, 
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => fused3
  ); 
 
 
f2: func
 Port map (
 clk => clk,
 x_in => add3,
y_in => fused3,
--clk => clk,
f => K22 );


  k2 <= K22;
  
 uut5 : fpu_fused2
  PORT MAP (
 aclk => clk,
  s_axis_a_tready => s_axis_a_tready6,
    s_axis_b_tready => s_axis_b_tready6,
    s_axis_c_tready => s_axis_c_tready6,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => p_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => K22,
    s_axis_c_tvalid => s_axis_c_tvalid,
    s_axis_c_tdata => y_in,
     m_axis_result_tvalid => m_axis_result_tvalid6,
   -- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => fused4
  );


 f3: func
 Port map (
 clk => clk,
 x_in => add3,
y_in => fused4,
--clk => clk,
f => K33 ); 

k3 <= K33;
uut7 : fpu_add3
  PORT MAP (
 aclk => clk,
  s_axis_a_tready => s_axis_a_tready7,
    s_axis_b_tready => s_axis_b_tready7,
   -- s_axis_c_tready => s_axis_c_tready4,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x_in,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid7,
   ---- m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => add5
  );
  
  uut8 : fpu_fused3
  PORT MAP (
    aclk => clk,
     s_axis_a_tready => s_axis_a_tready8,
    s_axis_b_tready => s_axis_b_tready8,
    s_axis_c_tready => s_axis_c_tready8,
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => h,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => K33,
    s_axis_c_tvalid => s_axis_c_tvalid,
    s_axis_c_tdata => y_in,
     m_axis_result_tvalid => m_axis_result_tvalid8,
  --  m_axis_result_tready => m_axis_result_tready,
    m_axis_result_tdata => fused5
  );

 f4: func
 Port map (
 clk => clk,
 x_in => add5,
y_in => fused5,
--clk => clk,
f => K44 ); 

  

k1 <= K11 ;
k2 <= K22 ;
k3 <= K33 ;
k4 <= K44;



end Behavioral;