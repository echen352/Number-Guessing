module input_control(input logic clk,
					input logic [3:0] display_digit_1, display_digit_2, display_digit_3,
					input logic [1:0] max_digits,
					input logic [2:0] max_guesses,
					input logic [2:0] pushbuttons,
					input logic confirm,
					output logic [3:0] update_digit_1, update_digit_2, update_digit_3,
					output logic [2:0] guesses_left);

logic [2:0] guesses = 3'd0;
logic [3:0] temp_digit_1, temp_digit_2, temp_digit_3;


/*	The player can press a pushbutton to increment its
	corresponding digit; digits range from 0 to 9.
	Player is restricted to a specific number of digits
	depending on game difficulty
*/
always_ff @(posedge clk)
begin
	if (pushbuttons[0] == 1'b1 && max_digits > 2'd0) begin
		if (display_digit_1 < 4'd9)
			temp_digit_1 <= display_digit_1 + 1'd1;
		else
			temp_digit_1 <= 4'd0;
	end
			
	if (pushbuttons[1] == 1'b1 && max_digits > 2'd1) begin
		if (display_digit_2 < 4'd9)
			temp_digit_2 <= display_digit_2 + 1'd1;
		else
			temp_digit_2 <= 4'd0;
	end
	
	if (pushbuttons[2] == 1'b1 && max_digits > 2'd2) begin
		if (display_digit_3 < 4'd9)
			temp_digit_3 <= display_digit_3 + 1'd1;
		else
			temp_digit_3 <= 4'd0;
	end
end


/*	Upon the player pressing the confirm pushbutton,
	their choice of digits will be locked in and
	a guess will be used up
*/
always_ff@(posedge clk)
begin
	if (confirm) begin
		update_digit_1 <= temp_digit_1;
		update_digit_2 <= temp_digit_2;
		update_digit_3 <= temp_digit_3;
		guesses <= guesses + 1'b1;
	end
end


/*	The amount of guesses decreases upon
	every press of the confirm pushbutton
*/
assign guesses_left = max_guesses - guesses;

endmodule