#####################################################################################
# Description:  Innovus Init Script
#####################################################################################

puts "--> 0.1 Init Start."

set ROOT [file normalize [file join [file dirname [info script]] ../..]]

# ----------------------------------------------------------
# 1. Set the LEF File
# ----------------------------------------------------------
set LefFile {}

set T22 "/data/data_dell/PDK_Tech/TSMC_22NM_RF_ULL"

# Tech LEF (VHV)
lappend LefFile "${T22}/Doc/CL-PR/PRTF_Innovus_22nm_001_Cad_V11_1a/PR_tech/Cadence/LefHeader/VHV/PRTF_Innovus_22nm_9M_6X1Z1UUTRDL_9T.11_1a.tlef"

# Standard Cell LEF
lappend LefFile "${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140_110b/digital/Back_End/lef/tcbn22ullbwp7t30p140_110a/lef/tcbn22ullbwp7t30p140.lef"

lappend LefFile "${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140lvt_110b/digital/Back_End/lef/tcbn22ullbwp7t30p140lvt_110a/lef/tcbn22ullbwp7t30p140lvt.lef"

lappend LefFile "${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140hvt_110b/digital/Back_End/lef/tcbn22ullbwp7t30p140hvt_110a/lef/tcbn22ullbwp7t30p140hvt.lef"

# SRAM IP LEF
lappend LefFile "${ROOT}/src/sram/rf2p_256_128/rf2p_256_128.lef"
lappend LefFile "${ROOT}/src/sram/rf_dcache_half_64x128/rf_dcache_half_64x128.lef"
lappend LefFile "${ROOT}/src/sram/rf_dcache_tag_64x46/rf_dcache_tag_64x46.lef"
lappend LefFile "${ROOT}/src/sram/rf_icache_64x128/rf_icache_64x128.lef"
lappend LefFile "${ROOT}/src/sram/rf_icache_tag_64x48/rf_icache_tag_64x48.lef"
lappend LefFile "${ROOT}/src/sram/rf_vrf_64x64/rf_vrf_64x64.lef"
lappend LefFile "${ROOT}/src/sram/sramdp_272_16/sramdp_272_16.lef"
lappend LefFile "${ROOT}/src/sram/sram_l2_4096x64/sram_l2_4096x64.lef"
lappend LefFile "${ROOT}/src/sram/sramsp_4096_64/sramsp_4096_64.lef"




# ----------------------------------------------------------
# 2. Initialize Innovus
# ----------------------------------------------------------
set TopName $env(TOP)
set MMMCFile "../scripts/Step0_Init/mmmc.tcl"

set init_lef_file ${LefFile}
set init_verilog "${ROOT}/src/netlist/${TopName}_postsyn.v"
set init_top_cell ${TopName}
set init_mmmc_file ${MMMCFile}
set init_pwr_net {VDD_MXU}
set init_gnd_net {VSS_MXU}
setMultiCpuUsage -localCpu 64  -keepLicense true


init_design

setDesignMode   -process            22 \
                -congEffort         auto \
                -earlyClockFlow     false \
                -expressRoute       false \
                -flowEffort         standard \
                -powerEffort        low \
                -bottomRoutingLayer M2 \
                -topRoutingLayer    M7

puts "--> 0.1 Init Done."
