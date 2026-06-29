#####################################################################################
# Description:  Innovus Power Stripe Vertical Complete Script
#####################################################################################

puts "--> 2.5 Add Power Stripe Vertical Complmentation Start."

# User parameters
set MXU_STRIPE_LAYER      M7
set MXU_STRIPE_WIDTH      1.9
set MXU_STRIPE_SPACING    0.6
set MXU_STRIPE_MARGIN     2.8

set MXU_NETS {VDD_MXU VSS_MXU}



# Add stripe mode


setAddStripeMode \
    -stacked_via_bottom_layer M1 \
    -stacked_via_top_layer    M7




# 函数：在指定的X坐标处添加一组 VDD_MXU + VSS_MXU 的垂直stripe，高度范围为y_min到y_max
proc add_mxu_vstripe_group_at_x {x_center y_min y_max} {

    global MXU_STRIPE_LAYER
    global MXU_STRIPE_WIDTH
    global MXU_STRIPE_SPACING
    global MXU_STRIPE_MARGIN
    global MXU_STRIPE_BIG_PITCH
    global MXU_NETS

    set w      $MXU_STRIPE_WIDTH
    set s      $MXU_STRIPE_SPACING
    set margin $MXU_STRIPE_MARGIN

    # Total width of one stripe group:
    # VDD width + spacing + VSS width
    set group_w [expr 2.0 * $w + $s]

    # Ideal group boundary
    set group_l [expr $x_center - $group_w / 2.0]
    set group_r [expr $x_center + $group_w / 2.0]

    # Generation area with small margin
    set area_l  [expr $group_l - $margin]
    set area_r  [expr $group_r + $margin]

    puts "INFO: Add MXU stripe group at x_center = $x_center"
    puts "INFO:   group_l = $group_l, group_r = $group_r"
    puts "INFO:   area    = {$area_l $y_min $area_r $y_max}"

    addStripe \
        -nets $MXU_NETS \
        -layer $MXU_STRIPE_LAYER \
        -direction vertical \
        -width $w \
        -spacing $s \
        -start_offset $margin \
        -number_of_sets 1 \
        -area [list $area_l $y_min $area_r $y_max] \
        -block_ring_bottom_layer_limit M1 \
        -block_ring_top_layer_limit    M7 \
        -padcore_ring_bottom_layer_limit M1 \
        -padcore_ring_top_layer_limit    M7 \
		-create_pins 1 
		# -extend_to design_boundary
}


#####################################################################################
# 使用示例
#####################################################################################

# Example 1:
# Add one stripe group at x = 100.000, from y = 20.000 to y = 300.000
#
# add_mxu_vstripe_group_at_x 149 0 1900


# Example 2:
# Add stripe groups at multiple SRAM gaps


# 在已经打好的stripe的基础上，为sram channel补充stripe，保障供电
set SRAM_GAP_X_LIST {1057 1131 1206}
set SRAM_Y_MIN 0
set SRAM_Y_MAX [expr $core_sizey + 20]

foreach x $SRAM_GAP_X_LIST {
    add_mxu_vstripe_group_at_x $x $SRAM_Y_MIN $SRAM_Y_MAX
}


puts "--> 2.5 Add Power Stripe Vertical Complmentation Done."