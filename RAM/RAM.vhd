library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
	port(	clk: in std_logic;										-- 时钟信号
			wr: in std_logic;											-- 写入信号
			addr: in std_logic_vector(3 downto 0);				-- 要读写的地址
			ram_in: in std_logic_vector(7 downto 0);			-- 输入的数据
			ram_out: out std_logic_vector(7 downto 0));		-- 输出的数据
end RAM;

architecture RAM_arch of RAM is
type memory is array(0 to 15) of std_logic_vector(7 downto 0);
shared variable mem: memory;
begin
	--process(clk, wr)
	--begin
	--	if(rising_edge(clk)) then
	--		if(wr = '0') then											-- wr信号为0时把读取的数据写入到读取的地址上
	--			mem(to_integer(unsigned(addr))) := ram_in;
	--		end if;
	--	end if;
	--end process;
	--ram_out <= mem(to_integer(unsigned(addr))) when wr = '1' else "ZZZZZZZZ";	-- wr信号为1时把读取的地址上的数据发送到输出端口
		ram_out <= "00000001" when addr = "0000" else					-- mov ax 8
			        "00001000" when addr = "0001" else
				     "00000010" when addr = "0010" else					-- mov bx 3
			        "00000011" when addr = "0011" else
				     "00010101" when addr = "0100" else 					-- add ax bx
				     "10000000" when addr = "0101" else 					-- shr ax
					  "00010100" when addr = "0110" else               -- xchg ax bx
					  "00000001" when addr = "0111" else 
				     "00001110" when addr = "1000" else 					-- halt
				     "ZZZZZZZZ";
end RAM_arch;