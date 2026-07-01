#####################################################################################
# Description:  Innovus Generate Output File Script
#####################################################################################

# Hcell list
set std_cell_list [dbGet head.libCells.name]
foreach cell $std_cell_list {echo "$cell $cell" >> ../backup/signoff/hcell.list}


# generate design abstract (LEF) information for the current routed block-level design
# 5.8:              specify the LEF version number
# cutObsMinSpacing: create cut outs in the blockages around pins
# PGpinLayers:      write out power and ground stripes on the specified layer numbers as power and ground pins
# specifyTopLayer:  create obstructions (OBS shapes) covering the block only for layers up to the specified layer
# stripePin:        write out power and ground stripes on the top metal layer as power and ground pins
write_lef_abstract  -5.8 \
                    -cutObsMinSpacing \
                    -PGpinLayers        {M6 M7} \
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






# sram ip gds
lappend GdsFile "${ROOT}/src/sram/rf2p_256_128/rf2p_256_128.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_dcache_half_64x128/rf_dcache_half_64x128.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_dcache_tag_64x46/rf_dcache_tag_64x46.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_icache_64x128/rf_icache_64x128.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_icache_tag_64x48/rf_icache_tag_64x48.gds2"
lappend GdsFile "${ROOT}/src/sram/rf_vrf_64x64/rf_vrf_64x64.gds2"
lappend GdsFile "${ROOT}/src/sram/sramdp_272_16/sramdp_272_16.gds2"
lappend GdsFile "${ROOT}/src/sram/sram_l2_4096x64/sram_l2_4096x64.gds2"
lappend GdsFile "${ROOT}/src/sram/sramsp_4096_64/sramsp_4096_64.gds2"

# IO gds
lappend GdsFile "${T22}/IP/Std_IO/tphn22ullgv2od3_c171206_120a/digital/Back_End/gds/tphn22ullgv2od3_c171206_120a/mt_2/9m/9M_6X2Z/tphn22ullgv2od3_c171206.gds"
lappend GdsFile "${T22}/IP/Std_IO/tpbn22v_110a/digital/Back_End/gds/tpbn22v_110a/cup/9m/9M_6X1Z1U/tpbn22v.gds"


# create a GDSII Stream file of the current database
# mapFile:  specify the file used for layer mapping
# merge:    specify a single file or a list of files to merge
# mode:     identify the layers to write, possible value: ALL | FILLONLY | NOFILL | NOINSTANCES
# //TODO:  之后重新merge          
# //TODO:  之后重新mode

set streamOut_map "${T22}/Doc/CL-PR/PRTF_Innovus_22nm_001_Cad_V11_1a/PR_tech/Cadence/GdsOutMap/PRTF_Innovus_22nm_9M_6X1Z1U.11_1a.map"

streamOut   -mapFile    ${streamOut_map} \
            -merge      "${GdsFile}" \
            -mode       ALL \
            -unit       1000 \
            ../backup/signoff/${TopName}_postSignoff.gds2





# ----------------------------------------------------------
#  Set the LVS Exclude Cells
# ----------------------------------------------------------
set lvs_exclude_cells [ list \
        TAPCELLBWP7T30P140         \
        DCAP4BWP7T30P140HVT        \
        BOUNDARY_LEFTBWP7T30P140   \
        BOUNDARY_RIGHTBWP7T30P140  \
        FILL2BWP7T30P140           \
        DCAP64BWP7T30P140       \
        DCAP32BWP7T30P140       \
        DCAP16BWP7T30P140       \
        DCAP8BWP7T30P140        \
        DCAP4BWP7T30P140        \
        FILL3BWP7T30P140        \
        FILL2BWP7T30P140        \
        PCORNER                    \
        PFILLER20                  \
        PFILLER10                  \
        PFILLER5                   \
        PFILLER1                   \
        PFILLER05                  \
        PFILLER0005                
]



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

# 不用flat

saveNetlist -excludeCellInst    ${lvs_exclude_cells} \
            -excludeLeafCell \
            -topModuleFirst \
            ../backup/signoff/${TopName}_hier_postSignoff.v

# generate detailed timing report
timeDesign -outDir ../report/postSignoff -postRoute 
timeDesign -outDir ../report/postSignoff -postRoute -hold 
exec ../scripts/General/extract_report.csh ../report/postSignoff

saveDesign ../backup/${TopName}_postSignoff.enc


