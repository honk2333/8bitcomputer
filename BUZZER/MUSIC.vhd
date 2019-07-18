library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity MUSIC is
port(clk:in std_logic;
start1,start2,start3,start4:in std_logic;
music_r,led1,led2,led3,led4:out std_logic
);
end MUSIC;
 
architecture rt1 of MUSIC is
signal counter6MHz,counter4Hz,counter6MHz2,counter4Hz2,count,origin,count2,origin2:integer range 0 to 200000000;
signal test,music_r_fre,music_r_fre2,clk_6MHz,clk_4Hz,clk_6MHz2,clk_4Hz2:std_logic;
signal i,a:std_logic_vector(11 downto 0);
signal j,b:std_logic_vector(4 downto 0);
signal len,c:integer range 0 to 175;
 
begin
process(start1)
begin
if start1 = '1' then
  test  <= music_r_fre;
  led1 <= '0';
  led2 <= '1';
else
  led1 <= '1';
  test <= music_r_fre2;
  led2 <= '0';
end if;
end process;
 
 
process(start1,music_r_fre)
begin
if start1 = '1' then
  music_r <= test;
  led1 <= '0';
else
  music_r <= '1';
  led1 <= '1';
end if;
end process;
 
 
process(start2,music_r_fre)
begin
if start2 = '1' then
  led3 <= test;
else
  led3 <= '1';
end if;
end process;

process(start3,music_r_fre2)
begin
if start3 = '1' then
music_r <= test;
led2 <= '0';
else
  led2 <= '1';
end if;
end process;
 
 
process(start4,music_r_fre2)
begin
if start4 = '1' then
  led4 <= test;
else
  led4 <= '1';
