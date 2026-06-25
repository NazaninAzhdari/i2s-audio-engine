library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.melody_pack.ALL;

entity audio_engine_top is
    port (
        --inputs
        i_clk50             :   in      STD_LOGIC;
        --i_reset             :   in      STD_LOGIC;
        i_en_switch         :   in      unsigned(3 downto 0);
        
        --outputs
        o_MCLK              :   out     STD_LOGIC;
        o_LRCLK             :   out     STD_LOGIC;
        o_BCLK              :   out     STD_LOGIC;
        o_DATA              :   out     STD_LOGIC
    );
end audio_engine_top;

architecture RTL of audio_engine_top is
    signal w_LRCLK              : STD_LOGIC              :='0';

    --Sample Signals
	signal r_sample             : unsigned(23 downto 0)  :=(others=>'0');
    signal w_police_sample      : unsigned(23 downto 0)  :=(others=>'0');
	signal w_ambulance_sample   : unsigned(23 downto 0)  :=(others=>'0');
    signal w_bird_sample        : unsigned(23 downto 0)  :=(others=>'0');
	signal w_frog_sample        : unsigned(23 downto 0)  :=(others=>'0');
    --signal w_elephant_sample    : unsigned(23 downto 0)  :=(others=>'0');
	--signal w_robat_sample       : unsigned(23 downto 0)  :=(others=>'0');

	--Data Valid signals
    signal w_police_DV          : STD_LOGIC              :='0';
    signal w_ambulance_DV       : STD_LOGIC              :='0';
    signal w_bird_DV            : STD_LOGIC              :='0';
    signal w_frog_DV            : STD_LOGIC              :='0';
    --signal w_elephant_DV        : STD_LOGIC              :='0';
    --signal w_robat_DV           : STD_LOGIC              :='0';
	 
    begin 

        -------------------------------------------
        --Generating Police sound
        --------------------------------------------
        -- information about this melody is in melody_pack.vhd
        police_melody_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_POLICE,     
            g_TONE_LIMIT => 32,                  
            g_DURATION_LIMIT => 3000                
        )
        port map(
            i_clk => i_clk50,
            i_en => i_en_switch(0),
            i_LRCLK => w_LRCLK,
            o_sample => w_police_sample,
            o_sample_DV => w_police_DV
        );

        -------------------------------------------
        --Generating Ambulance sound
        --------------------------------------------
        -- information about this melody is in melody_pack.vhd
        ambulance_melody_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_AMBULANCE,     
            g_TONE_LIMIT => 24,                  
            g_DURATION_LIMIT => 5000                
        )
        port map(
            i_clk => i_clk50,
            i_en => i_en_switch(1),
            i_LRCLK => w_LRCLK,
            o_sample => w_ambulance_sample,
            o_sample_DV => w_ambulance_DV
        );

        -------------------------------------------
        --Generating Bird sound
        --------------------------------------------
        -- information about this melody is in melody_pack.vhd
        bird_melody_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_BIRD,     
            g_TONE_LIMIT => 32,                  
            g_DURATION_LIMIT => 1500                
        )
        port map(
            i_clk => i_clk50,
            i_en => i_en_switch(2),
            i_LRCLK => w_LRCLK,
            o_sample => w_bird_sample,
            o_sample_DV => w_bird_DV
        );

        -------------------------------------------
        --Generating Frog sound
        --------------------------------------------
        -- information about this melody is in melody_pack.vhd
        frog_melody_generator: entity work.melody_gen
        generic map(
            g_SAMPLE_WIDTH => 24,
            g_HALF_PERIOD_TONE => c_FROG,     
            g_TONE_LIMIT => 24,                  
            g_DURATION_LIMIT => 5000                
        )
        port map(
            i_clk => i_clk50,
            i_en => i_en_switch(3),
            i_LRCLK => w_LRCLK,
            o_sample => w_frog_sample,
            o_sample_DV => w_frog_DV
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
            i_reset => '0',
            i_sample => r_sample,
            o_BCLK => o_BCLK,
            o_LRCLK => w_LRCLK,
            o_MCLK => o_MCLK,
            o_DATA => o_DATA
        );

        --------------------------------------------------------
        --Determine which sample should go to the I2s-Tx module
        --------------------------------------------------------
        r_sample <= w_police_sample     when w_police_DV = '1' else
                    w_ambulance_sample  when w_ambulance_DV = '1' else
					w_bird_sample       when w_bird_DV = '1' else
                    w_frog_sample       when w_frog_DV = '1' else
					(others=>'0');

        o_LRCLK <= w_LRCLK;

    end RTL;