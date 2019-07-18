library ieee;
use ieee.std_logic_1164.all;

--数据寄存器
--暂时存放指令码

entity DR is
	port(	clk: in std_logic;
			idr: in std_logic;  --IDR允许写入信号
			edr: in std_logic;  --EDR允许输出信号
			dr_in: in std_logic_vector(7 downto 0);  --输入的指令码
			dr_out: out std_logic_vector(7 downto 0));  --输出的指令码
end DR;

architecture DR_arch of DR is
signal temp: std_logic_vector(7 downto 0);
begin
	process(clk, idr)
	begin
		if(rising_edge(clk)) then
			if(idr = '1') then  --若写入信号为1，则将输入的指令码暂存
				temp <= dr_in;
			end if;
		end if;
	end process;
	dr_out <= temp when edr = '0' else "ZZZZZZZZ";   --若输出信号为0，则将暂存的指令码输出到端口dr_out
end DR_arch;