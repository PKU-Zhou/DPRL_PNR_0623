setExtractRCMode \
  -engine postRoute \
  -effortLevel signoff \
  -coupled true 

extractRC

rcOut -rc_corner rc_typ -spef ../backup/signoff/${TopName}_postSignoff_rc_typ.spef
