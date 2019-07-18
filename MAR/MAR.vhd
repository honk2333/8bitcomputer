library ieee;
use ieee.std_logic_1164.all;

--地址寄存器
--暂存地址，当控制信号到来时在输出地址

entity MAR is
	port(	clk: in std_logic;
			imar: in std_logic;   --imar为地址输出的控制端
			mar_in: in std_logic_vector(3 downto 0);  --地址输入端
			mar_out: out std_logic_vector(3 downto 0));  --地址输出端
end MAR;

architecture MAR_arch of MAR is
signal temp: std_logic_vector(3 downto 0);
begin
	process(clk, imar)
	begin
	if(rising_edge(clk)) then  --clk的上升沿到来时
			if(imar = '0') then   --imar=0时将地址送到地址输入端
				temp <= mar_in;
			end if;
		end if;
	end process;
	mar_out <= temp;
end MAR_arch;