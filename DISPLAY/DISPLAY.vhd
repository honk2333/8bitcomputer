library ieee;
use ieee.std_logic_1164.all;

entity DISPLAY is
	port(	clk: in std_logic;							
			acc_a: in std_logic_vector(7 downto 0);	-- 寄存器AX内容
			acc_b: in std_logic_vector(7 downto 0);	-- 寄存器BX内容
			sel: out std_logic_vector(3 downto 0);		-- 选择亮的数码管
			dig: out std_logic_vector(7 downto 0));	-- 选择数码管亮的段
end DISPLAY;

architecture DISPLAY_arch of DISPLAY is
signal temp: std_logic_vector(3 downto 0);
begin
	process(clk)
	variable count: integer range 0 to 4 := 0;
	begin
		if(rising_edge(clk)) then
			if(count <= 1) then				-- 左一数码管显示AX高位
				sel <= "1110";
				temp <= acc_a(7 downto 4);
			elsif(count <= 2) then			-- 左二数码管显示AX低位
				sel <= "1101";
				temp <= acc_a(3 downto 0);
			elsif(count <= 3) then			-- 右二数码管显示BX高位
				sel <= "1011";
				temp <= acc_b(7 downto 4);
			elsif(count <= 4) then			-- 右一数码管显示BX低位
				sel <= "0111";
				temp <= acc_b(3 downto 0);
			end if;
			if(count = 6) then
				count := 0;
			else
				count := count + 1;
			end if;
		end if;
	end process;
	dig <= not x"3F" when temp = "0000" else
			 not x"06" when temp = "0001" else
			 not x"5B" when temp = "0010" else
			 not x"4F" when temp = "0011" else
			 not x"66" when temp = "0100" else
			 not x"6D" when temp = "0101" else
			 not x"7D" when temp = "0110" else
			 not x"07" when temp = "0111" else
			 not x"7F" when temp = "1000" else
			 not x"6F" when temp = "1001" else
			 not x"77" when temp = "1010" else
			 not x"7C" when temp = "1011" else
			 not x"39" when temp = "1100" else
			 not x"5E" when temp = "1101" else
			 not x"79" when temp = "1110" else
			 not x"71" when temp = "1111" else
			 x"00";
end DISPLAY_arch;