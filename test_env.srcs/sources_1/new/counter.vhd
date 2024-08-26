library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    Port ( clk : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (15 downto 0);
           en: in std_logic;
           dir: in std_logic
           );
end counter;

architecture Behavioral of counter is



signal count : STD_LOGIC_VECTOR (15 downto 0):="0000000000000000";
begin
    q<=count;
    process(clk,en,dir)
    begin
        if rising_edge(clk) then
         if en = '1' then
            if dir = '1' then
                count<=count+1;
            else
                count<=count-1;
            end if;
         end if;
         end if;
    end process;
end Behavioral;
