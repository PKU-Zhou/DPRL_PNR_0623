#####################################################################################
# Description:  Innovus MMMC Script
#####################################################################################

puts "--> 0.2 MMMC Start."

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



set LibFile_TT {}
lappend LibFile_TT "${PATH_7T_SVT}/tcbn22ullbwp7t30p140tt0p8v25c_hm_ccs.lib"
lappend LibFile_TT "${PATH_7T_LVT}/tcbn22ullbwp7t30p140lvttt0p8v25c_hm_ccs.lib"
lappend LibFile_TT "${PATH_7T_HVT}/tcbn22ullbwp7t30p140hvttt0p8v25c_hm_ccs.lib"
lappend LibFile_TT "${PATH_RF2P_256_128}/rf2p_256_128_tt_typical_0p80v_0p80v_25c.lib"
lappend LibFile_TT "${PATH_RF_DCACHE_HALF_64X128}/rf_dcache_half_64x128_tt_typical_0p80v_0p80v_25c.lib"
lappend LibFile_TT "${PATH_RF_DCACHE_TAG_64X46}/rf_dcache_tag_64x46_tt_typical_0p80v_0p80v_25c.lib"
lappend LibFile_TT "${PATH_RF_ICACHE_64X128}/rf_icache_64x128_tt_typical_0p80v_0p80v_25c.lib"
lappend LibFile_TT "${PATH_RF_ICACHE_TAG_64X48}/rf_icache_tag_64x48_tt_typical_0p80v_0p80v_25c.lib"
lappend LibFile_TT "${PATH_RF_VRF_64X64}/rf_vrf_64x64_tt_typical_0p80v_0p80v_25c.lib"
lappend LibFile_TT "${PATH_SRAMDP_272_16}/sramdp_272_16_tt_typical_0p80v_0p80v_25c.lib"
lappend LibFile_TT "${PATH_SRAM_L2_4096X64}/sram_l2_4096x64_tt_typical_0p80v_0p80v_25c.lib"
lappend LibFile_TT "${PATH_SRAMSP_4096_64}/sramsp_4096_64_tt_typical_0p80v_0p80v_25c.lib"



create_library_set -name lib_tt -timing ${LibFile_TT}


# 2. 定义 RC 寄生参数角 (RC Corners) ---
# 关联不同温度和电容条件的 qrcTechFile
create_rc_corner -name rc_typ -qx_tech_file "${T22}/PDK/PDK_0.8V_2.5V_1P9M_6X1Z1U_UT_ALRDL_StarRC_QRC/QRC/RC_QRC_cln22ulp_1p09m+ut-alrdl_6x1z1u_typical/qrcTechFile" -T 25



# 3. 定义延迟角 (Delay Corners) ---
# 将 [逻辑库] 与 [RC 参数] 绑定在一起
create_delay_corner -name delay_tt_typ   -library_set lib_tt -rc_corner rc_typ	 



# 4. 定义约束模式 (Constraint Modes) ---
# 读取 SDC 时序约束文件
create_constraint_mode -name mode_func -sdc_files "../src/constraint/${TopName}_pnr.sdc"


# 5. 定义分析视图 (Analysis Views) ---
# 最终用于分析的视图：[延迟角] + [约束模式]
create_analysis_view -name func_tt_typ	 -constraint_mode mode_func -delay_corner delay_tt_typ 



# 6. 设置当前分析目标 ---
# 告诉工具：用哪个视图查 Setup，哪个视图查 Hold
set_analysis_view -setup func_tt_typ -hold func_tt_typ

puts "--> 0.2 MMMC Done."