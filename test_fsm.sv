`timescale 1ns/1ns
module test_fsm();
	// This testbench is for testing the FIFO with randomizes test cases

	// DUT signals
	logic clk = 1'b0, restart, confirmButton;
	logic [1:0] Max_digit, WINorLOSE, round;
	logic [2:0] incorrect_guesses, guesses_left;
	logic [6:0] timer;
	
	// Connect device to test
	fsm(.clk(clk), .restart(restart), .incorrect_guesses(incorrect_guesses),
			.round(round), .timer(timer), .confirmButton(confirmButton),
			.Max_digit(Max_digit), .WINorLOSE(WINorLOSE), .guesses_left(guesses_left));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	// Generate Inputs
	task testcase();
		@(negedge clk) begin
			restart <= 1'b1;
			Max_digit <= 2'd1;
			incorrect_guesses <= 3'd0;
			round <= 2'd1;
			timer <= 7'd30;
		end
		
		@(negedge clk);
		#1 $display("Max Digit = %d, WINorLOSE = %d, guesses_left = %d", Max_digit, WINorLOSE, guesses_left);
		$display("");
		
	endtask
	
	initial begin
		testcase();
	end
	
endmodule