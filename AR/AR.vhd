library ieee;
use ieee.std_logic_1164.all;

--地址寄存器

entity AR is
	port(	clk: in std_logic;										-- 时钟信号
			iar: in std_logic;										-- 地址寄存器寄存信号
			ar_in: in std_logic_vector(3 downto 0);			-- 从程序计数器读取地址端口
			ar_out: out std_logic_vector(3 downto 0));		-- 输出地址端口，连接地址总线
end AR;

architecture AR_arch of AR is
signal temp: std_logic_vector(3 downto 0);
begin
	process(clk, iar)
	begin
		if(rising_edge(clk)) then
			if(iar = '0') then										-- iar信号激活时读取地址
				temp <= ar_in;
			end if;
		end if;
	end process;
	ar_out <= temp;
end AR_arch;