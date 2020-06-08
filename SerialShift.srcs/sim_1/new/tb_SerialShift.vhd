library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 
use IEEE.STD_LOGIC_1164.ALL;

entity tb_SerialShift is
--  Port ( );
end tb_SerialShift;

architecture Behavioral of tb_SerialShift is
COMPONENT SerialShift
     Port ( datain, start, hold : in STD_LOGIC;
           dataout : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT;

signal datain, start, hold : STD_LOGIC;
signal dataout : STD_LOGIC_VECTOR (7 downto 0);

begin
U1: SerialShift
   port map (datain=>datain,start=>start,hold=>hold,dataout=>dataout);
   
process
variable inbit : std_logic_vector (3 downto 0);

begin
    datain <= '0';
    start <= '0';
    hold <= '0';
    wait for 10ns;
    for i in 0 to 7 loop  -- without hold = '1'
        inbit := std_logic_vector(to_unsigned(i , 4));
        datain <= not (inbit(1) or inbit(0) );
        start <= '1';
        wait for 10ns;
        start <= '0';
        wait for 10ns;
    end loop;
    
    inbit := "0000";
    wait for 10ns;

    start <= '0';
    datain <= '0';
    hold <= '0';
    wait for 150ns;
    
    for i in 0 to 15 loop  -- with hold = '1' between i = 3 to 8
        inbit := std_logic_vector(to_unsigned(i , 4));
        if i = 3 then
            hold <= '1';
        elsif i = 8 then
            hold <= '0'; 
        end if;
        datain <=  not (inbit(1) or inbit(0) );     
        start <= '1';
        wait for 10ns;
        start <= '0';
        wait for 10ns;
    end loop;

wait;

end process;
end Behavioral;
