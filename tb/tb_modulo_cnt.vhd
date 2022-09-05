
------------------------------------------------------------------
-- Name        : tb_modulo_cnt.vhd
-- Description : Testbench for modulo counter
-- Designed by : Claudio Avi Chami - FPGA Site
--               http://fpgaer.tech
-- Date        : 05/September/2022
-- Version     : 01
------------------------------------------------------------------
library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_textio.all;
   use ieee.numeric_std.ALL;
   use std.textio.all;
    
entity tb_modulo_cnt is
end entity;

architecture test of tb_modulo_cnt is

   constant DATA_W         : natural   := 8                           ; 
   constant CLK_FREQ       : natural   := 80                          ; -- in MHz
   constant CLK_PER        : natural   := 1000000 / CLK_FREQ          ; -- in ps
   constant clk_period     : time      := CLK_PER * 1 ps              ;
   
   signal clk        : std_logic := '0';
   signal rst        : std_logic := '1';
   signal en         : std_logic := '0';
   signal modulo     : std_logic_vector(DATA_W-1 downto 0);
   signal mod_int    : integer;
   
   signal endSim     : boolean   := false;

   component modulo_cnt  is
      generic (
         DATA_W     : natural := 32
      );
      port (
         clk:        in std_logic;
         rst:        in std_logic;
         
         -- inputs
         max_cnt:    in std_logic_vector (DATA_W-1 downto 0);
         en:         in std_logic;

         -- outputs
         zero:       out std_logic
      );
   end component;


begin
   clk     <= not clk after clk_period/2;
   modulo  <= std_logic_vector(to_unsigned(mod_int, modulo'length));

   -- Main simulation process
   process 
   begin
      
      mod_int <= 12;
      wait for 100 ns;
      wait until (clk = '0');
      rst <= '0';

      wait for 200 ns;
      wait until (rising_edge(clk));
      en  <= '1';
      
      wait for 300 ns;
      wait until (rising_edge(clk));
      mod_int <= 6;
      wait until (rising_edge(clk));
      
      wait for 200 ns;
      wait until (rising_edge(clk));
      en <= '0';
      wait for 150 ns;
      wait until (rising_edge(clk));
      en <= '1';
      
      wait for 200 ns;
      wait until (rising_edge(clk));
      mod_int <= 21;
      wait until (rising_edge(clk));
      
      wait for 300 ns;
      endSim  <= true;
   end process; 
      
   -- End the simulation
   process 
   begin
      if (endSim) then
         assert false 
            report "End of simulation." 
            severity failure; 
      end if;
      wait until (rising_edge(clk));
   end process;   

   modulo_cnt_i : modulo_cnt
   generic map (
      DATA_W   => DATA_W
   )
   port map (
      clk      => clk,
      rst      => rst,
      
      max_cnt  => modulo,
      en       => en,
      
      zero     => open
   );

end architecture;
