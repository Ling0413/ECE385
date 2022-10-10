transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/ECE385/Lab5 {D:/ECE385/Lab5/HexDriver.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab5 {D:/ECE385/Lab5/FullAdder.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab5 {D:/ECE385/Lab5/ControlUnit.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab5 {D:/ECE385/Lab5/ShiftRegister.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab5 {D:/ECE385/Lab5/Multiplier.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab5 {D:/ECE385/Lab5/lab5_toplevel.sv}

vlog -sv -work work +incdir+D:/ECE385/Lab5 {D:/ECE385/Lab5/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 6000 ns
