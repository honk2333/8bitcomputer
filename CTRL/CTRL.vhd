library ieee;
use ieee.std_logic_1164.all;

entity CTRL is
	port(	clk: in std_logic;							-- 时钟信号
			mov_to_a: in std_logic;						-- 向AX中存入立即数
			mov_to_b: in std_logic;						-- 向BX中存入立即数
			mov_b_to_a: in std_logic;					-- 将BX内容复制进AX中
			mov_a_to_b: in std_logic;					-- 将AX内容复制进BX中
			add_to_a: in std_logic;						-- 向AX中加上立即数
			add_to_b: in std_logic;						-- 向BX中加上立即数
			add_b_to_a: in std_logic;					-- 将BX加到Ax中
			add_a_to_b: in std_logic;					-- 将AX加到BX中
			shr_a: in std_logic;							-- 将AX右移一位
			shr_b: in std_logic;							-- 将BX右移一位
			shl_a: in std_logic;							-- 将Ax左移一位
			shl_b: in std_logic;							-- 将BX左移一位
			xchg: in std_logic;
			halt: in std_logic;							-- 停机
			
			ipc: out std_logic;							-- 地址计数器计数信号
			iar: out std_logic;							-- 地址寄存器寄存信号
			idr: out std_logic;							-- 数据寄存器寄存信号
			edr: out std_logic;							-- 数据寄存器取出信号
			iir: out std_logic;							-- 指令寄存器寄存信号
			ia: out std_logic;							-- 寄存器Ax取出信号
			ib: out std_logic;							-- 寄存器Ax寄存信号
			ea: out std_logic;							-- 寄存器Bx寄存信号
			eb: out std_logic;							-- 寄存器Bx取出信号
			sum: out std_logic;							-- 寄存器AX和BX求和信号
			sub_a_b: out std_logic;
		   sub_b_a: out std_logic;	
			sum_a: out std_logic;						-- 寄存器AX加入立即数信号
			sum_b: out std_logic;						-- 寄存器BX加入立即数信号
			sub_a: out std_logic;
			sub_b: out std_logic;
			and_a: out std_logic;
			and_b: out std_logic;
			or_a: out std_logic;
			or_b: out std_logic;
			shr: out std_logic;							-- 右移信号
			shl: out std_logic;							-- 左移信号
			inot: out std_logic;
			chg: out std_logic;
			
			sub_to_a:in std_logic;             
			sub_to_b:in std_logic;
			sub_b_to_a:in std_logic;
			sub_a_to_b:in std_logic;
			and_to_a:in std_logic;
			and_to_b:in std_logic;
			or_to_a:in std_logic;
			or_to_b:in std_logic;
			not_a:in std_logic;
			not_b:in std_logic;
			t: in std_logic_vector(7 downto 0);		-- 节拍信号
			ialu: out std_logic);				   	-- 算术逻辑单元输出信号
end CTRL;

architecture CTRL_arch of CTRL is


