# 在 Step0_Init/init_config.tcl 中已经设置
# 这里属于重复设置，防止忘记
set init_pwr_net {VDD_MXU}
set init_gnd_net {VSS_MXU}

# 清理已有 PGPin，避免重复创建
deletePGPin -net $init_pwr_net -pg_port
deletePGPin -net $init_gnd_net -pg_port

# 抓 net object
set net_vdd_Obj [dbGet top.nets.name $init_pwr_net -p]
set net_vss_Obj [dbGet top.nets.name $init_gnd_net -p]

# 抓 stripe object
set vdd_stripes [dbGet $net_vdd_Obj.sWires.shape stripe -p]
set vss_stripes [dbGet $net_vss_Obj.sWires.shape stripe -p]


puts "VDD stripes: [llength $vdd_stripes]"
puts "VSS stripes: [llength $vss_stripes]"


# 每个 VDD stripe 创建一个 PGPin
foreach vdd_stripe $vdd_stripes {
    set layer_name [dbGet $vdd_stripe.layer.name]
    set box        [dbGet $vdd_stripe.box]
    set llx [lindex $box 0]
    set lly [lindex $box 1]
    set urx [lindex $box 2]
    set ury [lindex $box 3]
    createPGPin $init_pwr_net -geom $layer_name $llx $lly $urx $ury
}

# 每个 VSS stripe 创建一个 PGPin
foreach vss_stripe $vss_stripes {
    set layer_name [dbGet $vss_stripe.layer.name]
    set box        [dbGet $vss_stripe.box]
    set llx [lindex $box 0]
    set lly [lindex $box 1]
    set urx [lindex $box 2]
    set ury [lindex $box 3]
    createPGPin $init_gnd_net -geom $layer_name $llx $lly $urx $ury
}

# 检查一下PGPin加到了哪里
select_obj [dbGet top.pgTerms.name VDD_MXU -p]
zoomSelected




