library ieee;
use ieee.std_logic_1164.all;

--二选一数据选择器
--选择地址寄存器输入的地址和RAM_IN端口输入的地址
--将选择的地址输出到RES端

entity RAM_MUX is
	port(	sel: in std_logic;           --选择端
			addr1: in std_logic_vector(3 downto 0);  --用户输入的地址
			addr2: in std_logic_vector(3 downto 0); --地址寄存器传送过来的寄存器
 			res: out std_logic_vector(3 downto 0));  --输出地址的端口
end RAM_MUX;

architecture RAM_MUX_arch of RAM_MUX is
begin
	res <= addr1 when sel = '0' else addr2; --选择端为0时输出addr1，选择端为1时输出addr2;
end RAM_MUX_arch;