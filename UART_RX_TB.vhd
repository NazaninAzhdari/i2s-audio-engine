library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UART_RX_TB is
end UART_RX_TB;

architecture RTL of UART_RX_TB is
    signal i_clk50_TB               :   STD_LOGIC               :='0';
    signal i_reset_TB               :   STD_LOGIC               :='0';
    signal i_data_serial_TB         :   STD_LOGIC               :='0';
    signal o_data_parallel_TB       :   unsigned(7 downto 0);
    signal o_data_DV_TB             :   STD_LOGIC;

    constant c_CLK50_PERIOD         :   time    := 20 ns;
    constant c_HALF_CLK50_PERIOD    :   time    := 10 ns;      

    begin
        ---------------------------------
        --Generate 50MHz Clock
        ---------------------------------
        generate_50mhz_clk: process
        begin
            i_clk50_TB <= '0';
            wait for c_HALF_CLK50_PERIOD;
            i_clk50_TB <= '1';
            wait for c_HALF_CLK50_PERIOD;
        end process;

        ----------------------------------
        --Declare UUT: UART Reciever
        ----------------------------------
        uut_uart_reciever: entity work.UART_RX
        generic map(
            g_BITS_LIMIT    => 8,
            g_CLKS_PER_BIT  => 434     --Systems CLK / Baud rate
        );
        port map(
            i_clk            => i_CLK50_TB,
            i_reset          => i_reset_TB,
            i_data_serial    => i_data_serial_TB,
            o_data_parallel  => o_data_parallel_TB,
            o_data_DV        => o_data_DV_TB
        );


        sim: process
        begin
            i_reset_TB <= '1';
            wait for c_CLK50_PERIOD;
            i_reset_TB <= '0';
            i_data_serial_TB <= '1';
            wait until rising_edge(i_CLK50_TB);
            --Start bit: Zero
            i_data_serial_TB <= '0'; 
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT; 
            --Send Ascii code from LSB
            --Bit 0
            i_data_serial_TB <= '1';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            --Bit 1
            i_data_serial_TB <= '1';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 2
            i_data_serial_TB <= '0';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 3
            i_data_serial_TB <= '0';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 4
            i_data_serial_TB <= '1';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 5
            i_data_serial_TB <= '1';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 6
            i_data_serial_TB <= '0';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 7
            i_data_serial_TB <= '0';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            --send Stop Bit: one
            i_data_serial_TB <= '1';
            wait until rising_edge(o_data_DV_TB);
            assert o_parallel_data_TB = "00110011" report " Ascii code /= "00110011" " severity Error;
            wait for c_CLK50_PERIOD;

            --New Data
            --Start bit: Zero
            i_data_serial_TB <= '0'; 
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT; 
            --Send Ascii code from LSB
            --Bit 0
            i_data_serial_TB <= '0';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            --Bit 1
            i_data_serial_TB <= '1';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 2
            i_data_serial_TB <= '0';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 3
            i_data_serial_TB <= '1';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 4
            i_data_serial_TB <= '0';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 5
            i_data_serial_TB <= '1';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 6
            i_data_serial_TB <= '0';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            -- Bit 7
            i_data_serial_TB <= '1';
            wait until c_CLK50_PERIOD * c_CLKS_PER_BIT;
            --send Stop Bit: one
            i_data_serial_TB <= '1';
            wait until rising_edge(o_data_DV_TB);
            assert o_parallel_data_TB = "10101010" report " Ascii code /= "10101010" " severity Error;
            wait for c_CLK50_PERIOD;

    end RTL;