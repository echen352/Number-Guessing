// Timer setup for each difficulty

module timer(input logic clk,
				 input logic [1:0]Max_digit, // represent difficulty 1, 2 or 3
				 output logic [6:0]counter					
				);

//logic  [1:0]stage;

always_ff @(posedge clk)
begin
	
	//stage <= difficulty;
	
	case(Max_digit)
		1:
			counter <= 2'd30;
		2:
			counter <= 2'd60;
		3:
			counter <= 2'd90;
		default:
			counter <= 0;
	endcase
	
end

always_ff @(posedge clk)
begin
	counter <= counter - 1;
end

endmodule

