module get_target_number(input logic [1:0] Max_digit, input logic [2:0] round,
				output logic [3:0] target_digit_1, target_digit_2, target_digit_3);

	always_comb
	begin
		if (Max_digit == 2'd1 && round == 3'd1) begin	// 1st number is '2'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd2;
		end else if (Max_digit == 2'd1 && round == 3'd2) begin	// 2nd number is '8'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd8;
		end else if (Max_digit == 2'd1 && round == 3'd3) begin	// 3rd number is '3'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd3;
		end else if (Max_digit == 2'd2 && round == 3'd1) begin	// 4rd number is '57'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd5;
			target_digit_1 <= 4'd7;
		end else if (Max_digit == 2'd2 && round == 3'd2) begin	// 5th number is '96'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd9;
			target_digit_1 <= 4'd6;
		end else if (Max_digit == 2'd2 && round == 3'd3) begin	// 6th number is '21'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd2;
			target_digit_1 <= 4'd1;
		end else if (Max_digit == 2'd3 && round == 3'd1) begin	// 7th number is '123'
			target_digit_3 <= 4'd1;
			target_digit_2 <= 4'd2;
			target_digit_1 <= 4'd3;
		end else if (Max_digit == 2'd3 && round == 3'd2) begin	// 8th number is '000'
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd0;
		end else if (Max_digit == 2'd3 && round == 3'd3) begin	// 9th number is '999'
			target_digit_3 <= 4'd9;
			target_digit_2 <= 4'd9;
			target_digit_1 <= 4'd9;
		end else begin
			target_digit_3 <= 4'd0;
			target_digit_2 <= 4'd0;
			target_digit_1 <= 4'd0;
		end
	end

endmodule