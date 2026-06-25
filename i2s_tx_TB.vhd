library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2s_tx_TB is
end i2s_tx_TB;

architecture RTL of i2s_tx_TB is
    constant c_SAMPLE_RESOLUTION_TB :   integer         :=24;   --Can be configured by 8, 16, 24 or 32.
    constant c_HALF_PERIOD_MCLK_TB  :   integer         :=2;    --12.5MHz,   g_HALF_PERIOD_MCLK = Systems clock frequency / (Master clock Frequency * 2)
    constant c_HALF_PERIOD_BCLK_TB  :   integer         :=8;    --3.125MHz,  g_HALF_PERIOD_BCLK = Systems clock frequency / (Bit clock Frequency * 2)
    
    signal i_clk50_TB               :   STD_LOGIC                                       :='0';
    signal i_reset_TB               :   STD_LOGIC                                       :='0';
    signal i_sample_TB              :   unsigned(c_SAMPLE_RESOLUTION_TB -1 downto 0)    :=(others=>'0');
    signal o_BCLK_TB                :   STD_LOGIC; --3.125MHz Clock
    signal o_LRCLK_TB               :   STD_LOGIC; --48.828KHz Clock
    signal o_MCLK_TB                :   STD_LOGIC; --12.5MHz Clock
    signal o_DATA_TB                :   STD_LOGIC;

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
        --Declare UUT: I2S Transmitter
        ----------------------------------
        uut_i2s_transmitter: entity work.i2s_tx
        generic map(
            g_SAMPLE_WIDTH      => c_SAMPLE_RESOLUTION_TB,
            g_HALF_PERIOD_MCLK  => c_HALF_PERIOD_MCLK_TB,
            g_HALF_PERIOD_BCLK  => c_HALF_PERIOD_BCLK_TB
        )
        port map(
            i_clk     => i_clk50_TB,
            i_reset   => i_reset_TB,
            i_sample  => i_sample_TB,
            o_BCLK    => o_BCLK_TB,
            o_LRCLK   => o_LRCLK_TB,
            o_MCLK    => o_MCLK_TB,
            o_DATA    => o_DATA_TB
        );

        sim: process
        begin
            i_reset_TB <= '1';
            wait for c_CLK50_PERIOD;
            i_reset_TB <= '0';
            wait for c_CLK50_TB;

            i_sample_TB <= (others=>'1');
            --MSB of sample, bit 23
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 22
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 21
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 20
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 19
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 18
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 17
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 16
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 15
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 14
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 13
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 12
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 11
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 10
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 9
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 8
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 7
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 6
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 5
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 4
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 3
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 2
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 1
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --LSB of sample, bit 0
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 1
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 2
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 3
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 4
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 5
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 6
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 7
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 8
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            wait until rising_edge(o_LRCLK_TB);


            i_sample_TB <= "101010101010101010101010";
            --MSB of sample, bit 23
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 22
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 21
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 20
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 19
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 18
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 17
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 16
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 15
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 14
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 13
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 12
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 11
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 10
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 9
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 8
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 7
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 6
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 5
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 4
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 3
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 2
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --bit 1
            assert o_DATA_TB = '1' report " Data /= '1' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --LSB of sample, bit 0
            assert o_DATA_TB = '0' report " Data /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 1
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 2
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 3
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 4
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 5
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 6
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 7
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            --padding 8
            assert o_DATA_TB = '0' report " padding /= '0' " severity Error;
            wait until rising-edge(o_BCLK_TB);
            wait until rising_edge(o_LRCLK_TB);

            i_sample_TB <= "111111111111000000000000";
            wait until rising_edge(o_LRCLK_TB);

            i_sample_TB <= "000000000000111111111111";
            wait until rising_edge(o_LRCLK_TB);

            i_sample_TB <= "110011001100110011001100";
            wait until rising_edge(o_LRCLK_TB);

            i_sample_TB <= (others=>'1');
            wait until rising_edge(o_LRCLK_TB);

    end RTL;