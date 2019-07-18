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
			alu_out: out std_logic_vector(7 downto 0);			-- 计算结果
			cff,sff,zff,off:out std_logic);    --标志符
end ALU;

architecture ALU_arch of ALU is
signal temp: std_logic_vector(8 downto 0) := "000000000";
begin
	process(clk, sum, sum_a, sum_b, shr, shl,sub_a,sub_b,sub_b_a,sub_a_b,and_a,and_b,or_a,or_b,inot)
	begin
		if(rising_edge(clk)) then
			if(sum = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_a) + unsigned('0'&acc_b));
				if(unsigned(temp))>377 then
				off<='1';
				else off<='0';
				end if;
				if(temp(8)='1') then
				cff<='1';
				else cff<='0';
				end if;
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(sum_a = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_a) + unsigned('0'&dr));
				if(unsigned(temp))>377 then
				off<='1';
				else off<='0';
				end if;
				if(temp(8)='1') then
				cff<='1';
				else cff<='0';
				end if;
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(sum_b = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_b) + unsigned('0'&dr));
				if(unsigned(temp))>377 then
				off<='1';
				else off<='0';
				end if;
				if(temp(8)='1') then
				cff<='1';
				else cff<='0';
				end if;
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(shr = '0') then
				temp <= '0' &'0'& dr(7 downto 1);
				off<='0';
				cff<=dr(0);
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(shl = '0') then
				temp <= dr(6 downto 0) & '0'&'0';
				off<='0';
				cff<=dr(7);
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(sub_a_b = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_b) - unsigned('0'&acc_a));
				off<='0';
				if(temp(8)='1') then
				cff<='1';
				else cff<='0';
				end if;
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				if(acc_b<acc_a) then
				sff<='1';
				else sff<='0';
				end if;
			end if;
			if(sub_b_a = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_a) - unsigned('0'&acc_b));
				off<='0';
				if(temp(8)='1') then
				cff<='1';
				else cff<='0';
				end if;
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				if(acc_b>acc_a) then
				sff<='1';
				else sff<='0';
				end if;
			end if;
			if(sub_a = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_a) - unsigned('0'&dr));
				off<='0';
				if(temp(8)='1') then
				cff<='1';
				else cff<='0';
				end if;
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				if(acc_a<dr) then
				sff<='1';
				else sff<='0';
				end if;
			end if;
			if(sub_b = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_b) - unsigned('0'&dr));
				off<='0';
				if(temp(8)='1') then
				cff<='1';
				else cff<='0';
				end if;
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				if(acc_b<dr) then
				sff<='1';
				else sff<='0';
				end if;
			end if;
			if(and_a = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_a) and unsigned('0'&dr));
				off<='0';
				cff<='0';
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(and_b = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_b) and unsigned('0'&dr));
				off<='0';
				cff<='0';
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(or_a = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_a) or unsigned('0'&dr));
				off<='0';
				cff<='0';
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(or_b = '0') then
				temp <= std_logic_vector(unsigned('0'&acc_b) or unsigned('0'&dr));
				off<='0';
				cff<='0';
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
			if(inot = '0') then
				temp <= not std_logic_vector(unsigned('0'&dr));
				off<='0';
				cff<='0';
				if(unsigned(temp)=0) then
				zff<='1';
				else zff<='0';
				end if;
				sff<='0';
			end if;
		end if;
	end process;
	alu_out <= temp(7 downto 0) when ialu = '0' else "ZZZZZZZZ";		-- 默认高阻态
end ALU_arch;