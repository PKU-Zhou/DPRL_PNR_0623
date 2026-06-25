#####################################################################################
# Description:  Converting Verilog Netlist to CDL format for LVS
#####################################################################################
set cur_dir [pwd]
echo "v2lvs   ${v2lvs_option} \
        -v ${cur_dir}/../backup/signoff/${TopName}_flat_postSignoff.v \
        -o ${cur_dir}/../backup/signoff/${TopName}.cdl" > ../scripts/Step6_SIgnoff/v2lvs_run.csh
exec chmod +x ../scripts/Step6_SIgnoff/v2lvs_run.csh
exec ../scripts/Step6_SIgnoff/v2lvs_run.csh
