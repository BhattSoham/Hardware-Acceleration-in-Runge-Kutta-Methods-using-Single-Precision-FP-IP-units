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
Port ( x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           h : in STD_LOGIC_VECTOR(31 downto 0);
           k_output : out STD_LOGIC_VECTOR(31 downto 0)
          
           );
end k_block;

architecture Behavioral of k_block is
component func is
    Port ( x_in : in STD_LOGIC_VECTOR(31 downto 0);
           y_in : in STD_LOGIC_VECTOR(31 downto 0);
           f : out STD_LOGIC_VECTOR(31 downto 0)
           );
end component;

COMPONENT FPU_ADD1
  PORT (
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
   m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT FPU_ADD2
  PORT (
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
   m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT FPU_ADD3
  PORT (
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
   m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT FPU_MUL1
  PORT (
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT FPU_MUL2
  PORT (
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;

COMPONENT FPU_MUL3
  PORT (
    s_axis_a_tvalid : IN STD_LOGIC;
    s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_b_tvalid : IN STD_LOGIC;
    s_axis_b_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_result_tvalid : OUT STD_LOGIC;
    m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) 
  );
END COMPONENT;


--signal clk : std_logic := '1';
signal s_axis_a_tvalid: std_logic := '0';
signal s_axis_b_tvalid: std_logic := '0';
signal s_axis_c_tvalid: std_logic := '0';
signal m_axis_result_tvalid1 :  STD_LOGIC := '0';
signal m_axis_result_tvalid2 :  STD_LOGIC := '0';
signal m_axis_result_tvalid3 :  STD_LOGIC := '0';
signal m_axis_result_tvalid4 :  STD_LOGIC := '0';
signal m_axis_result_tvalid5 :  STD_LOGIC := '0';
signal m_axis_result_tvalid6 :  STD_LOGIC := '0';
signal   x: std_logic_vector(31 downto 0) := (others => '0');
signal   y: std_logic_vector(31 downto 0) := (others => '0');
--signal m_axis_result_tready: std_logic := '0';
signal fun: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal func2: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal m: STD_LOGIC_VECTOR(31 downto 0)  := (others => '0');
signal n: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal o: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal p: STD_LOGIC_VECTOR(31 downto 0) := x"3F000000"; 
signal K11: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal K22: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal K_out: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');


begin

x <= x_in;
y <= y_in;

f1: func
 Port map (
 x_in => x,
y_in => y,
f => fun );

uut1: FPU_MUL1
Port map (
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => fun,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid1,
     m_axis_result_tdata => K11
  );
 
uut2: FPU_ADD1
PORT MAP (
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => x,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
    m_axis_result_tvalid => m_axis_result_tvalid2,
    m_axis_result_tdata => m
);
  
uut3: FPU_ADD2
PORT MAP (
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => y,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => K11,
    m_axis_result_tvalid => m_axis_result_tvalid3,
    m_axis_result_tdata => n
);  
  
f2: func
 Port map (
 x_in => m,
y_in => n,
f => func2 );

uut4: FPU_MUL2
Port map (
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => func2,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => h,
     m_axis_result_tvalid => m_axis_result_tvalid4,
     m_axis_result_tdata => K22
  );

uut5: FPU_ADD3
PORT MAP (
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => K11,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => K22,
    m_axis_result_tvalid => m_axis_result_tvalid5,
    m_axis_result_tdata => o
);  
  
uut6: FPU_MUL3
Port map (
    s_axis_a_tvalid => s_axis_a_tvalid,
    s_axis_a_tdata => o,
    s_axis_b_tvalid => s_axis_b_tvalid,
    s_axis_b_tdata => p,
     m_axis_result_tvalid => m_axis_result_tvalid6,
     m_axis_result_tdata => K_out
  );


k_output <= K_out;




end Behavioral;