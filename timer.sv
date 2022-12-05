// Timer setup for each difficulty

module timer(input logic clk, restart,
				 input logic [1:0]Max_digit, // represent difficulty 1, 2 or 3
				 output logic [6:0]counter					
				);

//logic [6:0] Max_counter, iter = 7'd0;

/*always_comb	// <- Maybe change this to always_comb from always_ff?
begin
	
	//stage <= difficulty;
	
	case(Max_digit)
		2'd1:
			Max_counter <= 7'd30;
		2'd2:
			Max_counter <= 7'd60;
		2'd3:
			Max_counter <= 7'd90;
		default:
			Max_counter <= 7'd0;
	endcase
	
end*/

/*always_ff @(posedge clk)
begin
	if (!restart) begin
		//if (Max_digit == 1) begin
			counter <= 30;
			iter <= 0;
		//end
	end else begin
		iter <= iter + 1'b1;
		counter <= Max_counter - iter;
	end
end*/

logic [6:0] diff1 = 7'd30, diff2 = 7'd60, diff3 = 7'd90;

always_ff @(posedge clk)
begin
	if (!restart) begin
		//if (Max_digit == 1) begin
			diff1 <= 7'd30;
			diff2 <= 7'd60;
			diff3 <= 7'd90;
		//end
	end else begin
		if (Max_digit == 1)
			diff1 <= diff1 - 1'b1;
		if (Max_digit == 2)
			diff2 <= diff2 - 1'b1;
		if (Max_digit == 3)
			diff3 <= diff3 - 1'b1;
		
	end
end

/*assign counter1 = diff1;
assign counter2 = diff2;
assign counter3 = diff3;*/

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

