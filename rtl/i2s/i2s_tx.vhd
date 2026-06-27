library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--Desired LRCLK = sample rate = 48.1 kHz
--Desired BCLK  = LRCLK × 64 = 3.072 MHz
--Desired MCLK  = LRCLK × 256 = 12.288 MHz

entity i2s_tx is
    generic (
        g_SAMPLE_WIDTH      :   integer         :=24;   --Can be configured by 8, 16, 24 or 32.
        g_HALF_PERIOD_MCLK  :   integer         :=2;    --12.5MHz,   g_HALF_PERIOD_MCLK = Systems clock frequency / (Master clock Frequency * 2)
        g_HALF_PERIOD_BCLK  :   integer         :=8     --3.125MHz,  g_HALF_PERIOD_BCLK = Systems clock frequency / (Bit clock Frequency * 2)
    );
    port (
        i_clk               :   in      STD_LOGIC; --System Clock = 50MHZ
        i_reset             :   in      STD_LOGIC;
        i_sample            :   in      unsigned(g_SAMPLE_WIDTH -1 downto 0);
        o_BCLK              :   out     STD_LOGIC; --3.125MHz Clock
        o_LRCLK             :   out     STD_LOGIC; --48.828KHz Clock
        o_MCLK              :   out     STD_LOGIC; --12.5MHz Clock
        o_DATA              :   out     STD_LOGIC
    );
end i2s_tx;

architecture RTL of i2s_tx is
    signal r_MCLK_counter   :   integer range 0 to g_HALF_PERIOD_MCLK-1 :=0;
    signal r_BCLK_counter   :   integer range 0 to g_HALF_PERIOD_BCLK-1 :=0;
    signal r_bit_counter    :   integer range 0 to 31                   :=0;
    signal r_sample         :   unsigned(31 downto 0)                   :=(others=>'0');

    signal r_MCLK   :   STD_LOGIC   :='0';
    signal r_BCLK   :   STD_LOGIC   :='0';
    signal r_LRCLK  :   STD_LOGIC   :='1';
	signal w_BCLK   :   STD_LOGIC   :='0';
    signal w_reset  :   STD_LOGIC   :='0';

    --If sample width is 32bits, no need for PADDING BITS!
    constant c_PADDING_BITS     :   unsigned(32-g_SAMPLE_WIDTH-1 downto 0)  :=(others=>'0');
    
    begin
        process(i_clk, i_reset) is
            begin
                if rising_edge(i_clk) then
                    w_reset <= i_reset;
                    w_BCLK <= r_BCLK;

                    if i_reset = '0' and w_reset = '1' then --falling edge of the reset button
                        r_MCLK_counter <= 0;
                        r_BCLK_counter <= 0;
                        r_bit_counter <= 0;
                        r_MCLK <= '0';
                        r_BCLK <= '0';
                        r_LRCLK <= '1';
                            
                        w_BCLK <= '0';
                    else

                        --------------------------------------------
                        --Generating Master Clock
                        --------------------------------------------
                        if r_MCLK_counter < g_HALF_PERIOD_MCLK-1 then
                            r_MCLK_counter <= r_MCLK_counter + 1;
                        else
                            r_MCLK_counter <= 0;
                            r_MCLK <= not r_MCLK;
                        end if;

                        ----------------------------------------------
                        --Generating BCLK
                        ----------------------------------------------
                        if r_BCLK_counter < g_HALF_PERIOD_BCLK-1 then
                            r_BCLK_counter <= r_BCLK_counter + 1;
                        else
                            r_BCLK_counter <= 0;
                            r_BCLK <= not r_BCLK;
                        end if;

                        ----------------------------------------------
                        --Transmitting bits in each rising-edge of BCLK
                        -----------------------------------------------
                        if r_BCLK = '1' and w_BCLK = '0' then
                            r_sample<= r_sample(30 downto 0) & '0';  --shift by one;

                            if r_bit_counter < 31 then
                                r_bit_counter <= r_bit_counter + 1;

                            else
                                r_bit_counter <= 0;
                                r_LRCLK <= not r_LRCLK;

                                if g_SAMPLE_WIDTH = 32 then
                                    r_sample <= i_sample;   --If sample width is 32bits, no need for PADDING BITS!
                                else
                                    r_sample <= i_sample & c_PADDING_BITS; --e.g. 24bits sample + 8 bits padding = 32bits 
                                end if;

                            end if;
                        end if;
                    end if;
                end if;
            end process;
            
            o_DATA <= r_sample(31); --send MSB
            o_BCLK <= r_BCLK;
            o_MCLK <= r_MCLK;
            o_LRCLK <= r_LRCLK;

    end RTL;