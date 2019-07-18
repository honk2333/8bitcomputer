library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BUZZER is
	port(
		clk:in std_logic;
		ea: in std_logic;
		eb: in std_logic;
		buzzer:out std_logic;
		acc_a:in std_logic_vector(7 downto 0);
		acc_b:in std_logic_vector(7 downto 0) 
	);
end;

architecture BUZZER_ARCH of BUZZER is
signal cnt:integer range 0 to 200000;
signal target:integer range 0 to 200000;
signal volumn:integer range 0 to 7;
begin
	process(clk) 
	variable buzzer_task :std_logic := ea nand eb;
	begin  
		if(falling_edge(clk))then
			if(buzzer_task='0')then
				if(cnt<target/8*volumn)then
					buzzer<='0';
				else
					buzzer<='1';
				end if;
				if(cnt=target)then
					cnt<=0;
				else
					cnt<=cnt+1;
				end if;
			else
				buzzer<='1';
			end if;
		end if;
	end process;
	
	process(ea,eb,acc_a,acc_b)
	begin
	if(ea='0') then
		volumn<=conv_integer(acc_a(7 downto 5));
		case conv_integer(acc_a(4 downto 0)) is
			when 00=>target<=50000000/261;
			when 01=>target<=50000000/293;
			when 02=>target<=50000000/329;
			when 03=>target<=50000000/349;
			when 04=>target<=50000000/392;
			when 05=>target<=50000000/440;
			when 06=>target<=50000000/499;
			when 07=>target<=50000000/523;
			when 08=>target<=50000000/587;
			when 09=>target<=50000000/659;
			when 10=>target<=50000000/698;
			when 11=>target<=50000000/784;
			when 12=>target<=50000000/880;
			when 13=>target<=50000000/998;
			when 14=>target<=50000000/1046;
			when 15=>target<=50000000/1174;
			when 16=>target<=50000000/1318;
			when 17=>target<=50000000/1396;
			when 18=>target<=50000000/1568;
			when 19=>target<=50000000/1760;
			when 20=>target<=50000000/1976;
			when 21=>target<=50000000/2093;
			when 22=>target<=50000000/2349;
			when 23=>target<=50000000/2637;
			when 24=>target<=50000000/2794;
			when 25=>target<=50000000/3136;
			when 26=>target<=50000000/3520;
			when 27=>target<=50000000/3951;
			when others=>target<=0;
		end case;
		
		elsif(eb='0') then
		volumn<=conv_integer(acc_b(7 downto 5));
		case conv_integer(acc_b(4 downto 0)) is
			when 00=>target<=50000000/261;
			when 01=>target<=50000000/293;
			when 02=>target<=50000000/329;
			when 03=>target<=50000000/349;
			when 04=>target<=50000000/392;
			when 05=>target<=50000000/440;
			when 06=>target<=50000000/499;
			when 07=>target<=50000000/523;
			when 08=>target<=50000000/587;
			when 09=>target<=50000000/659;
			when 10=>target<=50000000/698;
			when 11=>target<=50000000/784;
			when 12=>target<=50000000/880;
			when 13=>target<=50000000/998;
			when 14=>target<=50000000/1046;
			when 15=>target<=50000000/1174;
			when 16=>target<=50000000/1318;
			when 17=>target<=50000000/1396;
			when 18=>target<=50000000/1568;
			when 19=>target<=50000000/1760;
			when 20=>target<=50000000/1976;
			when 21=>target<=50000000/2093;
			when 22=>target<=50000000/2349;
			when 23=>target<=50000000/2637;
			when 24=>target<=50000000/2794;
			when 25=>target<=50000000/3136;
			when 26=>target<=50000000/3520;
			when 27=>target<=50000000/3951;
			when others=>target<=0;
		end case;
		end if;
	end process;
end BUZZER_ARCH;