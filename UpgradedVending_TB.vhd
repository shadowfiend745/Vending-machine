----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2022 09:13:03 AM
-- Design Name: 
-- Module Name: UpgradedVending_TB - Behavioral
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

entity UpgradedVending_TB is
--  Port ( );
end UpgradedVending_TB;

architecture Behavioral of UpgradedVending_TB is
component UpgradedVending_final is
    Port ( clock,reset,twentyfive,dollar,twodollars,cancel,confirm : in STD_LOGIC;
           dispense,ready,ret,coin,decimal_point : out STD_LOGIC;
           returntwentyfive,returnfifty,returnseventyfive,returndollarfive,returndollartwentyfive,returndollarseventyfive,returndollar : out STD_LOGIC;
           A_G : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end component UpgradedVending_final;
signal clock,reset,twentyfive,dollar,twodollars,cancel,confirm,dispense,ready,ret,coin,decimal_point,returntwentyfive,returnfifty,returnseventyfive,returndollarfive,returndollartwentyfive,returndollarseventyfive,returndollar : STD_LOGIC;
signal A_G : STD_LOGIC_VECTOR (6 downto 0);
signal AN : STD_LOGIC_VECTOR (7 downto 0);
begin
UUT: UpgradedVending_final port map(clock,reset,twentyfive,dollar,twodollars,cancel,confirm,dispense,ready,ret,coin,decimal_point,returntwentyfive,returnfifty,returnseventyfive,returndollarfive,returndollartwentyfive,returndollarseventyfive,returndollar,A_G, AN);
clk: process is 
begin
clock <= '0';
wait for 5ns;
clock <= '1';
wait for 5ns;
end process;
twentyfive <= '0','1' after 57ns, '0' after 77ns, '1' after 107ns, '0' after 127ns, '1' after 257ns, '0' after 287ns, '1' after 417ns, '0' after 437ns, '1' after 457ns, '0' after 477ns, '1' after 537ns, '0' after 557ns, '1' after 717ns, '0' after 737ns, '1' after 757ns, '0' after 777ns, '1' after 797ns, '0' after 817ns;
dollar <= '0', '1' after 287ns, '0' after 317ns, '1' after 477ns, '0' after 497ns, '1' after 627ns, '0' after 657ns;
twodollars <= '0', '1' after 157ns, '0' after 207ns, '1' after 357ns, '0' after 407ns, '1' after 497ns, '0' after 517ns, '1' after 557ns, '0' after 607ns, '1' after 657ns, '0' after 687ns, '1' after 817ns, '0' after 837ns, '1' after 887ns, '0' after 937ns;
confirm <= '0', '1' after 207ns;
end Behavioral;
