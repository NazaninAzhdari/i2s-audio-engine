library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RX_decoder is
    port (
        i_clk          :   in      STD_LOGIC;
        i_reset        :   in      STD_LOGIC;
        i_en           :   in      STD_LOGIC; 
        i_ASCII_code   :   in      unsigned(7 downto 0);
        o_key_a        :   out     STD_LOGIC;
        o_key_b        :   out     STD_LOGIC;
        o_key_c        :   out     STD_LOGIC;
        o_key_d        :   out     STD_LOGIC;
        o_key_e        :   out     STD_LOGIC;
        o_key_f        :   out     STD_LOGIC;
        o_key_g        :   out     STD_LOGIC;
        o_key_h        :   out     STD_LOGIC;
        o_key_i        :   out     STD_LOGIC;
        o_key_j        :   out     STD_LOGIC;
        o_key_k        :   out     STD_LOGIC;
        o_key_l        :   out     STD_LOGIC;
        o_key_m        :   out     STD_LOGIC;
        o_key_n        :   out     STD_LOGIC;
        o_key_o        :   out     STD_LOGIC;
        o_key_p        :   out     STD_LOGIC;
        o_key_q        :   out     STD_LOGIC;
        o_key_r        :   out     STD_LOGIC;
        o_key_s        :   out     STD_LOGIC;
        o_key_t        :   out     STD_LOGIC;
        o_key_u        :   out     STD_LOGIC;
        o_key_v        :   out     STD_LOGIC;
        o_key_w        :   out     STD_LOGIC;
        o_key_x        :   out     STD_LOGIC;
        o_key_y        :   out     STD_LOGIC;
        o_key_z        :   out     STD_LOGIC
    );
end RX_decoder;

