setMultiCpuUsage -localCpu 64




setDesignMode   -process            22 \
                -congEffort         auto \
                -earlyClockFlow     false \
                -expressRoute       false \
                -flowEffort         standard \
                -powerEffort        low \
                -bottomRoutingLayer M2 \
                -topRoutingLayer    M7


source /home/EDAtools/mentor/Calibre2023/aoj_cal_2023.2_16.9/lib/cal_enc.tcl
