package melody_pack is
    --------------------------------------------------------
    --A flexible size array to store the melody tones
    --------------------------------------------------------
    type pt_tone_array is array (natural range <>) of integer;

    --------------------------------------------------
    -- 32‑Tone Police (Up–Down Sweep Loop)
    --------------------------------------------------
    -- Frequencies (Hz)
    -- 400 → 450 → 500 → 550 → 600 → 650 → 700 → 750 →
    -- 800 → 850 → 900 → 950 → 1000 → 950 → 900 → 850 →
    -- 800 → 750 → 700 → 650 → 600 → 550 → 500 → 450 →
    -- 400 → 350 → 300 → 350 → 400 → 450 → 500 → 550
    -- Number of Tones :  "32"
    -- Duration per tone: ~62 ms, corrospond to "3000" clocks (with 48KHz clock)
    -- Half period frequencies:
    constant c_police     :   pt_tone_array   
    :=(
        60,53,48,44,40,37,34,32,
        30,28,26,25,24,25,26,28,
        30,32,34,37,40,44,48,53,
        60,68,80,68,60,53,48,44
    );

    -----------------------------------------------
    -- 24‑Tone Ambulance 
    -----------------------------------------------
    -- Frequencies (Hz)
    -- 900 ↔ 1200 (hi‑lo) repeated
    -- then
    -- 300 → 400 → 500 → 600 → 700 → 800 → 900 → 800 → 700 → 600 → 500 → 400 → 300
    -- Number of Tones :  "24"
    -- Duration per tone: ~104 ms, corrospond to "5000" clocks (with 48KHz clock)
    constant c_ambulance     :   pt_tone_array   
    :=(
        26,20,26,20,26,20,26,20,   -- hi-lo ambulance
        80,60,48,40,34,30,26,30,34,40,48,60,80,60  -- sweep down-up-down
    );

    -----------------------------------------------
    -- Bird‑Like 
    -----------------------------------------------
    -- Number of Tones :  "32"
    -- Duration per tone: ~31 ms, corrospond to "1500" clocks (with 48KHz clock)
    constant c_bird     :   pt_tone_array   
    :=(
        40,32,28,24,20,24,28,32,
        40,48,56,48,40,32,28,24,
        20,18,20,24,28,32,36,40,
        48,40,32,28,24,20,18,20
    );

    -----------------------
    -- Frog-likee
    -----------------------
    -- Number of Tones :  "24"
    -- Duration per tone: ~104 ms, corrospond to "5000" clocks (with 48KHz clock)
    constant c_frog     :   pt_tone_array   
    :=(
        120,110,100,90,100,110,120,140,
        120,110,100,90,80,90,100,110,
        140,160,140,120,100,90,100,110
    );

    -------------------------
    -- Elephant‑Like 
    -------------------------
    -- Number of Tones :  "36"
    -- Duration per tone: ~145 ms, corrospond to "7000" clocks (with 48KHz clock)
    constant c_frog     :   pt_tone_array   
    :=(
        160,150,140,130,120,110,100,90,80,
        70,60,50,40,35,30,28,30,35,
        40,50,60,70,80,90,100,110,120,
        130,140,150,160,180,200,180,160,140
    );

    -------------------------------
    -- Robot Talking
    -------------------------------
    -- Number of Tones :  "28"
    -- Duration per tone: ~41 ms, corrospond to "2000" clocks (with 48KHz clock)
    constant c_robat_talking     :   pt_tone_array   
    :=(
        30,24,20,24,30,36,42,36,
        30,24,20,18,20,24,30,36,
        42,36,30,24,20,18,20,24,
        30,36,42,48
    );

    ------------------------------
    -- Retro Start Game Sound
    ------------------------------
    -- Number of Tones :  "32"
    -- Duration per tone: ~41 ms, corrospond to "2000" clocks (with 48KHz clock)
    constant c_retro_start     :   pt_tone_array   
    :=(
        40,36,32,30,27,24,22,20,
        22,24,27,30,32,36,40,45,
        40,36,32,30,27,24,22,20,
        18,20,22,24,27,30,32,36
    );

    -------------------------------
    -- Classic arcade menu vibe
    -------------------------------
    -- Number of Tones :  "28"
    -- Duration per tone: ~31 ms, corrospond to "1500" clocks (with 48KHz clock)
    constant c_retro_menu     :   pt_tone_array   
    :=(
        30,24,20,18,20,24,30,
        36,30,24,20,18,20,24,
        30,36,40,36,30,24,20,
        18,20,24,30,36,40,45
    );

    ------------------------------------------------------
    --20‑Tone Alarm (Harsh, Mechanical)
    ------------------------------------------------------
    -- Frequencies (Hz)
    -- 1000 → 300 → 1000 → 300 → 800 → 400 → 800 → 400 →
    -- 1200 → 600 → 1200 → 600 → 1500 → 700 → 1500 → 700 →
    -- 900 → 450 → 900 → 450
    -- Number of Tones :  "20"
    -- Duration per tone: ~83 ms, corrospond to "4000" clocks (with 48KHz clock)
    constant c_harsh_alarm     :   pt_tone_array   
    :=(
        24,80,24,80,30,60,30,60,
        20,40,20,40,16,34,16,34,
        26,53,26,53
    );

    -------------------------------------------
    -- 32‑Tone Alarm (wired)
    -------------------------------------------
    -- Frequencies
    -- 1500 → 900 → 1200 → 700 → 1000 → 600 → 800 → 500 →
    -- 1500 → 900 → 1200 → 700 → 1000 → 600 → 800 → 500 →
    -- 300 → 400 → 500 → 600 → 700 → 800 → 900 → 1000 →
    -- 1200 → 1000 → 900 → 800 → 700 → 600 → 500 → 400
    -- Number of Tones :  "32"
    -- Duration per tone: ~41 ms, corrospond to "2000" clocks (with 48KHz clock)
    constant c_wired_alarm     :   pt_tone_array   
    :=(
        16,26,20,34,24,40,30,48,
        16,26,20,34,24,40,30,48,
        80,60,48,40,34,30,26,24,
        20,24,26,30,34,40,48,60
    );

    ---------------------------
    -- 28‑Tone Horror Siren
    ---------------------------
    -- Frequencies
    -- 200 → 250 → 300 → 350 → 400 → 350 → 300 → 250 →
    -- 500 → 450 → 400 → 350 → 300 → 250 →
    -- 700 → 600 → 500 → 400 → 300 → 200 →
    -- 900 → 800 → 700 → 600 → 500 → 400 → 300 → 200
    -- Number of Tones :  "28"
    -- Duration per tone: ~125 ms, corrospond to "6000" clocks (with 48KHz clock)
    constant c_horror_siren     :   pt_tone_array   
    :=(
        120,96,80,68,60,68,80,96,
        48,53,60,68,80,96,
        34,40,48,60,80,120,
        26,30,34,40,48,60,80,120
    );

    ------------------------------------------------------
    -- 36‑Tone Robotic (Mechanical, Rhythmic)
    ------------------------------------------------------
    -- Frequencies (Hz)
    -- 1000 → 500 → 1000 → 500 →
    -- 800 → 400 → 800 → 400 →
    -- 1200 → 600 → 1200 → 600 →
    -- 1500 → 700 → 1500 → 700 →
    -- 900 → 450 → 900 → 450 →
    -- 700 → 350 → 700 → 350 →
    -- 600 → 300 → 600 → 300 →
    -- 500 → 250 → 500 → 250
    -- Number of Tones :  "36"
    -- Duration per tone: ~62 ms, corrospond to "3000" clocks (with 48KHz clock)
    constant c_robatic     :   pt_tone_array   
    :=(
        24,48,24,48,
        30,60,30,60,
        20,40,20,40,
        16,34,16,34,
        26,53,26,53,
        34,68,34,68,
        40,80,40,80,
        48,96,48,96
    );

    ---------------
    --Rising  
    ---------------
    -- Number of Tones :  "48"
    -- Duration per tone: ~83 ms, corrospond to "4000" clocks (with 48KHz clock)
    constant c_rising     :   pt_tone_array   
    :=(
        120,110,100,90,80,72,68,64,
        60,56,52,48,44,40,36,32,
        30,28,26,24,22,20,18,16,
        18,20,22,24,26,28,30,32,
        36,40,44,48,52,56,60,64,
        72,80,90,100,110,120,140,160
    );


    -----------------------------------------------
    -- Expanding - Contracting , like scanner
    -----------------------------------------------
    -- Number of Tones :  "36"
    -- Duration per tone: ~52 ms, corrospond to "2500" clocks (with 48KHz clock)
    constant c_rising     :   pt_tone_array   
    :=(
        16,18,20,22,24,26,28,30,32,
        34,36,38,40,42,44,46,48,50,
        48,46,44,42,40,38,36,34,32,
        30,28,26,24,22,20,18,16,14
    );

    -----------------------------------------------
    -- Starts slow, becomes unstable, ends chaotic
    -----------------------------------------------
    -- Number of Tones :  "40"
    -- Duration per tone: ~62 ms, corrospond to "3000" clocks (with 48KHz clock)
    constant c_panic     :   pt_tone_array   
    :=(
        80,78,76,74,72,70,68,66,64,62,
        60,58,56,54,52,50,48,46,44,42,
        40,38,36,34,32,30,28,26,24,22,
        20,22,24,26,28,30,32,34,36,38
    );




end package;