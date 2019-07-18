library ieee;
use ieee.std_logic_1164.all;

entity DISPLAY is
	port(	clk_50m: in std_logic;	-- 50M晶振信号						
			acc_a: in std_logic_vector(7 downto 0);	-- 寄存器AX内容
			acc_b: in std_logic_vector(7 downto 0);	-- 寄存器BX内容
			sel: out std_logic_vector(3 downto 0);		-- 选择亮的数码管
			dig: out std_logic_vector(7 downto 0));	-- 选择数码管亮的段
end DISPLAY;

architecture DISPLAY_arch of DISPLAY is
signal temp: std_logic_vector(3 downto 0);
begin
	process(clk_50m)
	variable count: integer range 0 to 4000 := 0;
	begin
		if(rising_edge(clk_50m)) then
			if(count <= 1000) then				-- 左一数码管显示AX高位
				sel <= "1110";
				temp <= acc_a(7 downto 4);
			elsif(count <= 2000) then			-- 左二数码管显示AX低位
				sel <= "1101";
				temp <= acc_a(3 downto 0);
			elsif(count <= 3000) then			-- 右二数码管显示BX高位
				sel <= "1011";
				temp <= acc_b(7 downto 4);
			elsif(count <= 4000) then			-- 右一数码管显示BX低位
				sel <= "0111";
				temp <= acc_b(3 downto 0);
			end if;
			if(count = 4000) then
				count := 0;
			else
				count := count + 1;
			end if;
		end if;
	end process;  --晶体管译码部分
	dig <= "11000000" when temp = "0000" else
			 "11111001" when temp = "0001" else
			 "10100100" when temp = "0010" else
			 "10110000" when temp = "0011" else
			 "10011001" when temp = "0100" else
			 "10010010" when temp = "0101" else
			 "10000010" when temp = "0110" else
			 "11111000" when temp = "0111" else
			 "10000000" when temp = "1000" else
			 "10010000" when temp = "1001" else
			 "10001000" when temp = "1010" else
			 "10000011" when temp = "1011" else
			 "11000110" when temp = "1100" else
			 "10100001" when temp = "1101" else
			 "10000110" when temp = "1110" else
			 "10001110" when temp = "1111" else
			 x"00";
end DISPLAY_arch;