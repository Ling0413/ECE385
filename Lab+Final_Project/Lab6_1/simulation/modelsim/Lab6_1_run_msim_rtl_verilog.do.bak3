transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/RegisterFile.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/Register.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/PC.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/NZP.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/HexDriver.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/Bus.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/ALU.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/AddressCalculator.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/tristate.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/test_memory.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/SLC3_2.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/Mem2IO.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/ISDU.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/slc3.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/memory_contents.sv}
vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/lab6_toplevel.sv}

vlog -sv -work work +incdir+C:/Users/11870/Desktop/Lab6_1 {C:/Users/11870/Desktop/Lab6_1/testbench_week2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_week2

add wave *
view structure
view signals
run 5000 ns
