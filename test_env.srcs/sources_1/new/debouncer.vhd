library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debouncer is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           btn_out : out STD_LOGIC
           );
end debouncer;

architecture Behavioral of debouncer is
constant TARGET_TIME : integer := 20; 
signal CURRENT_TIME : integer := 0;
signal state : std_logic := '0';
begin
    process(clk, btn)
    begin
        if rising_edge(clk) then
           if state = '1' then
            CURRENT_TIME<=0;
            state<='0';
           end if;
           if btn = '1' then
            CURRENT_TIME <= CURRENT_TIME + 1;
            end if;
           if CURRENT_TIME > TARGET_TIME then
            state<='1';
           end if;
        end if;
    end process;
    btn_out<=state;
end Behavioral;
