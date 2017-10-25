@echo off
set xv_path=D:\\Programas\\xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto eee66d790eb740e9be0fe0ff951268f2 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot test_imp_sim_behav xil_defaultlib.test_imp_sim -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
