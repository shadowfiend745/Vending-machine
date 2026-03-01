----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2022 10:10:00 AM
-- Design Name: 
-- Module Name: UpgradedVending_final - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UpgradedVending_final is
    Port ( clock,reset,twentyfive,dollar,twodollars,cancel,confirm : in STD_LOGIC;
           dispense,ready,ret,coin,decimal_point : out STD_LOGIC;
           returntwentyfive,returnfifty,returnseventyfive,returndollarfive,returndollartwentyfive,returndollarseventyfive,returndollar : out STD_LOGIC;
           A_G : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end UpgradedVending_final;

architecture Behavioral of UpgradedVending_final is
component segment_display_bdong is
    Port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);
           A_G : out STD_LOGIC_VECTOR (6 downto 0));
end component segment_display_bdong;
component EIGHT_TO_ONE_BD is
    Port ( CLK : in STD_LOGIC;
           d0 : in STD_LOGIC_VECTOR (3 downto 0);
           d1 : in STD_LOGIC_VECTOR (3 downto 0);
           d2 : in STD_LOGIC_VECTOR (3 downto 0);
           d3 : in STD_LOGIC_VECTOR (3 downto 0);
           d4 : in STD_LOGIC_VECTOR (3 downto 0);
           d5 : in STD_LOGIC_VECTOR (3 downto 0);
           d6 : in STD_LOGIC_VECTOR (3 downto 0);
           d7 : in STD_LOGIC_VECTOR (3 downto 0);
           display_number : out STD_LOGIC_VECTOR (3 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           decimal_point: out STD_LOGIC);
end component EIGHT_TO_ONE_BD;
component Debounce_bdong is
    Port ( Sense_switch : in STD_LOGIC;
           CLK : in STD_LOGIC;
           signal_s : out STD_LOGIC);
end component Debounce_bdong;
component D_ff_bdong is
    Port ( D : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qbar : out STD_LOGIC);
end component D_ff_bdong;
type state_type is (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X);
signal present_state, next_state: state_type;
signal BCD0,BCD1,BCD2,BCD3,BCD4,BCD5,BCD6,BCD7,display_number:std_logic_vector(3 downto 0);
signal twentyfivedb,dollardb,twodollarsdb:std_logic;
begin
g1: segment_display_bdong port map (display_number, A_G);
g2: EIGHT_TO_ONE_BD port map (clock,BCD0,BCD1,BCD2,BCD3,BCD4,BCD5,BCD6,BCD7,display_number,AN,decimal_point);
D1: Debounce_bdong port map(twentyfive, clock, twentyfivedb);
D2: Debounce_bdong port map(dollar, clock, dollardb);
D3: Debounce_bdong port map(twodollars, clock, twodollarsdb);
BCD3<="0000";
BCD4<="0000";
BCD5<="0000";
BCD6<="0000";
BCD7<="0000";
seq:process(clock,reset)is
begin
if(reset='1')then
present_state<=A;
elsif(rising_edge(clock))
then
present_state<=next_state;
end if;
end process seq;

state_tran:process(twentyfivedb,dollardb,twodollarsdb,confirm,cancel,present_state)is
begin
case present_state is
when A =>
if (cancel = '1') then
next_state <= I;
elsif (twentyfivedb = '1') then
next_state <= B;
elsif (dollardb = '1') then
next_state <= E;
elsif (twodollarsdb = '1') then
next_state <= Q;
else
next_state <= A;
end if;

when B =>
if (cancel = '1') then
next_state <= I;
elsif (twentyfivedb = '1') then
next_state <= C;
elsif (dollardb = '1') then
next_state <= D;
elsif (twodollarsdb = '1') then
next_state <= R;
else
next_state <= B;
end if; 

when C =>
if (cancel = '1') then
next_state <= I;
elsif (twentyfivedb = '1') then
next_state <= G;
elsif (dollardb = '1') then
next_state <= F;
elsif (twodollarsdb = '1') then
next_state <= S;
else
next_state <= C;
end if;

when D =>
if (cancel = '1') then
next_state <= I;
elsif (twentyfivedb = '1') then
next_state <= F;
elsif (dollardb = '1') then
next_state <= R;
elsif (twodollarsdb = '1') then
next_state <= T;
else
next_state <= D;
end if;

when E =>
if (cancel = '1') then
next_state <= I;
elsif (twentyfivedb = '1') then
next_state <= D;
elsif (dollardb = '1') then
next_state <= Q;
elsif (twodollarsdb = '1') then
next_state <= U;
else
next_state <= E;
end if;

when F =>
if (cancel = '1') then
next_state <= I;
elsif (twentyfivedb = '1') then
next_state <= V;
elsif (dollardb = '1') then
next_state <= S;
elsif (twodollarsdb = '1') then
next_state <= W;
else
next_state <= F;
end if;

when G =>
if (cancel = '1') then
next_state <= I;
elsif (twentyfivedb = '1') then
next_state <= E;
elsif (dollardb = '1') then
next_state <= V;
elsif (twodollarsdb = '1') then
next_state <= X;
else
next_state <= G;
end if;

when H =>
next_state <= A;

when I =>
next_state <= A;

when Q =>
if (confirm = '1') then
next_state <= J;
else
next_state <= Q;
end if;

when R =>
if (confirm = '1') then
next_state <= L;
else
next_state <= R;
end if;

when S =>
if (confirm = '1') then
next_state <= K;
else
next_state <= S;
end if;

when T =>
if (confirm = '1') then
next_state <= M;
else
next_state <= T;
end if;

when U =>
if (confirm = '1') then
next_state <= N;
else
next_state <= U;
end if;

when V =>
if (confirm = '1') then
next_state <= H;
else
next_state <= V;
end if;

when W =>
if (confirm = '1') then
next_state <= O;
else
next_state <= W;
end if;

when X =>
if (confirm = '1') then
next_state <= P;
else
next_state <= X;
end if;

when J =>
next_state <= H;
when L =>
next_state <= H;
when K =>
next_state <= H;
when M =>
next_state <= H;
when N =>
next_state <= H;
when O =>
next_state <= H;
when P =>
next_state <= H;
end case;
end process state_tran;

output: process (present_state) is
begin
case present_state is
when A =>
Ready <= '1';
dispense <= '0';
ret <= '0';
coin <= '0';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0000";
BCD1 <= "0000";
BCD0 <= "0000";

when B =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0000";
BCD1 <= "0010";
BCD0 <= "0101";

when C =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0000";
BCD1 <= "0101";
BCD0 <= "0000";

when D =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0001";
BCD1 <= "0010";
BCD0 <= "0101";

when E =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0001";
BCD1 <= "0000";
BCD0 <= "0000";



when F =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0001";
BCD1 <= "0101";
BCD0 <= "0000";

when G =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0000";
BCD1 <= "0111";
BCD0 <= "0101";

when H =>
Ready <= '0';
dispense <= '1';
ret <= '0';
coin <= '0';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';

when I =>
Ready <= '0';
dispense <= '0';
ret <= '1';
coin <= '0';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';

when Q =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0010";
BCD1 <= "0000";
BCD0 <= "0000";

when R =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0010";
BCD1 <= "0010";
BCD0 <= "0101";

when S =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0010";
BCD1 <= "0101";
BCD0 <= "0000";

when T =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0011";
BCD1 <= "0010";
BCD0 <= "0101";

when U =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0011";
BCD1 <= "0000";
BCD0 <= "0000";

when V =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0001";
BCD1 <= "0111";
BCD0 <= "0101";

when W =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0011";
BCD1 <= "0101";
BCD0 <= "0000";

when X =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0010";
BCD1 <= "0111";
BCD0 <= "0101";

when J =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '1';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0000";
BCD1 <= "0010";
BCD0 <= "0101";

when K =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '1';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0000";
BCD1 <= "0111";
BCD0 <= "0101";

when L =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '1';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0000";
BCD1 <= "0101";
BCD0 <= "0000";

when M =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '1';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0001";
BCD1 <= "0101";
BCD0 <= "0000";

when N =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '1';
returndollarseventyfive <= '0';
returndollar <= '0';
BCD2 <= "0001";
BCD1 <= "0010";
BCD0 <= "0101";

when O =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '1';
returndollar <= '0';
BCD2 <= "0001";
BCD1 <= "0111";
BCD0 <= "0101";

when P =>
Ready <= '0';
dispense <= '0';
ret <= '0';
coin <= '1';
returntwentyfive <= '0';
returnfifty <= '0';
returnseventyfive <= '0';
returndollarfive <= '0';
returndollartwentyfive <= '0';
returndollarseventyfive <= '0';
returndollar <= '1';
BCD2 <= "0001";
BCD1 <= "0000";
BCD0 <= "0000";

end case;
end process output;
end Behavioral;
