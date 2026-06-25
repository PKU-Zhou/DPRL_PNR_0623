#####################################################################################
# Description:  Innovus Init Script
#####################################################################################

puts "--> 0.1 Init Start."

set ROOT [file normalize [file join [file dirname [info script]] ../..]]



set T22 "/data/data_dell/PDK_Tech/TSMC_22NM_RF_ULL"
set streamOut_map "${T22}/PDK/PDK_0.8V_2.5V_1P9M_6X1Z1U_UT_ALRDL_StarRC_QRC/streamOut.map"

# ----------------------------------------------------------
# 1. Set the LEF File
# ----------------------------------------------------------
set LefFile {}

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
# 1.2 Set the GDS File
# ----------------------------------------------------------
set GdsFile {}
# standard cell GDS
lappend GdsFile "${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140_110b/digital/Back_End/gds/tcbn22ullbwp7t30p140_110a/tcbn22ullbwp7t30p140.gds"
lappend GdsFile "${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140lvt_110b/digital/Back_End/gds/tcbn22ullbwp7t30p140lvt_110a/tcbn22ullbwp7t30p140lvt.gds"
lappend GdsFile "${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140hvt_110b/digital/Back_End/gds/tcbn22ullbwp7t30p140hvt_110a/tcbn22ullbwp7t30p140hvt.gds"

# sram ip gds
lappend GdsFile "${ROOT}/src/sram/rf2p_256_128/rf2p_256_128.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_dcache_half_64x128/rf_dcache_half_64x128.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_dcache_tag_64x46/rf_dcache_tag_64x46.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_icache_64x128/rf_icache_64x128.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_icache_tag_64x48/rf_icache_tag_64x48.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_vrf_64x64/rf_vrf_64x64.gds2"
lappend GdsFile "${ROOT}/src/sram/sramdp_272_16/sramdp_272_16.gds2"
lappend GdsFile "${ROOT}/src/sram/sram_l2_4096x64/sram_l2_4096x64.gds2"
lappend GdsFile "${ROOT}/src/sram/sramsp_4096_64/sramsp_4096_64.gds2"

# IO gds
lappend GdsFile "${T22}/IP/Std_IO/tphn22ullgv2od3_c171206_120a/digital/Back_End/gds/tphn22ullgv2od3_c171206_120a/mt_2/9m/9M_6X2Z/tphn22ullgv2od3_c171206.gds"
lappend GdsFile "${T22}/IP/Std_IO/tpbn22v_110a/digital/Back_End/gds/tpbn22v_110a/cup/9m/9M_6X1Z1U/tpbn22v.gds"


# ----------------------------------------------------------
# 1.3 Set the LVS Exclude Cells
# ----------------------------------------------------------
set lvs_exclude_cells [ list \
        TAPCELLBWP7T30P140         \
        DCAP4BWP7T30P140HVT        \
        BOUNDARY_LEFTBWP7T30P140   \
        BOUNDARY_RIGHTBWP7T30P140  \
        FILL2BWP7T30P140           \
        DCAP64BWP7T30P140HVT       \
        DCAP32BWP7T30P140HVT       \
        DCAP16BWP7T30P140HVT       \
        DCAP8BWP7T30P140HVT        \
        DCAP4BWP7T30P140HVT        \
        FILL3BWP7T30P140HVT        \
        FILL2BWP7T30P140HVT        \
        PCORNER                    \
        PFILLER20                  \
        PFILLER10                  \
        PFILLER5                   \
        PFILLER1                   \
        PFILLER05                  \
        PFILLER0005                
]

# ----------------------------------------------------------
# 1.4 Set the V2LVS  converting option
# ----------------------------------------------------------
set v2lvs_option "\
        -s ${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140_110b/digital/Back_End/spice/tcbn22ullbwp7t30p140_110a/tcbn22ullbwp7t30p140_110a.spi \
        -s ${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140lvt_110b/digital/Back_End/spice/tcbn22ullbwp7t30p140lvt_110a/tcbn22ullbwp7t30p140lvt_110a.spi \
        -s ${T22}/IP/Std_Cell/tcbn22ullbwp7t30p140hvt_110b/digital/Back_End/spice/tcbn22ullbwp7t30p140hvt_110a/tcbn22ullbwp7t30p140hvt_110a.spi \
        -s ${T22}/IP/Std_IO/tphn22ullgv2od3_c171206_120a/digital/Back_End/spice/tphn22ullgv2od3_c171206_120a/tphn22ullgv2od3_c171206.spi \
        -s ${ROOT}/src/sram/rf2p_256_128/rf2p_256_128.cdl \
        -s ${ROOT}/src/sram/rf_dcache_half_64x128/rf_dcache_half_64x128.cdl \
        -s ${ROOT}/src/sram/rf_dcache_tag_64x46/rf_dcache_tag_64x46.cdl \
        -s ${ROOT}/src/sram/rf_icache_64x128/rf_icache_64x128.cdl \
        -s ${ROOT}/src/sram/rf_icache_tag_64x48/rf_icache_tag_64x48.cdl \
        -s ${ROOT}/src/sram/rf_vrf_64x64/rf_vrf_64x64.cdl \
        -s ${ROOT}/src/sram/sramdp_272_16/sramdp_272_16.cdl \
        -s ${ROOT}/src/sram/sram_l2_4096x64/sram_l2_4096x64.cdl \
        -s ${ROOT}/src/sram/sramsp_4096_64/sramsp_4096_64.cdl \
"

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


puts "--> 0.1 Init Done."