end if;
end process;
 
 

 
process(clk)
begin
if (clk'event and clk = '1') then
  if counter6MHz = 4 then
  counter6MHz <= 0;
  clk_6MHz <= not clk_6MHz;
  else
  counter6MHz <= counter6MHz + 1;
  end if;
end if;
end process;
 
process(clk)
begin
if (clk'event and clk = '1') then
  if counter4Hz = 4250000 then
  counter4Hz <= 0;
  clk_4Hz <= not clk_4Hz;
  else
  counter4Hz <= counter4Hz + 1;
  end if;
end if;
end process;
 
process(clk)
begin
if (clk'event and clk = '1') then
  if (count = 16383) then
  count <= origin;
  music_r_fre <= not music_r_fre;
  else
  count <= count + 1;
  end if;
end if;
end process;

 
process(start3,music_r_fre2)
begin
if start3 = '1' then
  led2 <= music_r_fre2;
else
  led2 <= '1';
end if;
end process;
 
process(start4,music_r_fre2)
begin
if start4 = '1' then
  led4 <= music_r_fre2;
else
  led4 <= '1';
end if;
end process;
 
 
process(clk)
begin
if clk'event and clk = '1' then
  if counter6MHz2 = 4 then
  counter6MHz2 <= 0;
  clk_6MHz2 <= not clk_6MHz2;
  else
  counter6MHz2 <= counter6MHz2 + 1;
  end if;
end if;
end process;
 
process(clk)
begin
if clk'event and clk = '1' then
  if counter4Hz2 = 4250000 then
  counter4Hz2 <= 0;
  clk_4Hz2 <= not clk_4Hz2;
  else
  counter4Hz2 <= counter4Hz2 + 1;
  end if;
end if;
end process;
 
process(clk)
begin
if clk'event and clk = '1' then
  if count2 = 16383 then
  count2 <= origin2;
  music_r_fre2 <= not music_r_fre2;
  else
  count2 <= count2 + 1;
  end if;
end if;
end process;

 
process(clk_4Hz)
begin
if clk_4Hz'event and clk_4Hz = '1' then
  case (a) is
  when  "000000010000" => origin2 <= 010647 ; -- //middle
 when  "000000100000" => origin2 <= 011272 ;
 when  "000000110000" => origin2 <= 011831 ;
 when  "000001000000" => origin2 <= 012087 ;
 when  "000001010000" => origin2 <= 012556 ;
 when  "000001100000" => origin2 <= 012974 ;
 when  "000001110000" => origin2 <= 013346 ;
 when  "000000000001" => origin2 <= 4916 ; --//low
 when  "000000000010" => origin2 <= 6168 ;
 when  "000000000011" => origin2 <= 7281 ;
 when  "000000000100" => origin2 <= 7791 ;
 when  "000000000101" => origin2 <= 8730 ;
  when  "000000000110" => origin2 <= 9565 ;
 when  "000000000111" => origin2 <= 10310 ;
 when  "000100000000" => origin2 <= 13516 ; --//high
 when  "001000000000" => origin2 <= 13829 ;
 when  "001100000000" => origin2 <= 14108 ;
 when  "010000000000" => origin2 <= 11535 ;
 when  "010100000000" => origin2 <= 14470 ;
 when  "011000000000" => origin2 <= 14678 ;
 when  "011100000000" => origin2 <= 14864 ;
  when  "000000000000" => origin2 <= 16383 ;
 when  others   => origin2 <= 011111;
  end case ;
end if ;
end process ;
 
 
process (clk_4Hz) is
begin
if clk_4Hz'event and clk_4Hz = '1' then
  case (b) is
  when "00001" => a <= "000000000001" ; --//low
 when "00010" => a <= "000000000010" ;
 when "00011" => a <= "000000000011" ;
 when "00100" => a <= "000000000100" ;
 when "00101" => a <= "000000000101" ;
 when "00110" => a <= "000000000110" ;
 when "00111" => a <= "000000000111" ;
 when "01000" => a <= "000000010000" ; --//middle
 when "01001" => a <= "000000100000" ;
 when "01010" => a <= "000000110000" ;
 when "01011" => a <= "000001000000" ;
 when "01100" => a <= "000001010000" ;
 when "01101" => a <= "000001100000" ;
 when "01110" => a <= "000001110000" ;
 when "01111" => a <= "000100000000" ; --//high
 when "10000" => a <= "001000000000" ;
 when "10001" => a <= "001100000000" ;
 when "10010" => a <= "010000000000" ;
 when "10011" => a <= "010100000000" ;
 when "10100" => a <= "011000000000" ;
 when "10101" => a <= "011100000000" ;
  when "00000" => a <= "000000000000" ;
  when others => NULL ;
  end case ;
end if ;
end process ;
 
process (clk_4Hz) is
begin
  if clk_4Hz'event and clk_4Hz = '1' then 
  if (c = 115 ) then
    c <= 0 ;
  else
    c <= c + 1 ;
  case (c) is
  when 0 => b <= "00011" ;
  when 1 => b <= "00011" ;   -- 3
  when 2 => b <= "00011" ;
  when 3 => b <= "00000" ; 
  when 4 => b <= "00010" ; --2
  when 5 => b <= "00010" ;
  when 6 => b <= "00000" ;   
  when 7 => b <= "00011" ; --3
  when 8 => b <= "00011" ;
  when 9 => b <= "00011" ;
  when 10 => b <= "00011" ;
  when 11 => b <= "00000" ;
  when 12 => b <= "00011" ;
  when 13 => b <= "00011" ;
  when 14 => b <= "00000" ;
  when 15 => b <= "00010" ;
  when 16 => b <= "00010" ;
  when 17 => b <= "00000" ;
  when 18 => b <= "00001" ; --1--
  when 19 => b <= "00001" ;
  when 20 => b <= "00001" ;
  when 21 => b <= "00001" ;
  when 22 => b <= "00001" ;
  when 23 => b <= "00001" ;
  when 24 => b <= "00000" ;
  when 25 => b <= "00110" ;   -- 6
  when 26 => b <= "00110" ;
  when 27 => b <= "00000" ; 
  when 28 => b <= "00001" ;
  when 29 => b <= "00001" ;   
  when 30 => b <= "00000" ;   -- 0
  when 31 => b <= "00010" ;   -- 2
  when 32 => b <= "00010" ;
  when 33 => b <= "00010" ; 
  when 34 => b <= "00010" ;  
  when 35 => b <= "00000" ;   -- 0
  when 36 => b <= "00010" ;   -- 2 3
  when 37 => b <= "00010" ;
  when 38 => b <= "00000" ; 
  when 39 => b <= "00011" ;
  when 40 => b <= "00011" ;  
  when 41 => b <= "00000" ;   -- 0
  when 42 => b <= "00010" ;   -- 2 1
  when 43 => b <= "00010" ;
  when 44 => b <= "00000" ; 
  when 45 => b <= "00001" ;
  when 46 => b <= "00001" ;  
  when 47 => b <= "00000" ;  -- 0
  when 48 => b <= "00110" ;   -- 6 1
  when 49 => b <= "00110" ;
  when 50 => b <= "00000" ; 
  when 51 => b <= "00001" ;
  when 52 => b <= "00001" ;  
  when 53 => b <= "00000" ;  -- 0
  when 54 => b <= "00101" ;   -- 5
  when 55 => b <= "00101" ;
  when 56 => b <= "00101" ; 
  when 57 => b <= "00101" ;
  when 58 => b <= "00101" ; 
  when 59 => b <= "00101" ;  
  when 60 => b <= "00101" ;
  when 61 => b <= "00101" ;  
  when 62 => b <= "00000" ;   -- 0
  when 63 => b <= "00011" ;   -- 5
  when 64 => b <= "00011" ;
  when 65 => b <= "00000" ;   -- 0
  when 66 => b <= "00011" ;   -- 3
  when 67 => b <= "00011" ;
  when 68 => b <= "00010" ; --2
  when 69 => b <= "00010" ;
  when 70 => b <= "00000" ;   
  when 71 => b <= "00011" ; --3
  when 72 => b <= "00011" ;
  when 73 => b <= "00011" ;
  when 74 => b <= "00011" ;
  when 75 => b <= "00000" ; 
  when 76 => b <= "00011" ;
  when 77 => b <= "00011" ;
  when 78 => b <= "00000" ;
  when 79 => b <= "00010" ;
  when 80 => b <= "00010" ;
  when 81 => b <= "00000" ;
  when 82 => b <= "00001" ; --1--
  when 83 => b <= "00001" ;
  when 84 => b <= "00001" ;
  when 85 => b <= "00001" ;
  when 86 => b <= "00001" ;
  when 87 => b <= "00001" ;
  when 88 => b <= "00000" ;
  when 89 => b <= "00110" ;   -- 6
  when 90 => b <= "00110" ;
  when 91 => b <= "00000" ; 
  when 92 => b <= "00001" ;
  when 93 => b <= "00001" ;   
  when 94 => b <= "00000" ;   -- 0
  when 95 => b <= "00010" ;   -- 2
  when 96 => b <= "00010" ;
  when 97 => b <= "00010" ; 
  when 98 => b <= "00010" ;  
  when 99 => b <= "00000" ;   -- 0
  when 100 => b <= "00010" ;   -- 2 3
  when 101 => b <= "00010" ;
  when 102 => b <= "00000" ; 
  when 103 => b <= "00011" ;
  when 104 => b <= "00011" ;  
  when 105 => b <= "00000" ;   -- 0
  when 106 => b <= "00010" ;   -- 2 
  when 107 => b <= "00010" ;
  when 108 => b <= "00000" ; 
  when 109 => b <= "00001" ;
  when 110 => b <= "00001" ;  
  when 111 => b <= "00000" ;   -- 0
  when 112 => b <= "00110" ;   -- 6 1
  when 113 => b <= "00110" ;  
  when 114 => b <= "00000" ;  -- 0
 
 
  when 115 => b <= "00001" ;
  when 116 => b <= "00001" ;  
  when 117 => b <= "00000" ;   -- 0
  when 118 => b <= "00011" ;   -- 5
  when 119 => b <= "00011" ;
  when 120 => b <= "00000" ;   -- 0
  when 121 => b <= "00011" ;   -- 3
  when 122 => b <= "00011" ;
  when 123 => b <= "00010" ; --2
  when 124 => b <= "00010" ;
  when 125 => b <= "00000" ;   
  when 126 => b <= "00011" ; --3
  when 127 => b <= "00011" ;
  when 128 => b <= "00011" ;
  when 129 => b <= "00011" ;
  when 130 => b <= "00000" ; 
  when 131 => b <= "00011" ;
  when 132 => b <= "00011" ;
  when 133 => b <= "00000" ;
  when 134 => b <= "00010" ;
  when 135 => b <= "00010" ;
  when 136 => b <= "00000" ;
  when 137 => b <= "00001" ; --1--
  when 138 => b <= "00001" ;
  when 139 => b <= "00001" ;
  when 140 => b <= "00001" ;
  when 141 => b <= "00001" ;
  when 142 => b <= "00001" ;
  when 143 => b <= "00000" ;
  when 144 => b <= "00110" ;   -- 6
  when 145 => b <= "00110" ;
  when 146 => b <= "00000" ; 
  when 147 => b <= "00001" ;
  when 148 => b <= "00001" ; 
  when 149 => b <= "00000" ;   -- 0
 
 
when 150 => b <= "00010" ;   -- 2
when 151 => b <= "00010" ;
when 152 => b <= "00010" ; 
when 153 => b <= "00010" ;  
when 154 => b <= "00000" ;   -- 0
when 155 => b <= "00010" ;   -- 2 3
when 156 => b <= "00010" ;
when 157 => b <= "00000" ; 
when 158 => b <= "00011" ;
when 159 => b <= "00011" ;  
when 160 => b <= "00000" ;  -- 0
when 161 => b <= "00010" ;   -- 2 1
when 162 => b <= "00010" ;
when 163 => b <= "00000" ; 
when 164 => b <= "00001" ;
when 165 => b <= "00001" ;  
when 166 => b <= "00000" ;   -- 0
when 167 => b <= "00110" ;   -- 6 1
when 168 => b <= "00110" ;
when 169 => b <= "00000" ; 
when 170 => b <= "00001" ;
when 171 => b <= "00001" ;  
when 172 => b <= "00000" ;   -- 0
 when others   => NULL ;
 end case ;
 end if ;
end if ;
end process ;
 
 
process(clk_4Hz)
begin
if clk_4Hz'event and clk_4Hz = '1' then
case (i) is
when  "000000010000" => origin <= 010647 ; -- //middle
  when  "000000100000" => origin <= 011272 ;
  when  "000000110000" => origin <= 011831 ;
  when  "000001000000" => origin <= 012087 ;
  when  "000001010000" => origin <= 012556 ;
  when  "000001100000" => origin <= 012974 ;
  when  "000001110000" => origin <= 013346 ;
  when  "000000000001" => origin <= 4916 ; --//low
  when  "000000000010" => origin <= 6168 ;
  when  "000000000011" => origin <= 7281 ;
  when  "000000000100" => origin <= 7791 ;
  when  "000000000101" => origin <= 8730 ;
  when  "000000000110" => origin <= 9565 ;
  when  "000000000111" => origin <= 10310 ;
  when  "000100000000" => origin <= 13516 ; --//high
  when  "001000000000" => origin <= 13829 ;
  when  "001100000000" => origin <= 14108 ;
  when  "010000000000" => origin <= 11535 ;
  when  "010100000000" => origin <= 14470 ;
  when  "011000000000" => origin <= 14678 ;
  when  "011100000000" => origin <= 14864 ;
when  "000000000000" => origin <= 16383 ;
  when  others   => origin <= 011111;
  end case ;
end if ;
end process ;
 
 
p5: process (clk_4Hz) is
begin
  if clk_4Hz'event and clk_4Hz = '1' then
 case (j) is
  when "00001" => i <= "000000000001" ; --//low
  when "00010" => i <= "000000000010" ;
  when "00011" => i <= "000000000011" ;
  when "00100" => i <= "000000000100" ;
  when "00101" => i <= "000000000101" ;
  when "00110" => i <= "000000000110" ;
  when "00111" => i <= "000000000111" ;
  when "01000" => i <= "000000010000" ; --//middle
  when "01001" => i <= "000000100000" ;
  when "01010" => i <= "000000110000" ;
  when "01011" => i <= "000001000000" ;
  when "01100" => i <= "000001010000" ;
  when "01101" => i <= "000001100000" ;
  when "01110" => i <= "000001110000" ;
  when "01111" => i <= "000100000000" ; --//high
  when "10000" => i <= "001000000000" ;
  when "10001" => i <= "001100000000" ;
  when "10010" => i <= "010000000000" ;
  when "10011" => i <= "010100000000" ;
  when "10100" => i <= "011000000000" ;
  when "10101" => i <= "011100000000" ;
when "00000" => i <= "000000000000" ;
when others => NULL ;
  end case ;
 
end if ;
end process ;
p6:process (clk_4Hz) is
begin
 if clk_4Hz'event and clk_4Hz = '1' then 
 if (len = 115 ) then
  len <= 0 ;
 else
len <= len + 1 ;
case (len) is
  when 0 => j <= "00101" ;   -- 5
  when 1 => j <= "00101" ;
  when 2 => j <= "00000" ;   -- 0
  when 3 => j <= "00101" ;   -- 5
  when 4 => j <= "00101" ;  
  when 5 => j <= "00000" ;   -- 0
  when 6 => j <= "00110" ;   -- 6
  when 7 => j <= "00110" ;
  when 8 => j <= "00110" ;
  when 9 => j <= "00110" ;   
  when 10 => j <= "00000" ;   -- 0
  when 11 => j <= "00101" ;   -- 5
  when 12 => j <= "00101" ;
  when 13 => j <= "00101" ;  
  when 14 => j <= "00101" ;  
when 15 => j <= "00000" ;   -- 0
when 16 => j <= "01000" ;   -- +1
when 17 => j <= "01000" ;
when 18 => j <= "01000" ;
when 19 => j <= "01000" ;  
when 20 => j <= "00000" ;   -- 0
when 21 => j <= "00111" ;   -- 7
when 22 => j <= "00111" ;
when 23 => j <= "00111" ;
when 24 => j <= "00111" ;   
when 25 => j <= "00000" ;   -- 0
when 26 => j <= "00101" ;   -- 5
when 27 => j <= "00101" ;
when 28 => j <= "00000" ;   -- 0
when 29 => j <= "00101" ;  -- 5
when 30 => j <= "00101" ;  
when 31 => j <= "00000" ;  -- 0
when 32 => j <= "00110" ;  -- 6
when 33 => j <= "00110" ;
when 34 => j <= "00110" ;
when 35 => j <= "00110" ;  
when 36 => j <= "00000" ;  -- 0
when 37 => j <= "00101" ;  -- 5
when 38 => j <= "00101" ;
when 39 => j <= "00101" ;
when 40 => j <= "00101" ;  
when 41 => j <= "00000" ;  -- 0
when 42 => j <= "01001" ;  -- +2
when 43 => j <= "01001" ;
when 44 => j <= "01001" ;
when 45 => j <= "01001" ;  
when 46 => j <= "00000" ;  -- 0
when 47 => j <= "01000" ;  -- +1
when 48 => j <= "01000" ;
when 49 => j <= "01000" ;
when 50 => j <= "01000" ;  
when 51 => j <= "00000" ;  -- 0
when 52 => j <= "00101" ;  --5
when 53 => j <= "00101" ;
when 54 => j <= "00000" ;  -- 0
when 55 => j <= "00101" ;  -- 5
when 56 => j <= "00101" ;  
when 57 => j <= "00000" ;  -- 0
when 58 => j <= "01100" ;  -- +5
when 59 => j <= "01100" ;
when 60 => j <= "01100" ;  
when 61 => j <= "01100" ;   
when 62 => j <= "00000" ;  -- 0
when 63 => j <= "01010" ;  -- +3
when 64 => j <= "01010" ;
when 65 => j <= "01010" ;
when 66 => j <= "01010" ;   
when 67 => j <= "00000" ;  -- 0
when 68 => j <= "01000" ;  -- +1
when 69 => j <= "01000" ;
when 70 => j <= "01000" ;
when 71 => j <= "01000" ;  
when 72 => j <= "00000" ;  -- 0
when 73 => j <= "00111" ;  -- 7
when 74 => j <= "00111" ;
when 75 => j <= "00111" ;
when 76 => j <= "00111" ;   
when 77 => j <= "00000" ;  -- 0
when 78 => j <= "00110" ;  -- 6
when 79 => j <= "00110" ;
when 80 => j <= "00110" ;
when 81 => j <= "00110" ;  
when 82 => j <= "00000" ;  -- 0
when 83 => j <= "01011" ;  -- +4
when 84 => j <= "01011" ;
when 85 => j <= "00000" ;  -- 0
when 86 => j <= "01011" ;  -- +4
when 87 => j <= "01011" ;  
when 88 => j <= "00000" ;  -- 0
when 89 => j <= "01010" ;  -- +3
when 90 => j <= "01010" ;
when 91 => j <= "01010" ;  
when 92 => j <= "01010" ;   
when 93 => j <= "00000" ;  -- 0
when 94 => j <= "01000" ;  -- +1
when 95 => j <= "01000" ;
when 96 => j <= "01000" ;  
when 97 => j <= "01000" ;   
when 98 => j <= "00000" ;  -- 0
when 99 => j <= "01001" ;  --+2
when 100 => j <= "01001" ;
when 101 => j <= "01001" ;
when 102 => j <= "01001" ;   
when 103 => j <= "00000" ;  -- 0
when 104 => j <= "01000" ;  -- +1
when 105 => j <= "01000" ;
when 106 => j <= "01000" ;
when 107 => j <= "01000" ;   
when 108 => j <= "00000" ;  -- 0
when 109 => j <= "00000" ;
 
when 110 => j <= "00110" ;
when 112 => j <= "00000" ;  -- 0
when 113 => j <= "00100" ;  -- 4
when 114 => j <= "00100" ;
when 115 => j <= "00100" ;
when 116 => j <= "00100" ;
when 117 => j <= "00000" ;  --0
when 118 => j <= "00101" ;  -- 5
when 119 => j <= "00101" ;
when 120 => j <= "00101" ;
when 121 => j <= "00101" ;
when 122 => j <= "00000" ;  --0
when 123 => j <= "00100" ;  -- 4
when 124 => j <= "00100" ;
when 125 => j <= "00100" ;
when 126 => j <= "00100" ;
when 127 => j <= "00000" ;  -- 0
when 128 => j <= "00000" ;
when 129 => j <= "00000" ; 
when others   => NULL ;
end case ;
end if ;
end if ;
end process ;
 
end rt1;