
help -variable rangecnst_severity_level
set rangecnst_severity_level ignore
set textio_severity_level ignore
database -open DCT8_8x8.vcd -vcd
probe -all -depth all -database DCT8_8x8.vcd :DCT8_ARCH_8x8
run
database -close DCT8_8x8.vcd

