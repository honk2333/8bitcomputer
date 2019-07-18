library ieee;
use ieee.std_logic_1164.all;

--累加器模块
--包含了寄存器ax与bx

entity ACC is
	port(	clk: in std_logic;
			clr: in std_logic;   --复位端信号
			ia: in std_logic;  --寄存器ax中输入的控制信号
			ea: in std_logic;  --寄存器ax中输出的控制信号
			ib: in std_logic;  --寄存器bx中输入的控制信号
			eb: in std_logic;  --寄存器bx中输出的控制信号
			chg: in std_logic; --交换寄存器内容的控制信号
			acc_in: in std_logic_vector(7 downto 0);  --向寄存器中输入的数据
			acc_out: out std_logic_vector(7 downto 0); --从寄存器中输出的数据
			acc_a: out std_logic_vector(7 downto 0);  --寄存器ax中的内容
			acc_b: out std_logic_vector(7 downto 0));  --寄存器bx中的内容
end ACC;

architecture ACC_arch of ACC is
signal temp_a: std_logic_vector(7 downto 0) := "00000000"; --ax
signal temp_b: std_logic_vector(7 downto 0) := "00000000";  --bx
begin
	process(clk, clr, ia, ib, chg)
	begin
		if(rising_edge(clk)) then
		if(clr = '0') then   --复位信号到来时将axbx寄存器清零
				temp_a <= "00000000";
				temp_b <= "00000000";
			end if;
			if(ia = '0') then
				temp_a <= acc_in;
			end if;
			if(ib = '0') then
				temp_b <= acc_in;
			end if;
			if(chg = '0') then
				temp_a <= temp_b;
				temp_b <= temp_a;
			end if;
		end if;
	end process;
	acc_a <= temp_a;
	acc_b <= temp_b;
	acc_out <= temp_a when ea = '0' else 
				  temp_b when eb = '0' else
				  "ZZZZZZZZ";
end ACC_arch;