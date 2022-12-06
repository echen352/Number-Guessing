module get_target_number(input logic clk, input logic [1:0] Max_digit, input logic [3:0] round,
				output logic [3:0] target_digit_1, target_digit_2, target_digit_3);

	always_ff@(posedge clk)
	begin
		if (Max_digit == 2'd1) begin
			case(round)
				2'd1: begin
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd0;
						target_digit_1 <= 4'd2;
					end
				2'd2: begin
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd0;
						target_digit_1 <= 4'd8;
					end
				2'd3: begin
						target_digit_3 <= 4'd0;
						target_digit_2 <= 4'd0;
						target_digit_1 <= 4'd3;
					end
			endcase
		end
		if (Max_digit == 2'd2) begin
			case(round)
			2'd4: begin
					target_digit_3 <= 4'd0;
					target_digit_2 <= 4'd5;
					target_digit_1 <= 4'd7;
				end
			2'd5: begin
					target_digit_3 <= 4'd0;
					target_digit_2 <= 4'd9;
					target_digit_1 <= 4'd6;
				end
			2'd6: begin
					target_digit_3 <= 4'd0;
					target_digit_2 <= 4'd2;
					target_digit_1 <= 4'd1;
				end
			endcase
		end
		if (Max_digit == 2'd3) begin
			case(round)
				2'd7: begin
						target_digit_3 <= 4'd1;
						target_digit_2 <= 4'd2;
						target_digit_1 <= 4'd3;
					end
				2'd8: begin
						target_digit_3 <= 4'd5;
						target_digit_2 <= 4'd5;
						target_digit_1 <= 4'd5;
					end
				2'd9: begin
						target_digit_3 <= 4'd9;
						target_digit_2 <= 4'd9;
						target_digit_1 <= 4'd9;
				end
			endcase
		end
	end
/*
	always_ff@(posedge clk)
	begin
		if (Max_digit == 2'd1 && round == 2'd1) begin	// 1st number is '2'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd2;
		end
		if (Max_digit == 2'd1 && round == 2'd2) begin	// 2nd number is '8'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd8;
		end
		if (Max_digit == 2'd1 && round == 2'd3) begin	// 3rd number is '3'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd3;
		end
		if (Max_digit == 2'b10 && round == 2'd4) begin	// 4rd number is '57'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd5;
			target_digit_1 <= 4'd7;
		end
		if (Max_digit == 2'b10 && round == 2'd5) begin	// 5th number is '96'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd9;
			target_digit_1 <= 4'd6;
		end
		if (Max_digit == 2'b10 && round == 2'd6) begin	// 6th number is '21'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd2;
			target_digit_1 <= 4'd1;
		end
		if (Max_digit == 2'b11 && round == 2'd7) begin	// 7th number is '123'
			target_digit_3 <= 4'd1;
			target_digit_2 <= 4'd2;
			target_digit_1 <= 4'd3;
		end
		if (Max_digit == 2'b11 && round == 2'd8) begin	// 8th number is '000'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd0;
		end
		if (Max_digit == 2'b11 && round == 2'd9) begin	// 9th number is '999'
			target_digit_3 <= 4'd9;
			target_digit_2 <= 4'd9;
			target_digit_1 <= 4'd9;
		end
	end
*/
endmodule