#####################################################################################
# Description:  Innovus Generate Output File Script
#####################################################################################

# generate design abstract (LEF) information for the current routed block-level design
# 5.8:              specify the LEF version number
# cutObsMinSpacing: create cut outs in the blockages around pins
# PGpinLayers:      write out power and ground stripes on the specified layer numbers as power and ground pins
# specifyTopLayer:  create obstructions (OBS shapes) covering the block only for layers up to the specified layer
# stripePin:        write out power and ground stripes on the top metal layer as power and ground pins
write_lef_abstract  -5.8 \
                    -cutObsMinSpacing \
                    -PGpinLayers        {M7} \
                    -specifyTopLayer    M7 \
                    -stripePin \
                    ../backup/signoff/${TopName}_postSignoff.lef

# write delays to a Standard Delay Format (SDF) file
# view:                 use the early and late delays for the specified analysis view to populate the min and max SDF triplet slots, the SDF typ slot remains empty
# min_view:             use the early delay from the specified analysis view to populate the SDF min slot
# type_view:            use the late delay from the specified analysis view to populate the SDF typ slot
# max_view:             use the late delay from the specified analysis view to populate the SDF max slot
# recompute_delay_calc: instruct the software to recompute any necessary data required for a complete SDF file before exporting 
write_sdf   -min_view func_tt_typ \
            -typ_view func_tt_typ \
            -max_view func_tt_typ \
            -recompute_delay_calc \
            ../backup/signoff/${TopName}_postSignoff_func_tt_typ.sdf

# -min_view func_ff_0p88v_125c
# -typ_view func_tt_0p80v_25c
# -max_view func_ss_0p72v_m40c

# build a Liberty (.lib) format model for the top cell, which is the timing model equivalent of the original design
# view: specify the current active view
do_extract_model    -view func_tt_typ \
                    ../backup/signoff/${TopName}_postSignoff_func_tt_typ.lib 

set redundant_files [glob -nocomplain "../backup/signoff/model.asrt*"]
foreach redundant_file $redundant_files {
    file delete ${redundant_file}
}

# create a GDSII Stream file of the current database
# mapFile:  specify the file used for layer mapping
# merge:    specify a single file or a list of files to merge
# mode:     identify the layers to write, possible value: ALL | FILLONLY | NOFILL | NOINSTANCES
streamOut   -mapFile    ${streamOut_map} \
            -merge      "${GdsFile}" \
            -mode       ALL \
            -unit       1000 \
            ../backup/signoff/${TopName}_postSignoff.gds2

# write a netlist file of the design for LVS
# excludeCellInst:  exclude the instances of the specified cells from the netlist
# excludeLeafCell:  write I/O instances, macro or block instances and standard cell instances to the netlist, but do not include leaf cell definitions in the netlist
# flat:             write a flattened Verilog netlist
# phys:             write out physical cell instances, insert power and ground nets in the netlist, used for LVS
# topModuleFirst:   write out top module first
saveNetlist -excludeCellInst    ${lvs_exclude_cells} \
            -excludeLeafCell \
            -flat \
            -phys \
            ../backup/signoff/${TopName}_flat_postSignoff.v

saveNetlist -excludeCellInst    ${lvs_exclude_cells} \
            -excludeLeafCell \
            -topModuleFirst \
            ../backup/signoff/${TopName}_hier_postSignoff.v

# generate detailed timing report
timeDesign -outDir ../report/postSignoff -postRoute 
timeDesign -outDir ../report/postSignoff -postRoute -hold 
exec ../scripts/General/extract_report.csh ../report/postSignoff
