------------------------------------------------------------------
-- Name        : modulo_cnt.vhd
-- Description : Modulo counter
-- Designed by : Claudio Avi Chami - FPGA'er website
--               http://fpgaer.tech
-- Date        : 14/August/2022
-- Version     : 02
-- 
-- History     : 01- Initial version
--             : 02- Recoded according Xilinx recommendations
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulo_cnt is
   generic (
      DATA_W   : natural := 32
   );
   port (
      clk:     in std_logic;
      rst:     in std_logic;
      
      -- inputs
      max_cnt: in std_logic_vector (DATA_W-1 downto 0);
      en:      in std_logic;

      -- outputs
      zero:    out std_logic
   );
end modulo_cnt;


architecture rtl of modulo_cnt is
   signal   cnt       : unsigned(DATA_W-1 downto 0);
   signal   zero_i   : std_logic;

begin 
zero_i   <= '1' when cnt = 0 else '0';
zero     <= zero_i;

counter_pr: process (clk, rst) 
   begin 
    if (rst = '1') then 
        cnt       <= (others => '0');
    elsif (rising_edge(clk)) then   
      if (en = '1') then            -- is counting enabled?
         if (zero_i = '1') then     -- check if counter reached zero
            cnt   <= unsigned(max_cnt) - 1;     
                                    -- reload with modulo value
         else
            cnt   <= cnt - 1;       -- decrement counter
         end if;  
      end if;  
    end if;
end process;

end rtl;
