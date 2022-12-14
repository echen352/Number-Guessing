`timescale 1ns/1ns
module test_timer();

	// DUT signals
	logic clk = 1'b0, restart;
	logic [1:0] Max_digit;
	logic [6:0] counter;
	
	// Connect device to test
	timer dut(.clk(clk), .restart(restart), .Max_digit(Max_digit), .counter(counter));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	// Generate Inputs
	task testcase();
		@(negedge clk) begin
			restart <= 1'b1;
			Max_digit <= 2'd1;	// test timer for difficulty 1
		end
		
		for (int i = 0; i < 35; i++) begin	// max timer value is 30
			@(posedge clk);	// timer should count down by 1 every posedge
			$display("Timer Value difficulty 1 = %d", counter);
			if (i == 32) begin	// reset timer value; verify it goes back to max value for difficulty level
				@(negedge clk);
					restart <= 1'b0;
					$display("Reset Occured");
				repeat(3) @(posedge clk);
					restart <= 1'b1;
			end
		end
		$display("");
		
		@(negedge clk) begin
			Max_digit <= 2'd2;	// test timer for difficulty 2
		end
		
		for (int i = 0; i < 65; i++) begin	// max timer value is 60
			@(posedge clk);
			$display("Timer Value difficulty 2 = %d", counter);
			if (i == 62) begin
				@(negedge clk);
					restart <= 1'b0;
					$display("Reset Occured");
				repeat(3) @(posedge clk);
					restart <= 1'b1;
			end
		end
		$display("");
		
		@(negedge clk) begin
			Max_digit <= 2'd3;	// test timer for difficulty 3
		end
		
		for (int i = 0; i < 95; i++) begin	// max timer value is 90
			@(posedge clk);
			$display("Timer Value difficulty 3 = %d", counter);
			if (i == 92) begin
				@(negedge clk);
					restart <= 1'b0;
					$display("Reset Occured");
				repeat(3) @(posedge clk);
					restart <= 1'b1;
			end
		end
		
	endtask
	
	initial begin
		testcase();
	end
	
endmodule