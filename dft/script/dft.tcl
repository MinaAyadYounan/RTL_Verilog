
set worst_case "saed90nm_max.db" ; 


lappend search_path "/home/ICer/Downloads/Lib/synopsys/models"
lappend search_path "/mnt/hgfs/D/RiscV_pnr/syn/output"


set target_library [list $worst_case ]
set link_library "* $target_library"
# --- work directory
sh rm -rf work
sh mkdir -p work
define_design_lib work -path ./work 
remove_design -all

set design FullModule_RiscV

 
set_svf ${design}.svf 


read_ddc ../../syn/output/${design}.ddc
 
read_sdc ../../syn/output/${design}.sdc

current_design 
link
 
set chain_num 5 

set_scan_configuration -chain_count $chain_num  -clock_mixing no_mix -style multiplexed_flip_flop 
set_dft_signal -view existing_dft  -type ScanClock -port scan_clk -timing {45 55}  			
set_dft_signal -view existing_dft  -type Reset -port scan_rst -active 1     		 
set_dft_signal -view existing_dft  -type TestMode -port Test_Mode -active 1 
create_port scan_en -direction in
set_dft_signal -view spec  -type ScanEnable  -port [get_ports scan_en ] -active 1  
  				
for {set scan_num 1} { $scan_num < 6 } {incr scan_num } {

	create_port scan_in_$scan_num -direction in  
	set_dft_signal -port scan_in_$scan_num    -view spec  -type ScanDataIn 

	create_port scan_out_$scan_num -direction out  
	set_dft_signal -port scan_out_$scan_num   -view spec  -type ScanDataOut   
}  



create_test_protocol

set_dft_insertion_configuration -preserve_design_name true  -synthesis_optimization none

source ../cons/cons.tcl

set_fix_multiple_port_nets -all -buffer_constants
link
compile -scan -map_effort medium   

dft_drc -verbose
preview_dft -show all

insert_dft
dft_drc
check_design


report_timing > ../report/dft_timing.rpt
dft_drc -coverage_estimate > ../report/rpt_dft.drc_coverage
dft_drc > ../report/drc.rpt
report_area > ../report/dft_area.rpt
report_qor > ../report/dft_qor.rpt
report_constraint -all_violators  > ../report/dft_violations.rpt
report_scan_path -chain all > ../report/scan_chains.rpt
report_dft_signal -view existing_dft  > ../report/dft_existing_dft.rpt
report_dft_signal -view spec > ../report/dft_spec.rpt

# outputs 
set verilogout_no_tri	 true
set verilogout_equation  false
write -format ddc  -hierarchy -output ../output/${design}.ddc
write -format verilog  -hierarchy -output ../output/${design}.v
write_test_model -output ../output/${design}.ctl
write_sdc ../output/${design}.sdc 

write_test_protocol -out ../output/${design}.spf
 
write_sdf  ../output/${design}.sdf

write_scan_def -output ../output/${design}.def
set_svf -off
