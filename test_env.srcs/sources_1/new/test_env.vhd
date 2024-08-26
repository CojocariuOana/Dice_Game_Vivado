library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is

component MPG is
Port (en: out  STD_LOGIC;
input: in STD_LOGIC;
clock : in  STD_LOGIC);
end component;


component SSD is
    Port ( cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           clock: in STD_LOGIC;
           inp : in STD_LOGIC_VECTOR (15 downto 0));
end component;

signal counter1 : std_logic_vector(3 downto 0) := x"1";
signal counter2 : std_logic_vector(3 downto 0) := x"1";
signal sum : std_logic_vector(3 downto 0);
signal btn0: std_logic;

signal display_inp  : std_logic_vector(15 downto 0) := x"0000"; 
signal ref_point  : std_logic_vector(3 downto 0) := x"0"; 

begin



display: SSD port map(cat,an,clk,display_inp);
debouncer: MPG port map(btn0,btn(0),clk);

sum<= counter1 + counter2;

process(clk)
begin
    if(btn(3) = '1' and rising_edge(clk)) then
        if(conv_integer(counter1) > 5) then
            counter1 <= x"1";
        else
            counter1 <= counter1 + 1;
        end if;
    end if;
end process;

process(clk)
begin
    if(btn(4) = '1' and rising_edge(clk)) then
        if(conv_integer(counter2) > 5) then
            counter2 <= x"1";
        else
            counter2 <= counter2 + 1;
        end if;
    end if;
end process;

process(btn0)
begin
    if(btn0 = '1') then
        display_inp <= sum & ref_point & counter1 & counter2;
        
        if(ref_point = x"0") then --e prima aruncare!
            ref_point <= sum;
            if(sum = x"7" or sum = x"B") then --a castigat
               led <= x"FF00";
               ref_point <= x"0";
            else
                if(sum = x"2" or sum = x"3" or sum = x"C") then --a pierdut
                    led <= x"00FF";
                    ref_point <= x"0";
                else
                    led <= x"0000";
                end if;
            end if;
        else    -- nu e prima aruncare !
            if(sum = ref_point) then --a castigat
                led <= x"FF00";
                ref_point <= x"0";
            else
                if(sum = x"7") then --a pierdut
                    led <= x"00FF";
                    ref_point <= x"0";
                else
                    led <= x"0000";
                end if;
            end if;
        end if;
        
    end if;
    
end process;

end Behavioral;
