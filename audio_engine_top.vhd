library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.melody_pack.ALL;

entity audio_engine_top is
    port (
        --inputs
        i_clk50             :   in      STD_LOGIC;
        i_reset             :   in      STD_LOGIC;
        i_RX_DATA           :   in      STD_LOGIC;
        
        --outputs
        o_MCLK              :   out     STD_LOGIC;
        o_LRCLK             :   out     STD_LOGIC;
        o_BCLK              :   out     STD_LOGIC;
        o_DATA              :   out     STD_LOGIC
    );
end audio_engine_top;

architecture RTL of audio_engine_top is
    signal w_LRCLK              : STD_LOGIC                 :='0';

    --Sample Signals
    type t_24bit_sample is array (0 to 25) of unsigned(23 downto 0);
    signal w_samples            : t_24bit_sample            :=(others=>(others=>'0'));
	signal r_sample             : unsigned(23 downto 0)     :=(others=>'0');
    signal w_DV                 : unsigned(25 downto 0)     :=(others=>'0');
    signal r_en_switch          : unsigned(25 downto 0)     :=(others=>'0');
    --UART Reciever signals
    signal r_sync1              :   STD_LOGIC               :='0';
    signal r_sync2              :   STD_LOGIC               :='0';
    signal w_RX_parallel_data   :   unsigned(7 downto 0)    :=(others=>'0');
    signal w_RX_DV              :   STD_LOGIC               :='0';
	 
    begin 
        ----------------------------------------------------------------------------------------------
        --Synching the incoming data with clock, then send it to the UART Reciever.
        --The keyboard input is asynchronous with the FPGA clock.
        --If we dont synch the input data with clock, and send it to Reciever module asynchronously,
        --the reciever might detect some of the inputs and might miss some others.
        --To avoid this problem we pass the incoming data through two flip-flops to sync it with clock
        --Using two flip-flops is more than enough to sync the asynchronous input with clock.
        -----------------------------------------------------------------------------------------------
        synch_the_RX_data: process(i_clk50) is
            begin
                if rising_edge(i_clk50) then
                    r_sync1 <= i_RX_data;
                    r_sync2 <= r_sync1;
                end if;
            end process;

        ----------------------------------------
        --UART - RX for communication 
        ----------------------------------------
        UART: entity work.UART_RX
        generic map(
            g_BITS_LIMIT => 8,
            g_CLKS_PER_BIT => 434   
        )
        port map(
            i_clk => i_clk50,
            i_data_serial => r_sync2, 
            o_data_parallel => w_RX_parallel_data, 
            o_data_DV => w_RX_DV 
        );
		  
        -----------------------------------------
        --RX decoder
        -----------------------------------------
        RX_decoder: entity work.RX_decoder
        port map(
            i_clk => i_clk50,
            i_reset => not i_reset,
            i_en => w_RX_DV,
            i_ASCII_code => w_RX_parallel_data,
            o_key_a => r_en_switch(0),
            o_key_b => r_en_switch(1),
            o_key_c => r_en_switch(2),
            o_key_d => r_en_switch(3),
            o_key_e => r_en_switch(4),
            o_key_f => r_en_switch(5),
            o_key_g => r_en_switch(6),
            o_key_h => r_en_switch(7),
            o_key_i => r_en_switch(8),
            o_key_j => r_en_switch(9),
            o_key_k => r_en_switch(10),
            o_key_l => r_en_switch(11),
            o_key_m => r_en_switch(12),
            o_key_n => r_en_switch(13),
            o_key_o => r_en_switch(14),
            o_key_p => r_en_switch(15),
            o_key_q => r_en_switch(16),
            o_key_r => r_en_switch(17),
            o_key_s => r_en_switch(18),
            o_key_t => r_en_switch(19),
            o_key_u => r_en_switch(20),
            o_key_v => r_en_switch(21),
            o_key_w => r_en_switch(22),
            o_key_x => r_en_switch(23),
            o_key_y => r_en_switch(24),
            o_key_z => r_en_switch(25)
        );

        -------------------------------------------
        --Generating Melodies
        --------------------------------------------
        -- information about these melodies is in melody_pack.vhd
        Melody_0_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_0,     
            g_TONE_LIMIT => c_TONE_LIMIT_0,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_0                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(0),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(0),
            o_sample_DV => w_DV(0)
        );

        Melody_1_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_1,     
            g_TONE_LIMIT => c_TONE_LIMIT_1,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_1                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(1),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(1),
            o_sample_DV => w_DV(1)
        );

        Melody_2_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_2,     
            g_TONE_LIMIT => c_TONE_LIMIT_2,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_2                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(2),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(2),
            o_sample_DV => w_DV(2)
        );

        Melody_3_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_3,     
            g_TONE_LIMIT => c_TONE_LIMIT_3,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_3                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(3),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(3),
            o_sample_DV => w_DV(3)
        );

        Melody_4_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_4,     
            g_TONE_LIMIT => c_TONE_LIMIT_4,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_4                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(4),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(4),
            o_sample_DV => w_DV(4)
        );

        Melody_5_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_5,     
            g_TONE_LIMIT => c_TONE_LIMIT_5,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_5                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(5),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(5),
            o_sample_DV => w_DV(5)
        );

        Melody_6_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_6,     
            g_TONE_LIMIT => c_TONE_LIMIT_6,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_6                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(6),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(6),
            o_sample_DV => w_DV(6)
        );

        Melody_7_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_7,     
            g_TONE_LIMIT => c_TONE_LIMIT_7,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_7                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(7),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(7),
            o_sample_DV => w_DV(7)
        );

        Melody_8_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_8,     
            g_TONE_LIMIT => c_TONE_LIMIT_8,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_8                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(8),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(8),
            o_sample_DV => w_DV(8)
        );

        Melody_9_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_9,     
            g_TONE_LIMIT => c_TONE_LIMIT_9,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_9                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(9),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(9),
            o_sample_DV => w_DV(9)
        );

        Melody_10_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_10,     
            g_TONE_LIMIT => c_TONE_LIMIT_10,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_10                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(10),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(10),
            o_sample_DV => w_DV(10)
        );

        Melody_11_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_11,     
            g_TONE_LIMIT => c_TONE_LIMIT_11,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_11                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(11),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(11),
            o_sample_DV => w_DV(11)
        );

        Melody_12_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_12,     
            g_TONE_LIMIT => c_TONE_LIMIT_12,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_12                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(12),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(12),
            o_sample_DV => w_DV(12)
        );

        Melody_13_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_13,     
            g_TONE_LIMIT => c_TONE_LIMIT_13,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_13                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(13),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(13),
            o_sample_DV => w_DV(13)
        );

        Melody_14_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_14,     
            g_TONE_LIMIT => c_TONE_LIMIT_14,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_14                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(14),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(14),
            o_sample_DV => w_DV(14)
        );

        Melody_15_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_15,     
            g_TONE_LIMIT => c_TONE_LIMIT_15,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_15                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(15),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(15),
            o_sample_DV => w_DV(15)
        );

        Melody_16_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_16,     
            g_TONE_LIMIT => c_TONE_LIMIT_16,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_16                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(16),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(16),
            o_sample_DV => w_DV(16)
        );

        Melody_17_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_17,     
            g_TONE_LIMIT => c_TONE_LIMIT_17,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_17                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(17),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(17),
            o_sample_DV => w_DV(17)
        );

        Melody_18_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_18,     
            g_TONE_LIMIT => c_TONE_LIMIT_18,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_18                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(18),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(18),
            o_sample_DV => w_DV(18)
        );

        Melody_19_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_19,     
            g_TONE_LIMIT => c_TONE_LIMIT_19,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_19                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(19),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(19),
            o_sample_DV => w_DV(19)
        );

        Melody_20_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_20,     
            g_TONE_LIMIT => c_TONE_LIMIT_20,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_20                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(20),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(20),
            o_sample_DV => w_DV(20)
        );

        Melody_21_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_21,     
            g_TONE_LIMIT => c_TONE_LIMIT_21,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_21                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(21),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(21),
            o_sample_DV => w_DV(21)
        );

        Melody_22_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_22,     
            g_TONE_LIMIT => c_TONE_LIMIT_22,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_22                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(22),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(22),
            o_sample_DV => w_DV(22)
        );

        Melody_23_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_23,     
            g_TONE_LIMIT => c_TONE_LIMIT_23,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_23                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(23),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(23),
            o_sample_DV => w_DV(23)
        );

        Melody_24_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_24,     
            g_TONE_LIMIT => c_TONE_LIMIT_24,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_24                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(24),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(24),
            o_sample_DV => w_DV(24)
        );

        Melody_25_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_MELODY_25,     
            g_TONE_LIMIT => c_TONE_LIMIT_25,                  
            g_DURATION_LIMIT => c_DURATION_LIMIT_25                
        )
        port map(
            i_clk => i_clk50,
            i_en => r_en_switch(25),
            i_LRCLK => w_LRCLK,
            o_sample => w_samples(25),
            o_sample_DV => w_DV(25)
        );


		--------------------------------------------
        --Transmitting the generated samples to DAC
        --------------------------------------------
        i2s_transmitter: entity work.i2s_tx
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_MCLK => 2,  --12.5MHz 
            g_HALF_PERIOD_BCLK => 8   --3.125MHz
        )
        port map(
            i_clk => i_clk50,
            i_reset => not i_reset,
            i_sample => r_sample,
            o_BCLK => o_BCLK,
            o_LRCLK => w_LRCLK,
            o_MCLK => o_MCLK,
            o_DATA => o_DATA
        );

        --------------------------------------------------------
        --Determine which sample should go to the I2s-Tx module
        --------------------------------------------------------
        process(w_DV, w_samples) is
            begin
                case W_DV is
                    when "00000000000000000000000001" => r_sample <= w_samples(0);
                    when "00000000000000000000000010" => r_sample <= w_samples(1);
                    when "00000000000000000000000100" => r_sample <= w_samples(2);
                    when "00000000000000000000001000" => r_sample <= w_samples(3);
                    when "00000000000000000000010000" => r_sample <= w_samples(4);
                    when "00000000000000000000100000" => r_sample <= w_samples(5);
                    when "00000000000000000001000000" => r_sample <= w_samples(6);
                    when "00000000000000000010000000" => r_sample <= w_samples(7);
                    when "00000000000000000100000000" => r_sample <= w_samples(8);
                    when "00000000000000001000000000" => r_sample <= w_samples(9);
                    when "00000000000000010000000000" => r_sample <= w_samples(10);
                    when "00000000000000100000000000" => r_sample <= w_samples(11);
                    when "00000000000001000000000000" => r_sample <= w_samples(12);
                    when "00000000000010000000000000" => r_sample <= w_samples(13);
                    when "00000000000100000000000000" => r_sample <= w_samples(14);
                    when "00000000001000000000000000" => r_sample <= w_samples(15);
                    when "00000000010000000000000000" => r_sample <= w_samples(16);
                    when "00000000100000000000000000" => r_sample <= w_samples(17);
                    when "00000001000000000000000000" => r_sample <= w_samples(18);
                    when "00000010000000000000000000" => r_sample <= w_samples(19);
                    when "00000100000000000000000000" => r_sample <= w_samples(20);
                    when "00001000000000000000000000" => r_sample <= w_samples(21);
                    when "00010000000000000000000000" => r_sample <= w_samples(22);
                    when "00100000000000000000000000" => r_sample <= w_samples(23);
                    when "01000000000000000000000000" => r_sample <= w_samples(24);
                    when "10000000000000000000000000" => r_sample <= w_samples(25);
                    when others => r_sample <= (others=>'0');
                end case;
        end process;

        o_LRCLK <= w_LRCLK;

    end RTL;