begin
	process(mov_to_a, mov_to_b, mov_b_to_a, mov_a_to_b, add_to_a, add_to_b, add_b_to_a, add_a_to_b, shr_a, shr_b, shl_a, shl_b,
	halt,sub_to_a,sub_to_b,sub_a_to_b,sub_b_to_a,and_to_a,and_to_b,or_to_a,or_to_b,not_a,not_b)
	begin
		if(halt = '1') then				-- 停机
			ipc <= '0';
		else									-- 确定一个节拍周期中各个节拍应发出的信号，控制其它单元进行运算
			ipc <= t(2) or (t(5) and mov_to_a) or (t(5) and mov_to_b) or (t(5) and add_to_a) or (t(5) and add_to_b) 
			or (t(5) and sub_to_a) or (t(5) and sub_to_b) or (t(5) and and_to_a) or (t(5) and and_to_b) or (t(5) and or_to_a) or (t(5) and or_to_b);
			
			iar <= not (t(0) or (t(3) and mov_to_a) or (t(3) and mov_to_b) or (t(3) and add_to_a) or (t(3) and add_to_b) --);
			or(t(3) and sub_to_a) or (t(3) and sub_to_b) or (t(3) and and_to_a) or (t(3) and and_to_b) or (t(3) and or_to_a) or (t(3) and or_to_b)); 

			idr <= t(1) or (t(4) and mov_to_a) or (t(4) and mov_to_b) or (t(4) and add_to_a) or (t(4) and add_to_b) 
			or(t(4) and sub_to_a) or (t(4) and sub_to_b) or (t(4) and and_to_a) or (t(4) and and_to_b) or (t(4) and or_to_a) or (t(4) and or_to_b);
			
	      
			edr <= (t(3) and mov_b_to_a) or (t(3) and mov_a_to_b) or (t(6) and add_to_a) or (t(6) and add_to_b) or (t(4) and add_b_to_a) or (t(4) and add_a_to_b)
			or (t(3) and shr_a) or (t(4) and shr_a) or (t(3) and shr_b) or (t(4) and shr_b) or (t(3) and shl_a) or (t(4) and shl_a) or (t(3) and shl_b) or (t(4) and shl_b)
			or (t(4) and sub_b_to_a) or (t(4) and sub_a_to_b) or (t(6) and sub_to_a) or (t(6) and sub_to_b) 
			or (t(6) and and_to_a) or (t(6) and and_to_b) 
			or (t(6) and or_to_a) or (t(6) and or_to_b)
			or (t(3) and not_a) or (t(4) and not_a) or (t(3) and not_b) or (t(4) and not_b);
			
			
			iir <= not t(2);
			
			ia <= not ((t(6) and mov_to_a) or (t(3) and mov_b_to_a) or (t(6) and add_to_a) or (t(4) and add_b_to_a) or (t(4) and shr_a) or (t(4) and shl_a) --);
			or(t(6) and sub_to_a) or (t(4) and sub_b_to_a) or (t(6) and and_to_a) or(t(6) and or_to_a)  or (t(4) and not_a) );
			
			ea <= not ((t(3) and mov_a_to_b) or (t(3) and shr_a) or (t(3) and shl_a) --);
			or  (t(3) and not_a) );
			
			ib <= not ((t(6) and mov_to_b) or (t(3) and mov_a_to_b) or (t(6) and add_to_b) or (t(4) and add_a_to_b) or (t(4) and shr_b) or (t(4) and shl_b) --);
			or(t(6) and sub_to_b) or (t(4) and sub_a_to_b) or (t(6) and and_to_b) or(t(6) and or_to_b) or (t(4) and not_b) );
			
			eb <= not ((t(3) and mov_b_to_a) or (t(3) and shr_b) or (t(3) and shl_b) -- );
			or (t(3) and not_b) );
			
			sum <= not ((t(3) and add_b_to_a) or (t(3) and add_a_to_b));
			sub_a_b <= not (t(3) and sub_a_to_b);
			sub_b_a <= not (t(3) and sub_b_to_a);
			
			sum_a <= not (t(5) and add_to_a);
	   	sub_a<= not (t(5) and sub_to_a);
			and_a<= not (t(5) and and_to_a);
			or_a<= not (t(5) and or_to_a);
			
			sum_b <= not (t(5) and add_to_b);
			sub_b <= not (t(5) and sub_to_b);
			and_b <= not (t(5) and and_to_b);
			or_b <= not (t(5) and or_to_b);
		
			inot<= not ((t(3) and not_a) or (t(3) and not_b));
			shr <= not ((t(3) and shr_a) or (t(3) and shr_b));
			shl <= not ((t(3) and shl_a) or (t(3) and shl_b));
			chg <= not (t(3) and xchg);
			
			
			ialu <= not ((t(6) and add_to_a) or (t(6) and add_to_b) or (t(4) and add_b_to_a) or (t(4) and add_a_to_b) 
			or (t(4) and shr_a) or (t(4) and shr_b) or (t(4) and shl_a) or (t(4) and shl_b) --);
			or (t(6) and sub_to_a) or (t(6) and sub_to_b) or (t(6) and and_to_a) or (t(6) and and_to_b) or (t(6) and or_to_a) or (t(6) and or_to_b) 
			or (t(4) and sub_b_to_a) or (t(4) and sub_a_to_b) or (t(4) and not_a) or (t(4) and not_b) );

--       ipc <= t(2) or (t(5) and mov_to_a) or (t(5) and mov_to_b) or (t(5) and add_to_a) or (t(5) and add_to_b);--需要从内存中读取立即数时ipc置1
--			iar <= not (t(0) or (t(3) and mov_to_a) or (t(3) and mov_to_b) or (t(3) and add_to_a) or (t(3) and add_to_b));--需要从内存中读取立即数时imar置0
--			idr <= t(1) or (t(4) and mov_to_a) or (t(4) and mov_to_b) or (t(4) and add_to_a) or (t(4) and add_to_b);
--			edr <= (t(3) and mov_b_to_a) or (t(3) and mov_a_to_b) or (t(6) and add_to_a) or (t(6) and add_to_b) or (t(4) and add_b_to_a) or (t(4) and add_a_to_b) or (t(3) and shr_a) or (t(4) and shr_a) or (t(3) and shr_b) or (t(4) and shr_b) or (t(3) and shl_a) or (t(4) and shl_a) or (t(3) and shl_b) or (t(4) and shl_b);
--			iir <= not t(2);
--			ia <= not ((t(6) and mov_to_a) or (t(3) and mov_b_to_a) or (t(6) and add_to_a) or (t(4) and add_b_to_a) or (t(4) and shr_a) or (t(4) and shl_a));
--			ea <= not ((t(3) and mov_a_to_b) or (t(3) and shr_a) or (t(3) and shl_a));
--			ib <= not ((t(6) and mov_to_b) or (t(3) and mov_a_to_b) or (t(6) and add_to_b) or (t(4) and add_a_to_b) or (t(4) and shr_b) or (t(4) and shl_b));
--			eb <= not ((t(3) and mov_b_to_a) or (t(3) and shr_b) or (t(3) and shl_b));
--			sum <= not ((t(3) and add_b_to_a) or (t(3) and add_a_to_b));
--			sum_a <= not (t(5) and add_to_a);
--			sum_b <= not (t(5) and add_to_b);
--			shr <= not ((t(3) and shr_a) or (t(3) and shr_b));
--			shl <= not ((t(3) and shl_a) or (t(3) and shl_b));
--			chg <= not (t(3) and xchg);
--			ialu <= not ((t(6) and add_to_a) or (t(6) and add_to_b) or (t(4) and add_b_to_a) or (t(4) and add_a_to_b) or (t(4) and shr_a) or (t(4) and shr_b) or (t(4) and shl_a) or (t(4) and shl_b));

		end if;
	end process;

end CTRL_arch;