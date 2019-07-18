library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity SPEAKER is
	port(
			clk_50m: in std_logic;                    --系统时钟12mhz
			itone: in integer range 0 to 2047;      --音符分频系数
			spks: out std_logic                        --驱动扬声器的音频信号
		);
end SPEAKER;
architecture SPEAKER_ARCH of SPEAKER is
signal  preclk, fullspks:std_logic;
begin
	process(clk_50m)--此进程对系统时钟进行16分频
	variable count: integer range 0 to 50;
	begin
		if clk_50m'event and clk_50m='1' then count:=count+1;
			if count=25 then
				preclk<='1';  
			elsif count=50 then
				preclk<='0';
				count:=0;
			end if; 
		end if;
	end process;
	
	process(preclk,itone)--对0.75mhz的脉冲再次分频，得到所需要的音符频率
	variable count11:integer range 0 to 2047;
	begin
		if preclk'event and preclk='1' then
		   if count11<itone then
				count11:=count11+1;
				fullspks<='1'; 
		   else
				count11:=0;
				fullspks<='0';
		   end if;
		end if;
	end process ;
	
	process(fullspks)  --此进程对fullspks进行2分频
	variable count2: std_logic:='0';
	begin
	if fullspks'event and fullspks='1' then
		count2:=not count2;
		if count2='1' then
			spks<='1';
		else
			spks<='0';
	   end if;
	end if;
	end process;
end SPEAKER_ARCH;
