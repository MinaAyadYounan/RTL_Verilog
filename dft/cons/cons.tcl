# ##############################################################################
# 		--------------------- Clock Definations --------------------- 		   #
# ##############################################################################

# --- Budget Clock (Timing Definations)
create_clock -name scan_clk -period 100 -waveform {0 50}   [get_ports scan_clk]	;  # use it in test mode  (shift, capture )
# --- Clock uncertainty Berfore CTS  uncertainty = Jitter + Source Latency  + Network Latency
# --- Prevent Tool do any thing on network 
set_dont_touch_network [get_clocks {scan_clk}]

# ##############################################################################
# 		--------------------- Optimization --------------------- 			   #
# ##############################################################################

# Test clock paths timing 
set_case_analysis 1 Test_Mode ; # Enable test mode
set_clock_groups -physically_exclusive -group {scan_clk} -group {clock_func}

#set_max_transition 1.5 -data_path [get_clocks fun_clk]
set_max_fanout 3 [current_design]
#set_max_capacitance 2.5 [current_design]
