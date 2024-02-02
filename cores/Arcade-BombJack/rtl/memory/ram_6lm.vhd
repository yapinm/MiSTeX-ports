LIBRARY ieee;
USE ieee.std_logic_1164.all;
use	ieee.numeric_std.all;

ENTITY ram_6lm IS
	generic (
		 addr_width_g : integer := 11;
		 data_width_g : integer := 8
	); 
	PORT
	(
		address_a	: IN STD_LOGIC_VECTOR (addr_width_g-1 DOWNTO 0);
		address_b	: IN STD_LOGIC_VECTOR (addr_width_g-1 DOWNTO 0);
		clock_a		: IN STD_LOGIC  := '1';
		clock_b		: IN STD_LOGIC;
		data_a		: IN STD_LOGIC_VECTOR (data_width_g-1 DOWNTO 0);
		data_b		: IN STD_LOGIC_VECTOR (data_width_g-1 DOWNTO 0) := (others => '0');
		enable_a		: IN STD_LOGIC  := '1';
		enable_b		: IN STD_LOGIC  := '1';
		wren_a		: IN STD_LOGIC  := '0';
		wren_b		: IN STD_LOGIC  := '0';
		q_a			: OUT STD_LOGIC_VECTOR (data_width_g-1 DOWNTO 0);
		q_b			: OUT STD_LOGIC_VECTOR (data_width_g-1 DOWNTO 0)
	);
END ram_6lm;


ARCHITECTURE SYN OF ram_6lm IS
constant DEPTH        :  positive := 2**addr_width_g;
subtype  word_t	      is std_logic_vector(data_width_g - 1 downto 0);
type	 ram_t		  is array(0 to DEPTH - 1) of word_t;
signal   ram          :  ram_t;
BEGIN
process (clock_a, clock_b)
begin
	if rising_edge(clock_a) then
		if enable_a = '1' then
			if wren_a = '1' then
				ram(to_integer(unsigned(address_a))) <= data_a;
			end if;
			q_a <= ram(to_integer(unsigned(address_a)));
		end if;
	end if;
	if rising_edge(clock_b) then
		if enable_b = '1' then
			if wren_b = '1' then
				ram(to_integer(unsigned(address_b))) <= data_b;
			end if;
			q_b <= ram(to_integer(unsigned(address_b)));
		end if;
	end if;
end process;
END ARCHITECTURE;
