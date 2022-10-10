transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/Synchronizers.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/Router.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/Reg_4.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/HexDriver.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/Control.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/compute.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/Register_unit.sv}
vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/Processor.sv}

vlog -sv -work work +incdir+D:/ECE385/Lab4/Processor {D:/ECE385/Lab4/Processor/testbench_8.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench_8

add wave *
view structure
view signals
run 1000 ns
