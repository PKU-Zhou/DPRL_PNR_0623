###############################################################################
# PrimeTime timing signoff template
#
# Run from project root:
#   mkdir -p log && pt_shell -file template/primetime.tcl 2>&1 | tee log/primetime.log
###############################################################################

###############################################################################
# 1. Input files and design setup
###############################################################################

set TOP_DESIGN  your_top_design
set NETLIST     /path/to/post_route_netlist.v
set SPEF        /path/to/post_route.spef
set SDC         /path/to/constraints.tcl

set PDK_ROOT    /path/to/pdk

# Fill PrimeTime .db timing libraries directly.
set TIMING_LIBS [list \
    /path/to/stdcell_tt.db \
    /path/to/sram_tt.db \
]

###############################################################################
# 2. Output paths
###############################################################################

set REPORT_DIR  [file normalize ./reports]
set LOG_DIR     [file normalize ./log]

###############################################################################
# 3. Minimal checks and library setup
###############################################################################

foreach input_file [list $NETLIST $SPEF $SDC] {
    if {![file isfile $input_file]} {
        error "Missing input file: $input_file"
    }
}

if {[llength $TIMING_LIBS] == 0} {
    error "TIMING_LIBS is empty. Fill TIMING_LIBS with PrimeTime .db files."
}

foreach lib $TIMING_LIBS {
    if {![file isfile $lib]} {
        error "Missing timing library: $lib"
    }
    if {[file extension $lib] ne ".db"} {
        error "PrimeTime timing library must be a .db file: $lib"
    }
}

file mkdir $REPORT_DIR
file mkdir $LOG_DIR

set lib_dirs {}
foreach lib $TIMING_LIBS {
    lappend lib_dirs [file dirname $lib]
}

set search_path    [lsort -unique [concat [list [file dirname $NETLIST]] $lib_dirs]]
set target_library $TIMING_LIBS
set link_library   [concat "*" $target_library]
set link_path      $link_library

set_app_var search_path    $search_path
set_app_var target_library $target_library
set_app_var link_library   $link_library
set_app_var link_path      $link_path

puts "PrimeTime timing setup"
puts "  top design : $TOP_DESIGN"
puts "  netlist    : $NETLIST"
puts "  spef       : $SPEF"
puts "  sdc        : $SDC"
puts "  pdk root   : $PDK_ROOT"
puts "  libraries  : [llength $TIMING_LIBS]"
puts "  reports    : $REPORT_DIR"
puts "  logs       : $LOG_DIR"

###############################################################################
# 4. PrimeTime analysis flow
###############################################################################

read_verilog $NETLIST
link_design $TOP_DESIGN

source $SDC

read_parasitics -format spef $SPEF
update_timing

###############################################################################
# 5. Reports
###############################################################################

redirect -file [file join $REPORT_DIR check_timing.rpt] {
    check_timing -verbose
}

redirect -file [file join $REPORT_DIR constraints.rpt] {
    report_constraint -all_violators -nosplit
}

redirect -file [file join $REPORT_DIR timing_setup.rpt] {
    report_timing -delay_type max -max_paths 50 -nosplit -input_pins -nets -transition_time -capacitance
}

redirect -file [file join $REPORT_DIR timing_hold.rpt] {
    report_timing -delay_type min -max_paths 50 -nosplit -input_pins -nets -transition_time -capacitance
}

redirect -file [file join $REPORT_DIR qor.rpt] {
    report_qor
}

redirect -file [file join $REPORT_DIR clocks.rpt] {
    report_clock -skew -attribute
}

redirect -file [file join $REPORT_DIR annotated_parasitics.rpt] {
    report_annotated_parasitics -list_not_annotated
}

puts "PrimeTime reports written to $REPORT_DIR"
puts "Recommended run command: mkdir -p $LOG_DIR && pt_shell -file template/primetime.tcl 2>&1 | tee [file join $LOG_DIR primetime.log]"

exit
