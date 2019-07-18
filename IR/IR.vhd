library ieee;
use ieee.std_logic_1164.all;

--指令寄存器和指令译码器
--暂存指令和对指令码译码

entity IR is
	port(	clk: in std_logic;
	      clr: in std_logic; --复位信号
			iir: in std_logic; --IIR为允许输入信号
			ir_in: in std_logic_vector(7 downto 0); --输入的指令码
			mov_to_a: out std_logic;  --将输入数据移到寄存器ax中
			mov_to_b: out std_logic;  --将输入数据移到寄存器bx中
			mov_b_to_a: out std_logic;  --将bx寄存器中的内容移到ax中
			mov_a_to_b: out std_logic; --将ax寄存器的内容移到bx中
			add_to_a: out std_logic;   --将一个数据加到寄存器ax上
			add_to_b: out std_logic;   --将一个数据加到寄存器bx上
			add_b_to_a: out std_logic; --将寄存器bx的内容加到ax上
			add_a_to_b: out std_logic;  --将寄存器ax的内容加到bx上
			shr_a: out std_logic;   --将寄存器bx的内容右移一位
			shr_b: out std_logic;   --将寄存器bx的内容右移一位
			shl_a: out std_logic;   --将寄存器ax的内容左移一位
			shl_b: out std_logic;   --将寄存器bx的内容左移一位
			xchg: out std_logic;   --交换内容
			halt: out std_logic);  --停机
end IR; 

architecture IR_arch of IR is
signal temp: std_logic_vector(7 downto 0) := "00000000";
begin
	process(clk, clr, iir)
	begin
		if(rising_edge(clk)) then
		if(clr = '0') then   --复位端信号为0，将指令寄存器清零
				temp <= "00000000";
			end if;
			if(iir = '0') then  --若允许输入信号为0，则将输入的指令取到指令寄存器中
				temp <= ir_in;
			end if;
		end if;
	end process;
	
	process(clk, temp)    --译码的过程
	begin
		if(temp = "00000001") then
			mov_to_a <= '1';
		else
			mov_to_a <= '0';
		end if;
		if(temp = "00000010") then
			mov_to_b <= '1';
		else
			mov_to_b <= '0';
		end if;
		if(temp = "00000011") then
			mov_b_to_a <= '1';
		else
			mov_b_to_a <= '0';
		end if;
		if(temp = "00000100") then
			mov_a_to_b <= '1';
		else
			mov_a_to_b <= '0';
		end if;
		if(temp = "00000101") then
			add_to_a <= '1';
		else
			add_to_a <= '0';
		end if;
		if(temp = "00000110") then
			add_to_b <= '1';
		else
			add_to_b <= '0';
		end if;
		if(temp = "00000111") then
			add_b_to_a <= '1';
		else
			add_b_to_a <= '0';
		end if;
		if(temp = "00001000") then
			add_a_to_b <= '1';
		else
			add_a_to_b <= '0';
		end if;
		if(temp = "00001001") then
			shr_a <= '1';
		else
			shr_a <= '0';
		end if;
		if(temp = "00001010") then
			shr_b <= '1';
		else
			shr_b <= '0';
		end if;
		if(temp = "00001011") then
			shl_a <= '1';
		else
			shl_a <= '0';
		end if;
		if(temp = "00001100") then
			shl_b <= '1';
		else
			shl_b <= '0';
		end if;
		if(temp = "00001101") then
			xchg <= '1';
		else
			xchg <= '0';
		end if;
		if(temp = "00001110") then
			halt <= '1';
		else
			halt <= '0';
		end if;
	end process;
end IR_arch;