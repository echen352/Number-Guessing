if {[file exists work]} {
	vdel -lib work -all
}
vlib work
vmap work work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###
vlog -suppress 7061 -sv -work work [pwd]/hint123.sv
vlog -suppress 7061 -sv -work work [pwd]/test_hint.sv

### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelModule with the name of your top level module (no .sv) ###
### Do not duplicate! ###
vsim -voptargs=+acc test_hint

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals ###
add wave *

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
run 25000 ns

### ---------------------------------------------- ###
### Will create large wave window and zoom to show all signals
view -undock wave
wave zoomfull 
