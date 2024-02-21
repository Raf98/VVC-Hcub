
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open DCT8_32x32.vcd -vcd
probe -all -depth all -database DCT8_32x32.vcd :DCT8_ARCH_32x32
run
database -close DCT8_32x32.vcd

