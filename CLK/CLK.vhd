library ieee;
use ieee.std_logic_1164.all;

--时钟产生器模块
--用于产生固定频率的方波

entity CLK is
	port(	clk_50m: in std_logic;					-- 50M晶振信号
			clk: out std_logic);						-- 输出时钟信号
end CLK;

architecture CLK_arch of CLK is
signal v: std_logic := '0';
begin
	process(clk_50m)
	variable count: integer range 0 to 1 := 0;   --变量count只有两个可能取值
	begin
		if(rising_edge(clk_50m)) then
		if(count = 1) then				-- 每2个上升沿改变一次输出，相当于周期扩大4倍
				count := 0;
				v <= not v;
			else
				count := count + 1;
			end if;
		end if;
	end process;
	clk <= v;
end CLK_arch;