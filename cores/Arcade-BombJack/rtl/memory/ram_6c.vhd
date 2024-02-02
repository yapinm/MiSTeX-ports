LIBRARY ieee;
USE ieee.std_logic_1164.all;
use	ieee.numeric_std.all;

ENTITY ram_6c IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END ram_6c;


ARCHITECTURE SYN OF ram_6c IS
constant DEPTH        : positive  := 2048;
constant data_width_g : integer   := 8;
subtype  word_t	      is std_logic_vector(data_width_g - 1 downto 0);
type	 ram_t		  is array(0 to DEPTH - 1) of word_t;
signal   ram          :  ram_t;

begin
process (clock)
begin
	if rising_edge(clock) then
		if wren = '1' then
			ram(to_integer(unsigned(address))) <= data;
		end if;
		q <= ram(to_integer(unsigned(address)));
	end if;
end process;
end SYN;