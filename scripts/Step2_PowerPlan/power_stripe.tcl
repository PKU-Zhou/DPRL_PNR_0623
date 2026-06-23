#####################################################################################
# Description:  Innovus Add Power Stripe Script
#####################################################################################

puts "--> 2.4 Add Power Stripe Start."

# 先删去之前加上的stripe，防止重复添加
editDelete -use {POWER} -shape {STRIPE} -layer 7

# 设置stripe模式
setAddStripeMode    -stacked_via_bottom_layer   M1 \
                    -stacked_via_top_layer      M7 

# 添加垂直的M7的stripe， 不加横向的stripe
# 宽度/间距等等，需要微调
addStripe   -nets                               { VDD_MXU VSS_MXU } \
			-layer                              M7 \
			-direction                          vertical \
			-width                              1.9 \
			-spacing                            0.6 \
			-set_to_set_distance                18.75 \
			-start_offset                       9.4 \
			-block_ring_bottom_layer_limit      M1 \
			-block_ring_top_layer_limit         M7 \
			-padcore_ring_bottom_layer_limit    M1 \
			-padcore_ring_top_layer_limit       M7


puts "--> 2.4 Add Power Stripe Done."