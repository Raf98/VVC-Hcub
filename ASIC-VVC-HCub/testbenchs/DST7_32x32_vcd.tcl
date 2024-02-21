
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open DST7_32x32.vcd -vcd
probe -all -depth all -database DST7_32x32.vcd :DST7_ARCH_32x32
run
database -close DST7_32x32.vcd

