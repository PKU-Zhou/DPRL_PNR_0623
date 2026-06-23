#####################################################################################
# Description:  Innovus Add Halo Script
#####################################################################################

puts "--> 1.3 Add Halo Start."

# act_buffer 的 halo 
set act_buffer_banks [get_cells u_act_buffer/gen_bank_*]

puts "Number of act_buffer banks: [sizeof_collection $act_buffer_banks]"

foreach_in_collection bank $act_buffer_banks {
    # Get current bank name
    set curr_bank_name [get_object_name $bank]
    # Delete old halo if exists
    catch {deleteHaloFromBlock $curr_bank_name}

    # Add placement halo
    addHaloToBlock \
        [list 2 2 2 2] \
        $curr_bank_name
}

puts "1/3 Done: act_buffer halo finished."


# wgt_buffer 的 halo 
set wgt_buffer_banks [get_cells u_wgt_buffer/gen_bank_*]

puts "Number of wgt_buffer banks: [sizeof_collection $wgt_buffer_banks]"

foreach_in_collection bank $wgt_buffer_banks {
    # Get current bank name
    set curr_bank_name [get_object_name $bank]
    # Delete old halo if exists
    catch {deleteHaloFromBlock $curr_bank_name}

    # Add placement halo
    addHaloToBlock \
        [list 2 2 2 2] \
        $curr_bank_name
}

puts "2/3 Done: wgt_buffer halo finished."

############################################################################################
# out_buffer 的 halo 
set out_buffer_banks [get_cells u_out_buffer/gen_bank_*]

puts "Number of out_buffer banks: [sizeof_collection $out_buffer_banks]"

foreach_in_collection bank $out_buffer_banks {
    # Get current bank name
    set curr_bank_name [get_object_name $bank]
    # Delete old halo if exists
    catch {deleteHaloFromBlock $curr_bank_name}

    # Add placement halo
    addHaloToBlock \
        [list 2 2 2 2] \
        $curr_bank_name
}

puts "3/3 Done: out_buffer halo finished."

puts "--> 1.3 Add Halo Done."