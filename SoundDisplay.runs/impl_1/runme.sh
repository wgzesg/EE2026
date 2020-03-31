#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# 

<<<<<<< HEAD
echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=C:/Xilinx/SDK/2018.2/bin;C:/Xilinx/Vivado/2018.2/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2018.2/ids_lite/ISE/lib/nt64:C:/Xilinx/Vivado/2018.2/bin
else
  PATH=C:/Xilinx/SDK/2018.2/bin;C:/Xilinx/Vivado/2018.2/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2018.2/ids_lite/ISE/lib/nt64:C:/Xilinx/Vivado/2018.2/bin:$PATH
=======
if [ -z "$PATH" ]; then
  PATH=/home/wgzesg/SDK/2018.2/bin:/home/wgzesg/Vivado/2018.2/ids_lite/ISE/bin/lin64:/home/wgzesg/Vivado/2018.2/bin
else
  PATH=/home/wgzesg/SDK/2018.2/bin:/home/wgzesg/Vivado/2018.2/ids_lite/ISE/bin/lin64:/home/wgzesg/Vivado/2018.2/bin:$PATH
>>>>>>> 2df6aee9930837762d1bca2ec291f2320556f75e
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
<<<<<<< HEAD
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='C:/Users/26012/Desktop/EE2026-master/SoundDisplay.runs/impl_1'
=======
  LD_LIBRARY_PATH=/home/wgzesg/Vivado/2018.2/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/home/wgzesg/Vivado/2018.2/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/wgzesg/Desktop/finalProject/EE2026/SoundDisplay.runs/impl_1'
>>>>>>> 2df6aee9930837762d1bca2ec291f2320556f75e
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log Top_Student.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source Top_Student.tcl -notrace


