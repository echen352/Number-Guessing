module input_control(input logic clk, restart,
					input logic [1:0] max_digits,
					input logic [2:0] pushbuttons,
					output logic [3:0] update_digit_1, update_digit_2, update_digit_3
					);

	// registers store the digit values; this makes cycling digit values 0 -> 9 -> 0 possible
	logic [3:0] temp_digit_1 = 4'd0, temp_digit_2 = 4'd0, temp_digit_3 = 4'd0;


	/*	The player can press a pushbutton to increment its
		corresponding digit; digits range from 0 to 9.
		Player is restricted to a specific number of digits
		depending on game difficulty
	*/
	always_ff@(posedge clk)
	begin
		if (!restart) begin	// reset register values to zero
			temp_digit_1 <= 0;
			temp_digit_2 <= 0;
			temp_digit_3 <= 0;
		end else begin
			if (pushbuttons[0] == 1'b1 && max_digits > 2'd0) begin	// difficulty 1 & pushbutton key0
				if (temp_digit_1 < 4'd9)
					temp_digit_1 <= temp_digit_1 + 1'd1;	// increment digit by 1 up to '9'
				else
					temp_digit_1 <= 4'd0;	// loop back to '0'
			end
					
			if (pushbuttons[1] == 1'b1 && max_digits > 2'd1) begin	// difficulty 2 & pushbutton key1
				if (temp_digit_2 < 4'd9)
					temp_digit_2 <= temp_digit_2 + 1'd1;
				else
					temp_digit_2 <= 4'd0;
			end
			
			if (pushbuttons[2] == 1'b1 && max_digits > 2'd2) begin	// difficulty 3 & pushbutton key2
				if (temp_digit_3 < 4'd9)
					temp_digit_3 <= temp_digit_3 + 1'd1;
				else
					temp_digit_3 <= 4'd0;
			end
		end
	end


	/*	Upon the player pressing the confirm pushbutton,
		their choice of digits will be locked in
	*/
	always_ff@(posedge clk)
	begin
		if (!restart) begin	// assign zeros to output logic
			update_digit_1 <= 4'd0;
			update_digit_2 <= 4'd0;
			update_digit_3 <= 4'd0;
		end else begin	// assign register values to output logic
			update_digit_1 <= temp_digit_1;
			update_digit_2 <= temp_digit_2;
			update_digit_3 <= temp_digit_3;
		end
	end

endmodule