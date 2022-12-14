module timer(input logic clk, restart,
				input logic [1:0]Max_digit,
				output logic [6:0]counter					
				);

	// one register dedicated to each difficulty
	logic [6:0] diff1 = 7'd30, diff2 = 7'd60, diff3 = 7'd90;

	// responsible for decrementing timer by one every pos clock edge
	always_ff @(posedge clk)
	begin
		if (!restart) begin	// reset timer values
			diff1 <= 7'd30;
			diff2 <= 7'd60;
			diff3 <= 7'd90;
		end else begin
			if (Max_digit == 1)
				diff1 <= diff1 - 1'b1;	// difficulty 1
			if (Max_digit == 2)
				diff2 <= diff2 - 1'b1;	// difficulty 2
			if (Max_digit == 3)
				diff3 <= diff3 - 1'b1;	// difficulty 3
			
		end
	end

	// assign timer values to output logic
	always_comb
	begin
		if (Max_digit == 1)
			counter <= diff1;
		else if (Max_digit == 2)
			counter <= diff2;
		else if (Max_digit == 3)
			counter <= diff3;
		else
			counter <= diff1;
	end

endmodule

