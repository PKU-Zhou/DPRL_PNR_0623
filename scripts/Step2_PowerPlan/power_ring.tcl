#####################################################################################
# Description:  Innovus Add Power Ring Script
#####################################################################################

puts "--> 2.2 Add Power Ring Start."

editDelete -use {POWER} -shape {RING STRIPE COREWIRE BLOCKWIRE FOLLOWPIN BLOCKRING}

# -use {POWER} 表示只删 power 相关的 wire，不删普通 signal routing

# 删除这些形状：
# RING       : power ring
# STRIPE     : power stripe
# COREWIRE   : core power wire
# BLOCKWIRE  : block/macro power wire
# FOLLOWPIN  : standard cell rail
# BLOCKRING  : macro/block ring


# 只给core区域打ring，不包括macro和block
# 用 M6 和 M7 层打ring， M8和M9为高层保留
addRing -nets {VDD_MXU VSS_MXU} \
		-type core_rings \
		-follow core \
		-layer {top M6 bottom M6 left M7 right M7} \
		-width 2.2 \
		-spacing 0.5 \
		-center 1




puts "--> 2.2 Add Power Ring Done."