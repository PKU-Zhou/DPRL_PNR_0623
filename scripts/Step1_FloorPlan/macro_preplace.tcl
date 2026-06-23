#####################################################################################
# Description:  Innovus Macro Preplace Script
#####################################################################################

puts "--> 1.2 Macro Preplace Start."

set bank_width 60.765
set bank_height  318.23


set die_start_x 0
set die_start_y 0
set die_end_x [expr $core_sizex + 2*$core2die_margin]
set die_end_y [expr $core_sizey + 2*$core2die_margin]

# 这两个是手动测量得到的
set core_start_x 6.02
set core_start_y 6
set core_end_x  [expr $die_end_x - $core_start_x]
set core_end_y  [expr $die_end_y - $core_start_y]


# 每组是8个bank
# 组织成 row 行，col 列的形式
set col_num 4
set row_num 2
# bank 之间横向间距是14，纵向贴紧
set x_margin 14
set y_margin 2 
set bank2core_margin 2
set bank_equi_width [expr $bank_width + $x_margin]
set bank_equi_height [expr $bank_height + $y_margin]
set buffer_equi_width [expr $col_num*$bank_equi_width - $x_margin]
set buffer_equi_height [expr $row_num*$bank_equi_height - $y_margin]


# act buffer在core的左上角
# 左下角为起始位置
set act_buffer_start_x [expr $core_start_x + $bank2core_margin]
set act_buffer_start_y [expr $core_end_y - $buffer_equi_height - $bank2core_margin]
set act_buffer_end_x   [expr $act_buffer_start_x + $buffer_equi_width]
set act_buffer_end_y   [expr $act_buffer_start_y + $buffer_equi_height]


# wgt buffer在core的右上角
# 左下角为起始位置
set wgt_buffer_end_x   [expr $core_end_x - $bank2core_margin]
set wgt_buffer_end_y   [expr $core_end_y - $bank2core_margin]
set wgt_buffer_start_x [expr $wgt_buffer_end_x - $buffer_equi_width]
set wgt_buffer_start_y [expr $wgt_buffer_end_y - $buffer_equi_height]


# out buffer在core的左下角
# 左下角为起始位置
set out_buffer_start_x [expr $core_start_x + $bank2core_margin]
set out_buffer_start_y [expr $core_start_y + $bank2core_margin]
set out_buffer_end_x   [expr $out_buffer_start_x + $buffer_equi_width]
set out_buffer_end_y   [expr $out_buffer_start_y + $buffer_equi_height]


placeInstance u_act_buffer/gen_bank_0__u_bank $act_buffer_start_x                             $act_buffer_start_y                             R180 -fixed
placeInstance u_act_buffer/gen_bank_1__u_bank $act_buffer_start_x                             [expr $act_buffer_start_y + $bank_equi_height]  R180 -fixed  
placeInstance u_act_buffer/gen_bank_2__u_bank [expr $act_buffer_start_x + $bank_equi_width]   $act_buffer_start_y                             R180 -fixed
placeInstance u_act_buffer/gen_bank_3__u_bank [expr $act_buffer_start_x + $bank_equi_width]   [expr $act_buffer_start_y + $bank_equi_height]  R180 -fixed
placeInstance u_act_buffer/gen_bank_4__u_bank [expr $act_buffer_start_x + 2*$bank_equi_width] $act_buffer_start_y                             R180 -fixed
placeInstance u_act_buffer/gen_bank_5__u_bank [expr $act_buffer_start_x + 2*$bank_equi_width] [expr $act_buffer_start_y + $bank_equi_height]  R180 -fixed
placeInstance u_act_buffer/gen_bank_6__u_bank [expr $act_buffer_start_x + 3*$bank_equi_width] $act_buffer_start_y                             R180 -fixed
placeInstance u_act_buffer/gen_bank_7__u_bank [expr $act_buffer_start_x + 3*$bank_equi_width] [expr $act_buffer_start_y + $bank_equi_height]  R180 -fixed



placeInstance u_wgt_buffer/gen_bank_0__u_bank $wgt_buffer_start_x                             $wgt_buffer_start_y                             R0 -fixed                           
placeInstance u_wgt_buffer/gen_bank_1__u_bank $wgt_buffer_start_x                             [expr $wgt_buffer_start_y + $bank_equi_height]  R0 -fixed 
placeInstance u_wgt_buffer/gen_bank_2__u_bank [expr $wgt_buffer_start_x + 1*$bank_equi_width] $wgt_buffer_start_y                             R0 -fixed
placeInstance u_wgt_buffer/gen_bank_3__u_bank [expr $wgt_buffer_start_x + 1*$bank_equi_width] [expr $wgt_buffer_start_y + $bank_equi_height]  R0 -fixed
placeInstance u_wgt_buffer/gen_bank_4__u_bank [expr $wgt_buffer_start_x + 2*$bank_equi_width] $wgt_buffer_start_y                             R0 -fixed
placeInstance u_wgt_buffer/gen_bank_5__u_bank [expr $wgt_buffer_start_x + 2*$bank_equi_width] [expr $wgt_buffer_start_y + $bank_equi_height]  R0 -fixed
placeInstance u_wgt_buffer/gen_bank_6__u_bank [expr $wgt_buffer_start_x + 3*$bank_equi_width] $wgt_buffer_start_y                             R0 -fixed
placeInstance u_wgt_buffer/gen_bank_7__u_bank [expr $wgt_buffer_start_x + 3*$bank_equi_width] [expr $wgt_buffer_start_y + $bank_equi_height]  R0 -fixed


placeInstance u_out_buffer/gen_bank_0__u_bank $out_buffer_start_x                             $out_buffer_start_y                             R180 -fixed
placeInstance u_out_buffer/gen_bank_1__u_bank $out_buffer_start_x                             [expr $out_buffer_start_y + $bank_equi_height]  R180 -fixed
placeInstance u_out_buffer/gen_bank_2__u_bank [expr $out_buffer_start_x + 1*$bank_equi_width] $out_buffer_start_y                             R180 -fixed
placeInstance u_out_buffer/gen_bank_3__u_bank [expr $out_buffer_start_x + 1*$bank_equi_width] [expr $out_buffer_start_y + $bank_equi_height]  R180 -fixed
placeInstance u_out_buffer/gen_bank_4__u_bank [expr $out_buffer_start_x + 2*$bank_equi_width] $out_buffer_start_y                             R180 -fixed
placeInstance u_out_buffer/gen_bank_5__u_bank [expr $out_buffer_start_x + 2*$bank_equi_width] [expr $out_buffer_start_y + $bank_equi_height]  R180 -fixed
placeInstance u_out_buffer/gen_bank_6__u_bank [expr $out_buffer_start_x + 3*$bank_equi_width] $out_buffer_start_y                             R180 -fixed
placeInstance u_out_buffer/gen_bank_7__u_bank [expr $out_buffer_start_x + 3*$bank_equi_width] [expr $out_buffer_start_y + $bank_equi_height]  R180 -fixed


puts "--> 1.2 Macro Preplace Done."