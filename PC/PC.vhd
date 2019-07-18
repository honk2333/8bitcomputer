library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--程序计数器
--产生要执行的指令的地址

entity PC is
	port(	clk: in std_logic;
	      clr: in std_logic;  --复位端信号
			ipc: in std_logic;  --计数信号
			pc_out: out std_logic_vector(3 downto 0));  --输出地址
end PC;

architecture PC_arch of PC is
signal temp: std_logic_vector(3 downto 0) := "ZZZZ"; 
begin
	process(clk, clr, ipc)
	begin
	if(clr = '0') then     --复位信号到达，temp复位为0000
			temp <= "0000";
		elsif(rising_edge(clk)) then
			if(ipc = '1') then   --ipc==1时计数
				temp <= std_logic_vector(unsigned(temp) + 1);  --利用强制类型转换来使temp+1
			end if;
		end if;
	end process;
	pc_out <= temp;
end PC_arch;