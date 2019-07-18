library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity BEEP is
	port(
			clk_50m: in std_logic;--系统时钟；键盘输入/自动演奏
			tone_key: buffer std_logic_vector(15 downto 0)--音符信号输出
		);
end  BEEP;
architecture BEEP_ARCH of BEEP is
signal count:integer range 0 to 31;--change
signal clk2:std_logic;
begin
	process(clk_50m)  --对12mhz系统时钟进行3m的分频，得到4hz的信号clk2
	variable count:integer range 0 to 10000000;
	begin
		if clk_50m'event and clk_50m ='1' then
			count:=count+1;
			if count=5000000 then
				clk2<='1';                 
			elsif count=10000000 then
				clk2<='0';
				count:=0;
			end if;
		 end if; 
	end process;

	process(clk2)--此进程完成自动演奏部分乐曲的地址累加
	begin
		if clk2'event and clk2='1' then
			if count=29 then
				count<=0;
			else
				count<=count+1;
			end if;
		end if;
	end process;
	
	process(count,tone_key)      
	begin
		case count is--此case语句：存储自动演奏部分的乐曲
			when 0 => tone_key<=b"00000001_00000000";  --1
			when 1 => tone_key<=b"00000010_00000000";  --2
			when 2 => tone_key<=b"00000100_00000000";  --3
			when 3 => tone_key<=b"00000001_00000000";  --1
			when 4 => tone_key<=b"00000001_00000000";  --1
			when 5 => tone_key<=b"00000010_00000000";  --2
			when 6 => tone_key<=b"00000100_00000000";  --3
			when 7 => tone_key<=b"00000001_00000000";  --1
			when 8 => tone_key<=b"00000100_00000000";  --3
			when 9 => tone_key<=b"00001000_00000000";  --4
			when 10 => tone_key<=b"00010000_00000000";  --5
			when 11 => tone_key<=b"00000100_00000000";  --3
			when 12 => tone_key<=b"00001000_00000000";  --4
			when 13 => tone_key<=b"00010000_00000000";  --5
			when 14 => tone_key<=b"00010000_00000000";  --5
			when 15 => tone_key<=b"00100000_00000000";  --6
			when 16 => tone_key<=b"00010000_00000000";  --5
			when 17 => tone_key<=b"00001000_00000000";  --4
			when 18 => tone_key<=b"00000100_00000000";  --3
			when 19 => tone_key<=b"00000001_00000000";  --1
			when 20 => tone_key<=b"00010000_00000000";  --5
			when 21 => tone_key<=b"00100000_00000000";  --6
			when 22 => tone_key<=b"00010000_00000000";  --5
			when 23 => tone_key<=b"00001000_00000000";  --4
			when 24 => tone_key<=b"00000100_00000000";  --3
			when 25 => tone_key<=b"00000001_00000000";  --1
			when 26 => tone_key<=b"00000100_00000000";  --3
			when 27 => tone_key<=b"00000000_00100000";  --di6
			when 28 => tone_key<=b"00000001_00000000";  --1
			when others => null;
			end case;
	end process;
end BEEP_ARCH;

