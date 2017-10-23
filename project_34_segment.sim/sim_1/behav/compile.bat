@echo off
set xv_path=D:\\Programas\\xilinx\\Vivado\\2017.2\\bin
echo "xvhdl -m64 --incr --relax -prj test_imp_sim_vhdl.prj"
call %xv_path%/xvhdl  -m64 --incr --relax -prj test_imp_sim_vhdl.prj -log xvhdl.log
call type xvhdl.log > compile.log
if "%errorlevel%"=="1" goto END
if "%errorlevel%"=="0" goto SUCCESS
:END
exit 1
:SUCCESS
exit 0
