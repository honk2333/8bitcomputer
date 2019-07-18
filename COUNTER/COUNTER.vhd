library ieee;
use ieee.std_logic_1164.all;

--输出循环移位方波

entity COUNTER is
	port(	clk: in std_logic;   --时钟信号端
	      clr: in std_logic;   --复位端
			t: out std_logic_vector(7 downto 0));   --输出信号
end COUNTER;

architecture COUNTER_arch of COUNTER is
signal temp: std_logic_vector(7 downto 0) := "00000000";
begin
	process(clk, clr)
	begin
	if(clr = '0') then      --复位端置零时，输出信号初始化
			temp <= "00000001";
		elsif(rising_edge(clk)) then
			temp <= temp(6 downto 0) & temp(7); --输出方波信号左移一位
		end if;
	end process;
	t <= temp;
end COUNTER_arch;