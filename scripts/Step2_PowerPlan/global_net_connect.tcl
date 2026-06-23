#####################################################################################
# Description:  Innovus Connect Power & Ground Net Globally Script
#####################################################################################



puts "--> 2.1 Global Net Connect Start."

# 所有标准单元的 VDD pin -> VDD_MXU
# 所有标准单元的 VSS pin -> VSS_MXU
globalNetConnect VDD_MXU -type pgpin -pin VDD -all -override
globalNetConnect VSS_MXU -type pgpin -pin VSS -all -override


# 以下代码是为了把sram中的vdd和vss分别绑定到VDD_MXU和VSS_MXU
set act_buffer_banks [get_cells u_act_buffer/gen_bank_*]
foreach_in_collection bank $act_buffer_banks {
    set curr_bank_name [get_object_name $bank]

    puts "Connect ACT buffer SRAM PG pins for $curr_bank_name"

    globalNetConnect VDD_MXU -type pgpin -pin VDDCE -sinst $curr_bank_name -override
    globalNetConnect VDD_MXU -type pgpin -pin VDDPE -sinst $curr_bank_name -override
    globalNetConnect VSS_MXU -type pgpin -pin VSSE  -sinst $curr_bank_name -override
}



set wgt_buffer_banks [get_cells u_wgt_buffer/gen_bank_*]
foreach_in_collection bank $wgt_buffer_banks {
    set curr_bank_name [get_object_name $bank]

    puts "Connect WGT buffer SRAM PG pins for $curr_bank_name"

    globalNetConnect VDD_MXU -type pgpin -pin VDDCE -sinst $curr_bank_name -override
    globalNetConnect VDD_MXU -type pgpin -pin VDDPE -sinst $curr_bank_name -override
    globalNetConnect VSS_MXU -type pgpin -pin VSSE  -sinst $curr_bank_name -override
}



set out_buffer_banks [get_cells u_out_buffer/gen_bank_*]
foreach_in_collection bank $out_buffer_banks {
    set curr_bank_name [get_object_name $bank]

    puts "Connect OUT buffer SRAM PG pins for $curr_bank_name"

    globalNetConnect VDD_MXU -type pgpin -pin VDDCE -sinst $curr_bank_name -override
    globalNetConnect VDD_MXU -type pgpin -pin VDDPE -sinst $curr_bank_name -override
    globalNetConnect VSS_MXU -type pgpin -pin VSSE  -sinst $curr_bank_name -override
}


# tie-high -> VDD_MXU
# tie-low  -> VSS_MXU
globalNetConnect VDD_MXU -type tiehi
globalNetConnect VSS_MXU -type tielo


puts "--> 2.1 Global Net Connect Done."