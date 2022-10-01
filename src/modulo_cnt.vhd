------------------------------------------------------------------
-- Name        : modulo_cnt.vhd
-- Description : Modulo counter
-- Designed by : Claudio Avi Chami - FPGA'er website
--               http://fpgaer.tech
-- Date        : 24/September/2022
-- Version     : 03
-- 
-- History     : 01- Initial version
--             : 02- Recoded according Xilinx recommendations
--             : 03- Simplified using recommendations given on Reddit
------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY modulo_cnt IS
  PORT (
    clk     : IN  STD_LOGIC;
    rst     : IN  STD_LOGIC;

    -- inputs
    max_cnt : IN  STD_LOGIC_VECTOR;
    en      : IN  STD_LOGIC;

    -- outputs
    zero    : OUT STD_LOGIC
  );
END modulo_cnt;
ARCHITECTURE rtl OF modulo_cnt IS
  SIGNAL cnt : unsigned(max_cnt'left DOWNTO 0);

BEGIN
  counter_pr : PROCESS (clk)
  BEGIN
    IF (rising_edge(clk)) THEN
      IF (rst = '1') THEN
        cnt  <= unsigned(max_cnt) - 1;
        zero <= '0';
      ELSIF (en = '1') THEN             -- is counting enabled?
        IF (cnt = 1) THEN               -- Use pipeline to assert zero
          zero <= '1';                  -- together with cnt=0
        ELSE
          zero <= '0';
        END IF;
        IF (zero = '1') THEN            -- check if counter reached zero
          cnt <= unsigned(max_cnt) - 1; -- reload with modulo_value-1
        ELSE
          cnt <= cnt - 1;               -- decrement counter
        END IF;
      END IF;
    END IF;
  END PROCESS counter_pr;

END rtl;