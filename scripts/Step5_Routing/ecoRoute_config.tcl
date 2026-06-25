
# 首先配置好 NanoRoute 的 ECO 模式
# 开启 ECO 绕线模式
setNanoRouteMode -route_with_eco true

# 开启深度搜索与修复，死磕顽固 DRC
setNanoRouteMode -route_detail_search_and_repair true

# 如果你想同时顺手修一下天线效应违例，可以打开这个 (看你的需求)
# setNanoRouteMode -route_antenna_diode_insertion true

# 关闭时序驱动绕线设置，专注于修复drc
setNanoRouteMode -route_with_timing_driven false
setNanoRouteMode -route_with_si_driven false
