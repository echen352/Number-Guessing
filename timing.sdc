create_clock -name clock -period 20.000 [get_ports {clk}]
create_clock -name vclock -period 20.000;

set_input_delay -clock { vclock } 0 [get_ports {confirmButton rst digitButtons[0] digitButtons[1] digitButtons[2]}]
set_output_delay -clock { vclock } 0 [get_ports {diffLED[0] diffLED[1] diffLED[2] resetLED roundLED[0] roundLED[1] roundLED[2] seg1[0] seg1[1] seg1[2] seg1[3] seg1[4] seg1[5] seg1[6] seg2[0] seg2[1] seg2[2] seg2[3] seg2[4] seg2[5] seg2[6] seg3[0] seg3[1] seg3[2] seg3[3] seg3[4] seg3[5] seg3[6] seg4[0] seg4[1] seg4[2] seg4[3] seg4[4] seg4[5] seg4[6] seg5[0] seg5[1] seg5[2] seg5[3] seg5[4] seg5[5] seg5[6] seg6[0] seg6[1] seg6[2] seg6[3] seg6[4] seg6[5] seg6[6] seg7[0] seg7[1] seg7[2] seg7[3] seg7[4] seg7[5] seg7[6] seg8[0] seg8[1] seg8[2] seg8[3] seg8[4] seg8[5] seg8[6]}]

derive_pll_clocks -create_base_clocks
derive_clock_uncertainty
