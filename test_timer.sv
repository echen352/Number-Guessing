`timescale 1ns/1ns
module test_timer();
	// This testbench is for testing the FIFO with randomizes test cases

	// DUT signals
	logic clk = 1'b0, restart;
	logic [1:0] Max_digit;
	logic [6:0] counter;//, counter2;
	
	// Connect device to test
	timer dut(.clk(clk), .restart(restart), .Max_digit(Max_digit), .counter(counter));//1(counter1), .counter2(counter2), .counter3(counter3));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	// Generate Inputs
	task testcase();
		@(negedge clk) begin
			restart <= 1'b1;
			Max_digit <= 2'd1;
		end
		
		for (int i = 0; i < 35; i++) begin
			@(posedge clk);
			$display("Timer Value difficulty 1 = %d", counter);
			if (i == 32) begin
				@(negedge clk);
					restart <= 1'b0;
				repeat(3) @(posedge clk);
					restart <= 1'b1;
			end
		end
		
		@(negedge clk) begin
			Max_digit <= 2'd2;
		end
		
		for (int i = 0; i < 65; i++) begin
			@(posedge clk);
			$display("Timer Value difficulty 2 = %d", counter);
			if (i == 62) begin
				@(negedge clk);
					restart <= 1'b0;
				repeat(3) @(posedge clk);
					restart <= 1'b1;
			end
		end
		
	endtask
	
	initial begin
		testcase();
	end
	
endmodule