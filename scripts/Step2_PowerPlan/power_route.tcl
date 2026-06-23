#####################################################################################
# Description:  Innovus Power Routing Script
#####################################################################################

puts "--> 2.3 Power Route Start."


# 这里我们选择先route，后stripe
sroute 	-connect                    { corePin  } \
        -nets                       { VDD_MXU VSS_MXU } \
        -layerChangeRange           { M1 M7 } \
        -crossoverViaLayerRange     { M1 M7 } \
        -targetViaLayerRange        { M1 M7 } \
        -allowJogging               0 \
        -allowLayerChange           0 \
        -checkAlignedSecondaryPin   1 \
        -deleteExistingRoutes


puts "--> 2.3 Power Route Done."