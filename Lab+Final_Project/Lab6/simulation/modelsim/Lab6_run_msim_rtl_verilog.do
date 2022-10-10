transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/HexDriver.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/tristate.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/test_memory.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/SLC3_2.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/Mem2IO.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/ISDU.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/PC.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/Register.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/Bus.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/RegisterFile.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/AddressCalculator.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/ALU.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/NZP.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/slc3.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/memory_contents.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/lab6_toplevel.sv}

vlog -sv -work work +incdir+D:/ECE385/Lab6 {D:/ECE385/Lab6/testbench_week2.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_week2

add wave *
view structure
view signals
run 12000 ns
