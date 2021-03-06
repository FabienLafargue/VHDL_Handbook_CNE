-------------------------------------------------------------------------------------------------
-- Company   : CNES
-- Author    : Mickael Carl (CNES)
-- Copyright : Copyright (c) CNES. 
-- Licensing : GNU GPLv3
-------------------------------------------------------------------------------------------------
-- Version         : V1
-- Version history : 
--    V1 : 2015-04-15 : Mickael Carl (CNES): Creation
-------------------------------------------------------------------------------------------------
-- File name          : CNE_01500_bad.vhd
-- File Creation date : 2015-04-15
-- Project name       : VHDL Handbook CNES Edition 
-------------------------------------------------------------------------------------------------
-- Softwares             :  Microsoft Windows (Windows 7) - Editor (Eclipse + VEditor)
-------------------------------------------------------------------------------------------------
-- Description : Handbook example: Identification of custom type name: bad example
--
-- Limitations : This file is an example of the VHDL handbook made by CNES. It is a stub aimed at
--               demonstrating good practices in VHDL and as such, its design is minimalistic.
--               It is provided as is, without any warranty.
--               This example is compliant with the Handbook version 1.
--
-------------------------------------------------------------------------------------------------
-- Naming conventions: 
--
-- i_Port: Input entity port
-- o_Port: Output entity port
-- b_Port: Bidirectional entity port
-- g_My_Generic: Generic entity port
--
-- c_My_Constant: Constant definition 
-- t_My_Type: Custom type definition
--
-- My_Signal_n: Active low signal
-- v_My_Variable: Variable
-- sm_My_Signal: FSM signal
-- pkg_Param: Element Param coming from a package
--
-- My_Signal_re: Rising edge detection of My_Signal
-- My_Signal_fe: Falling edge detection of My_Signal
-- My_Signal_rX: X times registered My_Signal signal
--
-- P_Process_Name: Process
--
-------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CNE_01500_bad is
port  (
      i_Reset_n   : in std_logic;                     -- Reset signal
      i_Clock     : in std_logic;                     -- Clock signal
      i_Addr      : in std_logic_vector(1 downto 0);  -- Address to read from or write to
      i_Rd        : in std_logic;                     -- Read signal
      i_Wr        : in std_logic;                     -- Write signal
      i_Data      : in std_logic;                     -- Incoming data to write
      o_Data      : out std_logic                     -- Data read
   );
end CNE_01500_bad;

--CODE
architecture Behavioral of CNE_01500_bad is
   type reg is array (0 to 3) of std_logic; -- Array for signal registration
   signal D : reg;                          -- Actual signal
   signal Data : std_logic;                 -- Module output
begin
   -- Describes a simple Register bank with Read and Write signals
   P_Register_Bank:process(i_Reset_n, i_Clock)
   begin
      if (i_Reset_n='0') then
         D <= (others => '0');
         Data <= '0';
      elsif (rising_edge(i_Clock)) then
            if (i_Rd='1') then
            -- Read memory
               Data <= D(to_integer(unsigned(i_Addr)));
            elsif (i_Wr='1') then
            -- Write memory
               D(to_integer(unsigned(i_Addr))) <= i_Data;
            end if;
      end if;
   end process;
   
   o_Data <= Data;
end Behavioral;
--CODE