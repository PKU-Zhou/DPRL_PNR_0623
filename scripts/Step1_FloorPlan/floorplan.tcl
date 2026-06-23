#####################################################################################
# Description:  Innovus Floorplan Script
#####################################################################################


puts "--> 1.1 Floorplan Start."

# 默认单位是 um
set core_sizex 1270
set core_sizey 2200

# 四个边距的顺序是Left Bottom Right Top（左、下、右、上）
set core2die_margin 6   
floorPlan -s $core_sizex $core_sizey $core2die_margin $core2die_margin $core2die_margin $core2die_margin

puts "--> 1.1 Floorplan Done."