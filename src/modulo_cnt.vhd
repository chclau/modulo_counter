-------------------------------------------------------------------
-- Name        : modulo_cnt.vhd
-- Description : modulo counter
-- Designed by : Claudio Avi Chami - fpga'er website
--               http://fpgaer.tech
-- Date        : 24/september/2022
-- Version     : 04
-- 
-- History     : 01- initial version
--             : 02- recoded according xilinx recommendations
--             : 03- simplified using recommendations given on reddit
--             : 04- added normalization to unconstrained ports
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulo_cnt is
  port (
    clk     : in  std_logic;
    rst     : in  std_logic;

    -- inputs
    max_cnt : in  std_logic_vector;
    en      : in  std_logic;

    -- outputs
    zero    : out std_logic
  );
end modulo_cnt;
architecture rtl of modulo_cnt is
  -- normalize the unconstrained input
  alias max_cnt_norm : std_logic_vector(max_cnt'length - 1 downto 0) is max_cnt; -- normalized unconstrained input
  signal cnt : unsigned(max_cnt_norm'left downto 0);

begin
  counter_pr : process (clk)
  begin
    if (rising_edge(clk)) then
      if (rst = '1') then
        cnt <= unsigned(max_cnt_norm) - 1;
        zero <= '0';
      elsif (en = '1') then -- is counting enabled?
        if (cnt = 1) then -- use pipeline to assert zero
          zero <= '1'; -- together with cnt=0
        else
          zero <= '0';
        end if;
        if (zero = '1') then -- check if counter reached zero
          cnt <= unsigned(max_cnt_norm) - 1; -- reload with modulo_value-1
        else
          cnt <= cnt - 1; -- decrement counter
        end if;
      end if;
    end if;
  end process counter_pr;

end rtl;