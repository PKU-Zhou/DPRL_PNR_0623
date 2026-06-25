#####################################################################################
# Description:  Innovus Physical Implementation Main Script
#####################################################################################



#----------Step 0: Initialize----------#
# 如果用makefile启动的话，已经自动执行了，可以跳过
source ../scripts/Step0_Init/init_config.tcl
source ../scripts/Step0_Init/mmmc.tcl

#----------Step 1: FloorPlan-----------#
source ../scripts/Step1_FloorPlan/floorplan.tcl
source ../scripts/Step1_FloorPlan/macro_preplace.tcl
source ../scripts/Step1_FloorPlan/halo_blockage.tcl
source ../scripts/Step1_FloorPlan/soft_place_blockage.tcl
source ../scripts/Step1_FloorPlan/pin_add.tcl


#----------Step 2: Power Plan----------#
source ../scripts/Step2_PowerPlan/global_net_connect.tcl
source ../scripts/Step2_PowerPlan/power_ring.tcl
source ../scripts/Step2_PowerPlan/power_route.tcl
source ../scripts/Step2_PowerPlan/power_stripe.tcl

# 如果sram bank之间的channel已经有了stripe，则这一步可以跳过
source ../scripts/Step2_PowerPlan/power_stripe_ver_comple.tcl

source ../scripts/Step2_PowerPlan/power_check.tcl

saveDesign ../backup/${TopName}_postPowerplan.enc

#----------Step 3: Placement-----------#
source ../scripts/Step3_Placement/insert_physical_cell.tcl
source ../scripts/Step3_Placement/place.tcl

# 如果上一步检查timing和drv没有问题，可以跳过这一步
source ../scripts/Step3_Placement/place_incr.tcl

# 以上两步都会自动saveDesign


#----------Step 4: CTS-----------------#
source ../scripts/Step4_Clock_Tree_Syn/cts.tcl

source ../scripts/Step4_Clock_Tree_Syn/cts_opt.tcl

#----------Step 5: Route---------------#
source ../scripts/Step5_Routing/route.tcl  

# 如果timing和drv没什么问题，可以跳过这一步
source ../scripts/Step5_Routing/optDesign_postRoute.tcl

# 修DRC之前先配置好ECO模式
source ../scripts/Step5_Routing/ecoRoute_config.tcl

# 不要执行这个脚本！
# 打开脚本查看命令，手动执行
source ../scripts/Step5_Routing/fixDrc.tcl


#----------Step 6: Signoff-------------#
source ../scripts/Step6_SIgnoff/addFiller.tcl
source ../scripts/Step6_SIgnoff/PG_pin.tcl
source ../scripts/Step6_SIgnoff/file_gen.tcl


source ../scripts/Step6_SIgnoff/netlist2cdl.tcl

saveDesign ../backup/${TopName}_postSignoff.enc
