library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--存储器模块，功能：
--1，根据输入的地址向数据总线上输出对应地址存放的内容
--2，根据输入的地址和输入的数据，将数据写入该内存单元

entity RAM is
	port(	clk: in std_logic;
			wr: in std_logic;   --读写控制端
			addr: in std_logic_vector(3 downto 0);  --输入地址
			ram_in: in std_logic_vector(7 downto 0);  --输入数据
			ram_out: out std_logic_vector(7 downto 0));  --输出数据
end RAM;

architecture RAM_arch of RAM is
type memory is array(0 to 15) of std_logic_vector(7 downto 0);
shared variable mem: memory;
begin
	process(clk, wr)
	begin
	if(rising_edge(clk)) then   --当时钟上升沿到来时
			if(wr = '0') then     --wr=0表示写入，向addr表示的地址写入数据ram_in；
				mem(to_integer(unsigned(addr))) := ram_in;
			end if;
		end if;
	end process;
	ram_out <= mem(to_integer(unsigned(addr))) when wr = '1' else "ZZZZZZZZ";  --wr=1表示读取，将内存addr地址存放的数据取到ram_out并输出
--	ram_out <= "00000001" when addr = "0000" else					-- mov AX 6
--				  "00000110" when addr = "0001" else
--				  "00000010" when addr = "0010" else					-- mov bx 4
--				  "00000100" when addr = "0011" else
--				  "00000111" when addr = "0100" else 					-- add ax bx
--				  "00001100" when addr = "0101" else 					-- shl bx
--				  "00000110" when addr = "0110" else 					-- add bx 1
--				  "00000001" when addr = "0111" else
--				  "00001110" when addr = "1000" else 					-- halt
--				  "ZZZZZZZZ";
end RAM_arch;