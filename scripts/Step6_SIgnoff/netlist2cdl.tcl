#####################################################################################
# Description:  Converting Verilog Netlist to CDL format for LVS
#####################################################################################

# ----------------------------------------------------------
#  Set the V2LVS  converting option
# ----------------------------------------------------------
set v2lvs_option "\
        -s ${T22}/PDK/PDK_0.8V_2.5V_1P9M_6X1Z1U_UT_ALRDL_StarRC_QRC/Calibre/lvs/source.added \
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


set cur_dir [pwd]
echo "v2lvs   ${v2lvs_option} \
        -v ${cur_dir}/../backup/signoff/${TopName}_flat_postSignoff.v \
        -o ${cur_dir}/../backup/signoff/${TopName}.cdl" > ../scripts/Step6_SIgnoff/v2lvs_run.csh
exec chmod +x ../scripts/Step6_SIgnoff/v2lvs_run.csh
exec ../scripts/Step6_SIgnoff/v2lvs_run.csh