architecture RTL of RX_decoder is
	signal r_en             : STD_LOGIC                     :='0';
    signal r_key_a_timer    : integer range 0 to 1          :=0;
    signal r_key_b_timer    : integer range 0 to 1          :=0;
    signal r_key_c_timer    : integer range 0 to 1          :=0;
    signal r_key_d_timer    : integer range 0 to 1          :=0;
    signal r_key_e_timer    : integer range 0 to 1          :=0;
    signal r_key_f_timer    : integer range 0 to 1          :=0;
    signal r_key_g_timer    : integer range 0 to 1          :=0;
    signal r_key_h_timer    : integer range 0 to 1          :=0;
    signal r_key_i_timer    : integer range 0 to 1          :=0;
    signal r_key_j_timer    : integer range 0 to 1          :=0;
    signal r_key_k_timer    : integer range 0 to 1          :=0;
    signal r_key_l_timer    : integer range 0 to 1          :=0;
    signal r_key_m_timer    : integer range 0 to 1          :=0;
    signal r_key_n_timer    : integer range 0 to 1          :=0;
    signal r_key_o_timer    : integer range 0 to 1          :=0;
    signal r_key_p_timer    : integer range 0 to 1          :=0;
    signal r_key_q_timer    : integer range 0 to 1          :=0;
    signal r_key_r_timer    : integer range 0 to 1          :=0;
    signal r_key_s_timer    : integer range 0 to 1          :=0;
    signal r_key_t_timer    : integer range 0 to 1          :=0;
    signal r_key_u_timer    : integer range 0 to 1          :=0;
    signal r_key_v_timer    : integer range 0 to 1          :=0;
    signal r_key_w_timer    : integer range 0 to 1          :=0;
    signal r_key_x_timer    : integer range 0 to 1          :=0;
    signal r_key_y_timer    : integer range 0 to 1          :=0;
    signal r_key_z_timer    : integer range 0 to 1          :=0;

    begin
        process(i_clk, i_reset) is
            begin
                if i_reset = '1' then 
                    o_key_a <= '0';
                    o_key_b <= '0';
                    o_key_c <= '0';
                    o_key_d <= '0';
                    o_key_e <= '0';
                    o_key_f <= '0';
                    o_key_g <= '0';
                    o_key_h <= '0';
                    o_key_i <= '0';
                    o_key_g <= '0';
                    o_key_k <= '0';
                    o_key_l <= '0';
                    o_key_m <= '0';
                    o_key_n <= '0';
                    o_key_o <= '0';
                    o_key_p <= '0';
                    o_key_q <= '0';
                    o_key_r <= '0';
                    o_key_s <= '0';
                    o_key_t <= '0';
                    o_key_u <= '0';
                    o_key_v <= '0';
                    o_key_w <= '0';
                    o_key_x <= '0';
                    o_key_y <= '0';
                    o_key_z <= '0';
                    r_key_a_timer <= 0;
                    r_key_b_timer <= 0;
                    r_key_c_timer <= 0;
                    r_key_d_timer <= 0;
                    r_key_e_timer <= 0;
                    r_key_f_timer <= 0;
                    r_key_g_timer <= 0;
                    r_key_h_timer <= 0;
                    r_key_i_timer <= 0;
                    r_key_g_timer <= 0;
                    r_key_k_timer <= 0;
                    r_key_l_timer <= 0;
                    r_key_m_timer <= 0;
                    r_key_n_timer <= 0;
                    r_key_o_timer <= 0;
                    r_key_p_timer <= 0;
                    r_key_q_timer <= 0;
                    r_key_r_timer <= 0;
                    r_key_s_timer <= 0;
                    r_key_t_timer <= 0;
                    r_key_u_timer <= 0;
                    r_key_v_timer <= 0;
                    r_key_w_timer <= 0;
                    r_key_x_timer <= 0;
                    r_key_y_timer <= 0;
                    r_key_z_timer <= 0;
                
                elsif rising_edge(i_clk) then
					r_en <= i_en;

                    if i_en = '1' and r_en = '0' then --by the rising edge of enable signal we can determine that a new byte has been recieved.
                        case i_ASCII_code is
                            ------------------------------------------------------------------------------------------------------------
                            -- each key on the board is corrospond to its ASCII code.
                            -- when one of the keys on the keyboard is pressed, we set the timer of that key to be one!
                            -- In this way, the output key signal goes high for one clock cycle and become low after one clock cycle.
                            ------------------------------------------------------------------------------------------------------------
                            when "01100001" => r_key_a_timer <= 1;
                            when "01100010" => r_key_b_timer <= 1;
                            when "01100011" => r_key_c_timer <= 1;
                            when "01100100" => r_key_d_timer <= 1;
                            when "01100101" => r_key_e_timer <= 1;
                            when "01100110" => r_key_f_timer <= 1;
                            when "01100111" => r_key_g_timer <= 1;
                            when "01101000" => r_key_h_timer <= 1;
                            when "01101001" => r_key_i_timer <= 1;
                            when "01101010" => r_key_j_timer <= 1;
                            when "01101011" => r_key_k_timer <= 1;
                            when "01101100" => r_key_l_timer <= 1;
                            when "01101101" => r_key_m_timer <= 1;
                            when "01101110" => r_key_n_timer <= 1;
                            when "01101111" => r_key_o_timer <= 1;
                            when "01110000" => r_key_p_timer <= 1;
                            when "01110001" => r_key_q_timer <= 1;
                            when "01110010" => r_key_r_timer <= 1;
                            when "01110011" => r_key_s_timer <= 1;
                            when "01110100" => r_key_t_timer <= 1;
                            when "01110101" => r_key_u_timer <= 1;
                            when "01110110" => r_key_v_timer <= 1;
                            when "01110111" => r_key_w_timer <= 1;
                            when "01111000" => r_key_x_timer <= 1;
                            when "01111001" => r_key_y_timer <= 1;
                            when "01111010" => r_key_z_timer <= 1;
                            when others => null;
                        end case;
                    end if; --if i_en='0' and r_en = '1' 

                    -----------------------------------------------------------
                    --Adjusting the buttons to be high or low based on the timer
                    ------------------------------------------------------------
                    if r_key_a_timer > 0 then
                        o_key_a <= '1';
                        r_key_a_timer <= r_key_a_timer - 1;
                    else
                        o_key_a <= '0';
                    end if;

                    if r_key_b_timer > 0 then
                        o_key_b <= '1';
                        r_key_b_timer <= r_key_b_timer - 1;
                    else
                        o_key_b <= '0';
                    end if;

                    if r_key_c_timer > 0 then
                        o_key_c <= '1';
                        r_key_c_timer <= r_key_c_timer - 1;
                    else
                        o_key_c <= '0';
                    end if;

                    if r_key_d_timer > 0 then
                        o_key_d <= '1';
                        r_key_d_timer <= r_key_d_timer - 1;
                    else
                        o_key_d <= '0';
                    end if;

                    if r_key_e_timer > 0 then
                        o_key_e <= '1';
                        r_key_e_timer <= r_key_e_timer - 1;
                    else
                        o_key_e <= '0';
                    end if;

                    if r_key_f_timer > 0 then
                        o_key_f <= '1';
                        r_key_f_timer <= r_key_f_timer - 1;
                    else
                        o_key_f <= '0';
                    end if;

                    if r_key_g_timer > 0 then
                        o_key_g <= '1';
                        r_key_g_timer <= r_key_g_timer - 1;
                    else
                        o_key_g <= '0';
                    end if;

                    if r_key_h_timer > 0 then
                        o_key_h <= '1';
                        r_key_h_timer <= r_key_h_timer - 1;
                    else
                        o_key_h <= '0';
                    end if;

                    if r_key_i_timer > 0 then
                        o_key_i <= '1';
                        r_key_i_timer <= r_key_i_timer - 1;
                    else
                        o_key_i <= '0';
                    end if;

                    if r_key_j_timer > 0 then
                        o_key_j <= '1';
                        r_key_j_timer <= r_key_j_timer - 1;
                    else
                        o_key_j <= '0';
                    end if;

                    if r_key_k_timer > 0 then
                        o_key_k <= '1';
                        r_key_k_timer <= r_key_k_timer - 1;
                    else
                        o_key_k <= '0';
                    end if;

                    if r_key_l_timer > 0 then
                        o_key_l <= '1';
                        r_key_l_timer <= r_key_l_timer - 1;
                    else
                        o_key_l <= '0';
                    end if;

                    if r_key_m_timer > 0 then
                        o_key_m <= '1';
                        r_key_m_timer <= r_key_m_timer - 1;
                    else
                        o_key_m <= '0';
                    end if;

                    if r_key_n_timer > 0 then
                        o_key_n <= '1';
                        r_key_n_timer <= r_key_n_timer - 1;
                    else
                        o_key_n <= '0';
                    end if;

                    if r_key_o_timer > 0 then
                        o_key_o <= '1';
                        r_key_o_timer <= r_key_o_timer - 1;
                    else
                        o_key_o <= '0';
                    end if;

                    if r_key_p_timer > 0 then
                        o_key_p <= '1';
                        r_key_p_timer <= r_key_p_timer - 1;
                    else
                        o_key_p <= '0';
                    end if;

                    if r_key_q_timer > 0 then
                        o_key_q <= '1';
                        r_key_q_timer <= r_key_q_timer - 1;
                    else
                        o_key_q <= '0';
                    end if;

                    if r_key_r_timer > 0 then
                        o_key_r <= '1';
                        r_key_r_timer <= r_key_r_timer - 1;
                    else
                        o_key_r <= '0';
                    end if;

                    if r_key_s_timer > 0 then
                        o_key_s <= '1';
                        r_key_s_timer <= r_key_s_timer - 1;
                    else
                        o_key_s <= '0';
                    end if;

                    if r_key_t_timer > 0 then
                        o_key_t <= '1';
                        r_key_t_timer <= r_key_t_timer - 1;
                    else
                        o_key_t <= '0';
                    end if;

                    if r_key_u_timer > 0 then
                        o_key_u <= '1';
                        r_key_u_timer <= r_key_u_timer - 1;
                    else
                        o_key_u <= '0';
                    end if;

                    if r_key_v_timer > 0 then
                        o_key_v <= '1';
                        r_key_v_timer <= r_key_v_timer - 1;
                    else
                        o_key_v <= '0';
                    end if;

                    if r_key_w_timer > 0 then
                        o_key_w <= '1';
                        r_key_w_timer <= r_key_w_timer - 1;
                    else
                        o_key_w <= '0';
                    end if;

                    if r_key_x_timer > 0 then
                        o_key_x <= '1';
                        r_key_x_timer <= r_key_x_timer - 1;
                    else
                        o_key_x <= '0';
                    end if;

                    if r_key_y_timer > 0 then
                        o_key_y <= '1';
                        r_key_y_timer <= r_key_y_timer - 1;
                    else
                        o_key_y <= '0';
                    end if;

                    if r_key_z_timer > 0 then
                        o_key_z <= '1';
                        r_key_z_timer <= r_key_z_timer - 1;
                    else
                        o_key_z <= '0';
                    end if;

                end if; --if i_reset = '1' or else
            end process;

    end RTL;