module generate_number(input logic [1:0] difficulty_level, output logic[9:0] number_out);

always_comb
begin
	case(difficulty_level)
		2'b01: number_out <= $urandom_range(9, 0);	// difficulty 1 -> 1 digit range from 0 to 9
		2'b10: number_out <= $urandom_range(99, 0); // difficulty 2 -> 2 digits range from 0 to 99
		2'b11: number_out <= $urandom_range(999,0); // difficulty 3 -> 3 digits range from 0 to 999
		default: number_out <= 10'd0;	// default number -> 0
	endcase
end

endmodule