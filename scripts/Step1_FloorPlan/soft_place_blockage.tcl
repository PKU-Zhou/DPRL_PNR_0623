#####################################################################################
# Description:  Innovus Soft Place Blockage Script
#####################################################################################

puts "--> 1.4 Add Soft Place Blockage Start."

# 删除所有soft place blockage
deletePlaceBlockage -all

# 创建soft place blockage
# 首先在GUI界面操作，然后将命令复制到此脚本
createPlaceBlockage -box [expr $act_buffer_start_x-2] [expr $act_buffer_start_y-2] [expr $act_buffer_end_x+2] [expr $act_buffer_end_y+2] -type soft -density 50
createPlaceBlockage -box [expr $wgt_buffer_start_x-2] [expr $wgt_buffer_start_y-2] [expr $wgt_buffer_end_x+2] [expr $wgt_buffer_end_y+2] -type soft -density 50
createPlaceBlockage -box [expr $out_buffer_start_x-2] [expr $out_buffer_start_y-2] [expr $out_buffer_end_x+2] [expr $out_buffer_end_y+2] -type soft -density 50

puts "--> 1.4 Add Soft Place Blockage Done."