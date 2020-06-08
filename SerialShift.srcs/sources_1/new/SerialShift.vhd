library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 
use IEEE.STD_LOGIC_1164.ALL;

entity SerialShift is
    Port ( datain, start, hold : in STD_LOGIC;
           dataout : out STD_LOGIC_VECTOR (7 downto 0));
end SerialShift;

architecture Behavioral of SerialShift is

signal vec_shift : unsigned (7 downto 0) := x"00";
signal shift_done : STD_LOGIC := '0';

begin
process
begin
    for i in 0 to 7 loop
        wait until start'event and start = '1' and hold = '0' ;
        vec_shift    <= shift_right(vec_shift, 1);
        vec_shift(7) <= datain;
    end loop;
    
    shift_done <= '1';
    wait for 10ns;
    shift_done <= '0';
end process;

process 
begin
    dataout <= x"00";
    wait until  shift_done'event and shift_done = '1';
    dataout <= STD_LOGIC_VECTOR(vec_shift);
    wait for 100ns;
end process;

end Behavioral;