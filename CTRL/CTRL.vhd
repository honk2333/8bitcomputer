library ieee;
use ieee.std_logic_1164.all;

--操作控制器模块
--根据不同的指令输出不同的控制端，从而使模型机实现各种功能

entity CTRL is
	port(	clk: in std_logic;
			mov_to_a: in std_logic; --从指令寄存器输出的各指令的控制信号
			mov_to_b: in std_logic;
			mov_b_to_a: in std_logic;
			mov_a_to_b: in std_logic;
			add_to_a: in std_logic;
			add_to_b: in std_logic;
			add_b_to_a: in std_logic;
			add_a_to_b: in std_logic;
			shr_a: in std_logic;
			shr_b: in std_logic;
			shl_a: in std_logic;
			shl_b: in std_logic;
			xchg: in std_logic;
			halt: in std_logic;

			t: in std_logic_vector(7 downto 0); --从节拍器COUNTER输入的节拍信号
			
			ipc: out std_logic;    --PC的计数信号
			imar: out std_logic;    --MAR的控制信号
			idr: out std_logic;     --DR的输入控制信号
			edr: out std_logic;     --DR的输出控制信号
			iir: out std_logic;     --IR的控制信号
			ia: out std_logic;      --输出给累加器ACC的控制信号
			ea: out std_logic;
			ib: out std_logic;
			eb: out std_logic;
			sum: out std_logic;    --输出给算术逻辑单元的控制信号
			sum_a: out std_logic;
			sum_b: out std_logic;
			shr: out std_logic;
			shl: out std_logic;
			chg: out std_logic;
			eout: out std_logic);
end CTRL;

architecture CTRL_arch of CTRL is
begin
	process( mov_to_a, mov_to_b, mov_b_to_a, mov_a_to_b, add_to_a, add_to_b, add_b_to_a, add_a_to_b, shr_a, shr_b, shl_a, shl_b, xchg, halt)
	begin 
	      if(halt ='1') then 
			ipc <= '0';
			else
		   ipc <= t(2) or (t(5) and mov_to_a) or (t(5) and mov_to_b) or (t(5) and add_to_a) or (t(5) and add_to_b);--需要从内存中读取立即数时ipc置1
			imar <= not (t(0) or (t(3) and mov_to_a) or (t(3) and mov_to_b) or (t(3) and add_to_a) or (t(3) and add_to_b));--需要从内存中读取立即数时imar置0
			idr <= t(1) or (t(4) and mov_to_a) or (t(4) and mov_to_b) or (t(4) and add_to_a) or (t(4) and add_to_b);
			edr <= (t(3) and mov_b_to_a) or (t(3) and mov_a_to_b) or (t(6) and add_to_a) or (t(6) and add_to_b) or (t(4) and add_b_to_a) or (t(4) and add_a_to_b) or (t(3) and shr_a) or (t(4) and shr_a) or (t(3) and shr_b) or (t(4) and shr_b) or (t(3) and shl_a) or (t(4) and shl_a) or (t(3) and shl_b) or (t(4) and shl_b);
			iir <= not t(2);
			ia <= not ((t(6) and mov_to_a) or (t(3) and mov_b_to_a) or (t(6) and add_to_a) or (t(4) and add_b_to_a) or (t(4) and shr_a) or (t(4) and shl_a));
			ea <= not ((t(3) and mov_a_to_b) or (t(3) and shr_a) or (t(3) and shl_a));
			ib <= not ((t(6) and mov_to_b) or (t(3) and mov_a_to_b) or (t(6) and add_to_b) or (t(4) and add_a_to_b) or (t(4) and shr_b) or (t(4) and shl_b));
			eb <= not ((t(3) and mov_b_to_a) or (t(3) and shr_b) or (t(3) and shl_b));
			sum <= not ((t(3) and add_b_to_a) or (t(3) and add_a_to_b));
			sum_a <= not (t(5) and add_to_a);
			sum_b <= not (t(5) and add_to_b);
			shr <= not ((t(3) and shr_a) or (t(3) and shr_b));
			shl <= not ((t(3) and shl_a) or (t(3) and shl_b));
			chg <= not (t(3) and xchg);
			eout <= not ((t(6) and add_to_a) or (t(6) and add_to_b) or (t(4) and add_b_to_a) or (t(4) and add_a_to_b) or (t(4) and shr_a) or (t(4) and shr_b) or (t(4) and shl_a) or (t(4) and shl_b));
	      end if;
	end process;
end CTRL_arch;