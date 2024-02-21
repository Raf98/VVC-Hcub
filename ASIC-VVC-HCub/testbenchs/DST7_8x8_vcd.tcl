
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open DST7_8x8.vcd -vcd
probe -all -depth all -database DST7_8x8.vcd :DST7_ARCH_8x8
run
database -close DST7_8x8.vcd

