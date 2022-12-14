module get_target_number(input logic clk,
						input logic [1:0] Max_digit,
						input logic [3:0] round,
						output logic [3:0] target_digit_1, target_digit_2, target_digit_3
						);

	always_ff@(posedge clk)
	begin
		if (Max_digit == 2'b01) begin	// single digit
			case(round)
				4'b0001: begin	// 1st number is '2'
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd0;
						target_digit_1 <= 4'd2;
					end
				4'b0010: begin	// 2nd number is '8'
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd0;
						target_digit_1 <= 4'd8;
					end
				4'b0011: begin	// 3rd number is '3'
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd0;
						target_digit_1 <= 4'd3;
					end
			endcase
		end
		if (Max_digit == 2'b10) begin	// double digits
			case(round)
				4'b0100: begin	// 4th number is '57'
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd5;
						target_digit_1 <= 4'd7;
					end
				4'b0101: begin	// 5th number is '96'
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd9;
						target_digit_1 <= 4'd6;
					end
				4'b0110: begin	// 6th number is '21'
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd2;
						target_digit_1 <= 4'd1;
					end
			endcase
		end
		if (Max_digit == 2'b11) begin	// triple digits
			case(round)
				4'b0111: begin	// 7th number is '123'
						target_digit_3 <= 4'd1;
						target_digit_2 <= 4'd2;
						target_digit_1 <= 4'd3;
					end
				4'b1000: begin	// 8th number is '555'
						target_digit_3 <= 4'd5;
						target_digit_2 <= 4'd5;
						target_digit_1 <= 4'd5;
					end
				4'b1001: begin	// 9th number is '999'
						target_digit_3 <= 4'd9;
						target_digit_2 <= 4'd9;
						target_digit_1 <= 4'd9;
				end
			endcase
		end
	end

endmodule