library ieee;
use ieee.std_logic_1164.all;

entity BX is
	port(	clk: in std_logic;											-- 时钟信号
			clr: in std_logic;											-- 重置信号
			ib: in std_logic;												-- 寄存器AX输入信号
			eb: in std_logic;												-- 寄存器AX输出信号
			acc_in: in std_logic_vector(7 downto 0);				-- 寄存器共用输入接口
			acc_out: out std_logic_vector(7 downto 0);			-- 寄存器共用输出接口
			acc_b: out std_logic_vector(7 downto 0));				-- 寄存器AX实时内容接口
end BX;

architecture BX_arch of BX is
signal temp_b: std_logic_vector(7 downto 0) := "00000000";	-- 寄存器AX
begin
	process(clk, clr, ib)
	begin
		if(rising_edge(clk)) then
			if(clr = '0') then
				temp_b <= "00000000";
			end if;
			if(ib = '0') then
				temp_b <= acc_in;
			end if;
		end if;
	end process;
	acc_b <= temp_b;											-- acc_a实时反映寄存器AX的值
	acc_out <= temp_b when eb = '0' else "ZZZZZZZZ";
end BX_arch;