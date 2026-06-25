TOP   ?= mxu_top
STAGE ?= floorplan

export  TOP

# 进入logs目录并执行innovus
# 使用方式：
#     make innovus TOP=mxu_top
innovus:
	cd logs && innovus \
	-execute "source ../scripts/Step0_Init/init_config.tcl; \
			  init_design; \
			  source ../scripts/General/global_config.tcl; \
			  win" \
			  -log ${TOP}.log -overwrite

# 使用方式：
#     make restore TOP=mxu_top STAGE=Powerplan
# 注意：必须是合法的STAGE，且备份文件存在
# Powerplan
restore:
	grep '^set ' ./scripts/Step1_FloorPlan/floorplan.tcl      > ./backup/macro_alias.tcl
	grep '^set ' ./scripts/Step1_FloorPlan/macro_preplace.tcl >> ./backup/macro_alias.tcl
	cd logs && \
	innovus \
	-execute "source ../scripts/Step0_Init/init_config.tcl; \
			  source ../backup/${TOP}_post${STAGE}.enc; \
	          source ../backup/macro_alias.tcl; \
			  source ../scripts/General/global_config.tcl; \
	          win" \
			  -log ${TOP}.log -overwrite



# clean:
# 	rm -rf *.log* *.cmd* *.rpt*