// Timer setup for each difficulty

module timer(input logic clk, restart,
				 input logic [1:0]Max_digit, // represent difficulty 1, 2 or 3
				 output logic [6:0]counter					
				);

//logic  [1:0]stage;

always_comb	// <- Maybe change this to always_comb from always_ff?
begin
	
	//stage <= difficulty;
	
	case(Max_digit)
		1:
			counter <= 7'd30;
		2:
			counter <= 7'd60;
		3:
			counter <= 7'd90;
		default:
			counter <= 0;
	endcase
	
end

always_ff @(posedge clk)
begin
	if (!restart)
		counter <= 0;
	else
		counter <= counter - 1;
end

endmodule

