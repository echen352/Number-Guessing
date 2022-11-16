module input_control(input logic [9:0] current_number_to_display, input logic [1:0] max_digits, pushbuttons, output logic );

always_comb
begin
	case(max_digits)
		2'b01: if (pushbuttons == 2'b01) current_number_to_display <
		2'b10:
		2'b11: begin
				if (current_number_to_display % 10) < 4'd9
			   end
	endcase
end

endmodule