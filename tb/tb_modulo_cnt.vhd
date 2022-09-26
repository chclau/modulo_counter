------------------------------------------------------------------
-- Name        : tb_modulo_cnt.vhd
-- Description : Testbench for modulo counter
-- Designed by : Claudio Avi Chami - FPGA Site
--               http://fpgaer.tech
-- Date        : 05/September/2022
-- Version     : 01
------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_textio.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY tb_modulo_cnt IS
END ENTITY;

ARCHITECTURE test OF tb_modulo_cnt IS

  CONSTANT DATA_W : NATURAL := 8;
  CONSTANT CLK_FREQ : NATURAL := 100; -- in MHz
  CONSTANT CLK_PER : NATURAL := 1000000 / CLK_FREQ; -- in ps
  CONSTANT clk_period : TIME := CLK_PER * 1 ps;

  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL rst : STD_LOGIC := '1';
  SIGNAL en : STD_LOGIC := '0';
  SIGNAL modulo : STD_LOGIC_VECTOR(DATA_W - 1 DOWNTO 0);
  SIGNAL mod_int : INTEGER;

  SIGNAL endSim : BOOLEAN := false;

  COMPONENT modulo_cnt IS
    PORT (
      clk     : IN  STD_LOGIC;
      rst     : IN  STD_LOGIC;

      -- inputs
      max_cnt : IN  STD_LOGIC_VECTOR;
      en      : IN  STD_LOGIC;

      -- outputs
      zero    : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  clk <= NOT clk AFTER clk_period/2;
  modulo <= STD_LOGIC_VECTOR(to_unsigned(mod_int, modulo'length));

  -- Main simulation process
  PROCESS
  BEGIN

    mod_int <= 12;
    WAIT FOR 100 ns;
    WAIT UNTIL (clk = '0');
    rst <= '0';

    WAIT FOR 200 ns;
    WAIT UNTIL (rising_edge(clk));
    en <= '1';

    WAIT FOR 300 ns;
    WAIT UNTIL (rising_edge(clk));
    mod_int <= 6;
    WAIT UNTIL (rising_edge(clk));

    WAIT FOR 180 ns;
    WAIT UNTIL (rising_edge(clk));
    en <= '0';
    WAIT FOR 150 ns;
    WAIT UNTIL (rising_edge(clk));
    en <= '1';

    WAIT FOR 200 ns;
    WAIT UNTIL (rising_edge(clk));
    mod_int <= 21;
    WAIT UNTIL (rising_edge(clk));

    WAIT FOR 300 ns;
    endSim <= true;
  END PROCESS;

  -- End the simulation
  PROCESS
  BEGIN
    IF (endSim) THEN
      ASSERT false
      REPORT "End of simulation."
        SEVERITY failure;
    END IF;
    WAIT UNTIL (rising_edge(clk));
  END PROCESS;

  modulo_cnt_i : modulo_cnt
  PORT MAP(
    clk     => clk,
    rst     => rst,

    max_cnt => modulo,
    en      => en,

    zero    => OPEN
  );

END ARCHITECTURE;