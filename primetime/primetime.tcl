###############################################################################
# PrimeTime timing signoff template
#
# Run from project root:
#   mkdir -p log && pt_shell -file template/primetime.tcl 2>&1 | tee log/primetime.log
###############################################################################

###############################################################################
# 1. Input files and design setup
###############################################################################

set TOP_DESIGN  mxu_top
set NETLIST     ../backup/signoff/${TOP_DESIGN}_hier_postSignoff.v
set SPEF        ../backup/signoff/${TOP_DESIGN}_postSignoff_rc_typ.spef
set MODE_FUNC_SDC         ../backup/${TOP_DESIGN}_postSignoff.enc.dat/mmmc/modes/mode_func/mode_func.sdc
set LATENCY_SDC ../backup/${TOP_DESIGN}_postSignoff.enc.dat/mmmc/views/func_tt_typ/latency.sdc


set ROOT [file normalize [file join [file dirname [info script]] ..]]
set T22 "/data/data_dell/PDK_Tech/TSMC_22NM_RF_ULL"

# 1. 定义库集合 (Library Sets) ---
# 将之前整理好的 .lib 列表直接关联到 Corner 名称上
set PATH_7T_SVT		"${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140_110b/digital/Front_End/timing_power_noise/CCS/tcbn22ullbwp7t30p140_110b"
set PATH_7T_LVT  	"${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140lvt_110b/digital/Front_End/timing_power_noise/CCS/tcbn22ullbwp7t30p140lvt_110b"
set PATH_7T_HVT		"${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140hvt_110b/digital/Front_End/timing_power_noise/CCS/tcbn22ullbwp7t30p140hvt_110b"

# set PATH_RF			"${ROOT}/src/sram"
set PATH_RF2P_256_128              "${ROOT}/src/sram/rf2p_256_128"
set PATH_RF_DCACHE_HALF_64X128     "${ROOT}/src/sram/rf_dcache_half_64x128"
set PATH_RF_DCACHE_TAG_64X46       "${ROOT}/src/sram/rf_dcache_tag_64x46"
set PATH_RF_ICACHE_64X128          "${ROOT}/src/sram/rf_icache_64x128"
set PATH_RF_ICACHE_TAG_64X48       "${ROOT}/src/sram/rf_icache_tag_64x48"
set PATH_RF_VRF_64X64              "${ROOT}/src/sram/rf_vrf_64x64"
set PATH_SRAMDP_272_16             "${ROOT}/src/sram/sramdp_272_16"
set PATH_SRAM_L2_4096X64           "${ROOT}/src/sram/sram_l2_4096x64"
set PATH_SRAMSP_4096_64            "${ROOT}/src/sram/sramsp_4096_64"

set TIMING_LIBS [list \
    ${PATH_7T_SVT}/tcbn22ullbwp7t30p140tt0p8v25c_hm_ccs.db \
    ${PATH_7T_LVT}/tcbn22ullbwp7t30p140lvttt0p8v25c_hm_ccs.db \
    ${PATH_7T_HVT}/tcbn22ullbwp7t30p140hvttt0p8v25c_hm_ccs.db \
    ${PATH_RF2P_256_128}/rf2p_256_128_tt_typical_0p80v_0p80v_25c.db \
    ${PATH_RF_DCACHE_HALF_64X128}/rf_dcache_half_64x128_tt_typical_0p80v_0p80v_25c.db \
    ${PATH_RF_DCACHE_TAG_64X46}/rf_dcache_tag_64x46_tt_typical_0p80v_0p80v_25c.db \
    ${PATH_RF_ICACHE_64X128}/rf_icache_64x128_tt_typical_0p80v_0p80v_25c.db \
    ${PATH_RF_ICACHE_TAG_64X48}/rf_icache_tag_64x48_tt_typical_0p80v_0p80v_25c.db \
    ${PATH_RF_VRF_64X64}/rf_vrf_64x64_tt_typical_0p80v_0p80v_25c.db \
    ${PATH_SRAMDP_272_16}/sramdp_272_16_tt_typical_0p80v_0p80v_25c.db \
    ${PATH_SRAM_L2_4096X64}/sram_l2_4096x64_tt_typical_0p80v_0p80v_25c.db \
    ${PATH_SRAMSP_4096_64}/sramsp_4096_64_tt_typical_0p80v_0p80v_25c.db \
]



###############################################################################
# 2. Output paths
###############################################################################

set REPORT_DIR  [file normalize ./reports]
set LOG_DIR     [file normalize ./logs]

###############################################################################
# 3. Minimal checks and library setup
###############################################################################

foreach input_file [list $NETLIST $SPEF $MODE_FUNC_SDC $LATENCY_SDC] {
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
puts "  sdc        : $MODE_FUNC_SDC $LATENCY_SDC"
puts "  libraries  : [llength $TIMING_LIBS]"
puts "  reports    : $REPORT_DIR"
puts "  logs       : $LOG_DIR"

###############################################################################
# 4. PrimeTime analysis flow
###############################################################################

read_verilog $NETLIST
link_design $TOP_DESIGN

source $MODE_FUNC_SDC
source $LATENCY_SDC

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

# exit
