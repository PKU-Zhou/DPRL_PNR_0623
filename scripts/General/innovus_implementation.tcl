#####################################################################################
# Description:  Innovus Physical Implementation Main Script
#####################################################################################



#----------Step 0: Initialize----------#
# 如果用makefile启动的话，已经自动执行了，可以跳过
source ../scripts/Step0_Init/init.tcl
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

#----------Step 5: Route---------------#

#----------Step 6: Signoff-------------#
