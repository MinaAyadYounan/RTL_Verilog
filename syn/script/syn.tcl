
# ============= Setup ============== #

set_host_options -max_cores 6 
 
set worst_case "saed90nm_max.db" ; 
#set H_worst_case "saed90nm_max_hvt.db"
#set best_case "saed90nm_min.db"
#set balanced_case "saed90nm_typ.db" 

lappend search_path "/home/ICer/Downloads/Lib/synopsys/models"
set_app_var target_library [list $worst_case]  
set_app_var link_library "* $target_library"


# --- work directory
sh rm -rf work
sh mkdir -p work
define_design_lib work -path ./work 

set design FullModule_RiscV

set compile_top_all_paths true 

set_svf ${design}.svf 


analyze -format verilog -lib work  ../../rtl/${design}.v ;
elaborate $design -lib work ; width mismatch} 
current_design  
check_design


# =========== Constraints ========== #

source ../cons/cons.tcl 


set_app_var compile_delete_unloaded_sequential_cells true
set_app_var hdlin_check_no_latch true


set_fix_multiple_port_nets -all -buffer_constants
link  ; 
 
compile -map_effort high    
report_timing -max_paths 20 > ../report/synth_timing_before_optimize.rpt 


compile -top  

report_timing -max_paths 20 > ../report/synth_timing_after_optimize.rpt

# ============ Reports ============= #


report_area  -nosplit  > ../report/synth_area.rpt
report_power -nosplit > ../report/synth_power.rpt
report_cell > ../report/synth_cells.rpt
report_qor  > ../report/synth_qor.rpt
report_clock > ../report/clock.rpt
report_constraint -all_violators -nosplit > ../report/Syn_violations.rpt
report_timing > ../report/critical_Path_timing.rpt
report_timing -max_paths 20 > ../report/synth_timing.rpt 
report_resources -hierarchical > ../report/synth_resources.rpt



# ============ Outputs ============= #


define_name_rules  no_case -case_insensitive
change_names -rule no_case -hierarchy
change_names -rule verilog -hierarchy
report_names -rules verilog

write_sdc ../output/${design}.sdc 
write_sdf ../output/${design}.sdf 
write -hierarchy -format verilog -output ../output/${design}.v 
write -f ddc -hierarchy -output ../output/${design}.ddc   
set_svf -off



