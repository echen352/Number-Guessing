if {[file exists work]} {
	vdel -lib work -all
}
vlib work
vmap work work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
vlog -suppress 7061 -sv -work work [pwd]/fsm.sv
vlog -suppress 7061 -sv -work work [pwd]/sevenSeg.sv
vlog -suppress 7061 -sv -work work [pwd]/input_control.sv
vlog -suppress 7061 -sv -work work [pwd]/hint123.sv
vlog -suppress 7061 -sv -work work [pwd]/timer.sv
vlog -suppress 7061 -sv -work work [pwd]/clockdiv.sv
vlog -suppress 7061 -sv -work work [pwd]/top_level.sv
vlog -suppress 7061 -sv -work work [pwd]/get_target_number.sv
vlog -suppress 7061 -sv -work work [pwd]/synch_confirm.sv
vlog -suppress 7061 -sv -work work [pwd]/synch_digit_inputs.sv
vlog -suppress 7061 -sv -work work [pwd]/resetSync.sv
vlog -suppress 7061 -sv -work work [pwd]/test_all.sv

### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelModule with the name of your top level module (no .sv) ###
### Do not duplicate! ###
vsim -voptargs=+acc test_all

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals ###
add wave *
add wave /dut/*
add wave /dut/fHint/*
add wave /dut/fFSM/*
add wave /dut/fGetNum/*

### Force waves here ###

### ---------------------------------------------- ###
### Run simulation ###
### Do not modify ###
# to see your design hierarchy and signals 
view structure 

# to see all signal names and current values
view signals 

### ---------------------------------------------- ###
### Edit run time ###
run 20000 ns

### ---------------------------------------------- ###
### Will create large wave window and zoom to show all signals
view -undock wave
wave zoomfull 
