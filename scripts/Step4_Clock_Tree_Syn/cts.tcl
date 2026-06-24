# Change MMMC Config
# GUI: timing > MMMC Browser > load mmmc_cts.tcl
# In mmmc_cts.tcl clk should NOT be set to ideal_net by "set_ideal_network [get_ports clk]" !
# First create spec. and only Once.

# 减去100ps的clock uncertainty （skew部分）
# 原本是0.25，这里降低至0.15
set_interactive_constraint_modes [all_constraint_modes -active]
set_clock_uncertainty -setup 0.15 [get_clocks {SYS_CLK V_SYS_CLK}]
set_interactive_constraint_modes {}


create_ccopt_clock_tree_spec -file ../backup/cts/ccopt_cts_spec.tcl

source ../backup/cts/ccopt_cts_spec.tcl

# Check if any clk_nets marked as ideal, which will not be synthesized !

# get_db clock_trees .nets -u -if {.is_ideal  ==  true}

set_ccopt_property update_io_latency true

# insertion delay
set memory_pin_name_list [get_object_name [get_pins -of_objects \
    [get_cells -hierarchical -filter "is_memory_cell==true"] \
    -filter "is_clock_pin==true"]]

foreach pin_name $memory_pin_name_list {
    set_ccopt_property insertion_delay 0.1 -pin $pin_name
}


# unit: ns
set_ccopt_property target_skew 0.1


# 22版本
ccopt_design -check_prerequisites
ccopt_design


set_interactive_constraint_modes [all_constraint_modes -active]
set_propagated_clock [list SYS_CLK]
set_interactive_constraint_modes {}


timeDesign -postCTS -outDir ../report/postCTS -prefix ${TopName}_postCTS
exec ../scripts/General/extract_report.csh ../report/postCTS

saveDesign ../backup/${TopName}_postCTS.enc


report_ccopt_clock_trees 			-file ../report/postCTS/clock_tree.rpt
report_ccopt_skew_groups 			-file ../report/postCTS/ccopt_skew_groups.rpt
report_ccopt_clock_tree_structure 	-file ../report/postCTS/clock_tree_structure.rpt





