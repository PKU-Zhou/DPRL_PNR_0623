proc check_bank_2_clk_skew {bank_name} {
    set clk_a_delay [get_property  [report_timing -collection -to ${bank_name}/clka] path_delay]
    set clk_b_delay [get_property  [report_timing -collection -to ${bank_name}/clkb] path_delay]

    set skew [expr $clk_b_delay - $clk_a_delay]

    puts "Bank ${bank_name}clk_a delay: ${clk_a_delay}, clk_b delay: ${clk_b_delay}, skew: ${skew}"

    if { abs($skew) > 0.050 } {
        puts "ERROR: Bank ${bank_name} skew is too large: ${skew}"
    }
}

check_bank_2_clk_skew   u_wgt_buffer/gen_bank_0__u_bank
check_bank_2_clk_skew   u_wgt_buffer/gen_bank_1__u_bank
check_bank_2_clk_skew   u_wgt_buffer/gen_bank_2__u_bank
check_bank_2_clk_skew   u_wgt_buffer/gen_bank_3__u_bank
check_bank_2_clk_skew   u_wgt_buffer/gen_bank_4__u_bank
check_bank_2_clk_skew   u_wgt_buffer/gen_bank_5__u_bank
check_bank_2_clk_skew   u_wgt_buffer/gen_bank_6__u_bank
check_bank_2_clk_skew   u_wgt_buffer/gen_bank_7__u_bank

check_bank_2_clk_skew   u_act_buffer/gen_bank_0__u_bank
check_bank_2_clk_skew   u_act_buffer/gen_bank_1__u_bank
check_bank_2_clk_skew   u_act_buffer/gen_bank_2__u_bank
check_bank_2_clk_skew   u_act_buffer/gen_bank_3__u_bank
check_bank_2_clk_skew   u_act_buffer/gen_bank_4__u_bank
check_bank_2_clk_skew   u_act_buffer/gen_bank_5__u_bank
check_bank_2_clk_skew   u_act_buffer/gen_bank_6__u_bank
check_bank_2_clk_skew   u_act_buffer/gen_bank_7__u_bank

check_bank_2_clk_skew   u_out_buffer/gen_bank_0__u_bank
check_bank_2_clk_skew   u_out_buffer/gen_bank_1__u_bank
check_bank_2_clk_skew   u_out_buffer/gen_bank_2__u_bank
check_bank_2_clk_skew   u_out_buffer/gen_bank_3__u_bank
check_bank_2_clk_skew   u_out_buffer/gen_bank_4__u_bank
check_bank_2_clk_skew   u_out_buffer/gen_bank_5__u_bank
check_bank_2_clk_skew   u_out_buffer/gen_bank_6__u_bank
check_bank_2_clk_skew   u_out_buffer/gen_bank_7__u_bank