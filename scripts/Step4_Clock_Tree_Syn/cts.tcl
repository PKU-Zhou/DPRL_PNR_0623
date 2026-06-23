TODO

# Change MMMC Config
# GUI: timing > MMMC Browser > load mmmc_cts.tcl
# In mmmc_cts.tcl clk should NOT be set to ideal_net by "set_ideal_network [get_ports clk]" !

set_interactive_constraint_modes [all_constraint_modes -active]
source ./src/${TopName}_cts.sdc
set_interactive_constraint_modes {}

# First create spec. and only Once.

# create_ccopt_clock_tree_spec -file ./save/cts/ccopt_cts_spec.tcl

source ./save/cts/ccopt_cts_spec.tcl

# Check if any clk_nets marked as ideal, which will not be synthesized !

# get_db clock_trees .nets -u -if {.is_ideal  ==  true}

set_ccopt_property update_io_latency true
# unit: ns
set_ccopt_property target_skew 0.1

clock_opt_design -check_cts_config

clock_opt_design

set_interactive_constraint_modes [all_constraint_modes -active]
set_propagated_clock [list clk]
set_interactive_constraint_modes {}

saveDesign ./save/clock_opt_design.enc

optDesign -postCTS -drv -outDir ./report/optDesign_postCTS1_drv/ -prefix ./report/optDesign_postCTS1_drv
saveDesign ./save/optDesign_postCTS1_drv.enc

optDesign -postCTS -incr -outDir ./report/optDesign_postCTS2_incr/ -prefix ./report/optDesign_postCTS2_incr
saveDesign ./save/optDesign_postCTS2_incr.enc

optDesign -postCTS -hold -outDir ./report/optDesign_postCTS3_hold/ -prefix ./report/optDesign_postCTS3_hold
timeDesign -postCTS -hold -outDir ./report/optDesign_postCTS3_hold/hold/ -prefix optDesign_postCTS3_hold
saveDesign ./save/optDesign_postCTS3_hold.enc

# mkdir ./report/clock_tree
report_ccopt_clock_trees 			-file ./report/clock_tree/clock_tree.rpt
report_ccopt_skew_groups 			-file ./report/clock_tree/ccopt_skew_groups.rpt
report_ccopt_clock_tree_structure 	-file ./report/clock_tree/clock_tree_structure.rpt





