library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port(	clk: in std_logic;											-- 时钟信号
			sum: in std_logic;											-- 将寄存器AX和BX值相加
			sub_a_b: in std_logic;
			sub_b_a: in std_logic;
			
			sum_a: in std_logic;											-- 将寄存器AX值加上数据总线内容
			sum_b: in std_logic;											-- 将寄存器BX值加上数据总线内容
			sub_b: in std_logic;
			sub_a: in std_logic;
			and_a: in std_logic;
			and_b: in std_logic;
			or_a: in std_logic;
			or_b: in std_logic;
			
			shr: in std_logic;											-- 将数据总线值右移
			shl: in std_logic;											-- 将数据总线值左移
			inot: in std_logic;
			
			ialu: in std_logic;											-- 输出计算结果
			acc_a: in std_logic_vector(7 downto 0);				-- 寄存器AX内容
			acc_b: in std_logic_vector(7 downto 0);				-- 寄存器BX内容
			dr: in std_logic_vector(7 downto 0);					-- 数据总线内容
			alu_out: out std_logic_vector(7 downto 0));			-- 计算结果
end ALU;

architecture ALU_arch of ALU is
signal temp: std_logic_vector(7 downto 0) := "00000000";
begin
	process(clk, sum, sum_a, sum_b, shr, shl,sub_a,sub_b,sub_b_a,sub_a_b,and_a,and_b,or_a,or_b,inot)
	begin
		if(rising_edge(clk)) then
			if(sum = '0') then
				temp <= std_logic_vector(unsigned(acc_a) + unsigned(acc_b));
			end if;
			if(sum_a = '0') then
				temp <= std_logic_vector(unsigned(acc_a) + unsigned(dr));
			end if;
			if(sum_b = '0') then
				temp <= std_logic_vector(unsigned(acc_b) + unsigned(dr));
			end if;
			if(shr = '0') then
				temp <= '0' & dr(7 downto 1);
			end if;
			if(shl = '0') then
				temp <= dr(6 downto 0) & '0';
			end if;
			if(sub_a_b = '0') then
				temp <= std_logic_vector(unsigned(acc_b) - unsigned(acc_a));
			end if;
			if(sub_b_a = '0') then
				temp <= std_logic_vector(unsigned(acc_a) - unsigned(acc_b));
			end if;
			if(sub_a = '0') then
				temp <= std_logic_vector(unsigned(acc_a) - unsigned(dr));
			end if;
			if(sub_b = '0') then
				temp <= std_logic_vector(unsigned(acc_b) - unsigned(dr));
			end if;
			if(and_a = '0') then
				temp <= std_logic_vector(unsigned(acc_a) and unsigned(dr));
			end if;
			if(and_b = '0') then
				temp <= std_logic_vector(unsigned(acc_b) and unsigned(dr));
			end if;
			if(or_a = '0') then
				temp <= std_logic_vector(unsigned(acc_a) or unsigned(dr));
			end if;
			if(or_b = '0') then
				temp <= std_logic_vector(unsigned(acc_b) or unsigned(dr));
			end if;
			if(inot = '0') then
				temp <= not std_logic_vector(unsigned(dr));
			end if;
		end if;
	end process;
	alu_out <= temp when ialu = '0' else "ZZZZZZZZ";		-- 默认高阻态
end ALU_arch;