#####################################################################################
# Description:  Innovus Insert Physical Cell Script
#####################################################################################

puts "--> 3.1 Insert Physical Cell Start."

# 插入边缘保护单元
setPlaceMode	\
	-place_global_timing_effort medium	\
	-place_design_refine_macro	false	\
	-place_design_refine_place	true	\
    -place_detail_use_check_drc true \
	-place_detail_legalization_inst_gap 2 \
	-place_global_cong_effort high


set LEFT_ENDCAP "BOUNDARY_LEFTBWP7T30P140"
set RIGHT_ENDCAP "BOUNDARY_RIGHTBWP7T30P140"
# 5 site BOUNDARY 和 2 site FILL
set TOP_ENDCAP "FILL2BWP7T30P140"
set BOTTOM_ENDCAP "FILL2BWP7T30P140"
setEndCapMode -rightEdge ${LEFT_ENDCAP} -leftEdge ${RIGHT_ENDCAP} -topEdge ${TOP_ENDCAP} -bottomEdge ${BOTTOM_ENDCAP} -prefix "ENDCAP"

addEndCap

# 插入Welltap保护单元
addWellTap -cell "TAPCELLBWP7T30P140" -cellInterval 14 -checkerBoard -prefix "WELLTAP"
addWellTap -cell "DCAP4BWP7T30P140HVT" -cellInterval 14 -skipRow 1 -prefix "WELLTAP_DCAP"

puts "--> 3.1 Insert Physical Cell Done."