// Timer setup for each difficulty

module timer(input logic clk, restart,
				 input logic [1:0]Max_digit, // represent difficulty 1, 2 or 3
				 output logic [6:0]counter					
				);

logic [6:0] Max_counter, iter = 7'd0;

always_comb	// <- Maybe change this to always_comb from always_ff?
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
	
end

always_ff @(posedge clk)
begin
	if (!restart) begin
		counter <= 0;
		iter <= 0;
	end else begin
		iter <= iter + 1'b1;
		counter <= Max_counter - iter;
	end
end

endmodule

