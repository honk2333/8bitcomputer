library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity TONE is
	port(
			index: in std_logic_vector(15 downto 0);     --音符输入信号
			itone: out integer range 0 to 2047          --音符的分频系数
		);
end TONE;
architecture TONE_ARCH of TONE is
begin
	search :process(index)  --此进程完成音符到音符的分频系数译码，音符的显示，高低音阶
	begin
		case index is
			when "0000000000000001" => itone<=1433;
			when "0000000000000010" => itone<=1277;
			when "0000000000000100" => itone<=1138;
			when "0000000000001000" => itone<=1074;
			when "0000000000010000" => itone<=960;
			when "0000000000100000" => itone<=853;
			when "0000000001000000" => itone<=759;
			when "0000000010000000" => itone<=716;
			when "0000000100000000" => itone<=358;
			when "0000001000000000" => itone<=319;
			when "0000010000000000" => itone<=284;
			when "0000100000000000" => itone<=268;
			when "0001000000000000" => itone<=239;
			when "0010000000000000" => itone<=213;
			when "0100000000000000" => itone<=190;
			when "1000000000000000" => itone<=638;
			when others => itone<=0;
		end case;
	end process;
end TONE_ARCH;
