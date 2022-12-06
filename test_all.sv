`timescale 1ns/1ns
module test_all();
	// This testbench is for testing the FIFO with randomizes test cases

	// DUT signals
	logic clk = 1'b0, rst, confirmButton;
	logic [2:0] digitButtons, roundLED, diffLED;
	logic [6:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	
	// Connect device to test
	top_level dut(.clk(clk), .rst(rst), .confirmButton(confirmButton),
					.digitButtons(digitButtons),
					.seg1(seg1), .seg2(seg2), .seg3(seg3), .seg4(seg4), .seg5(seg5), .seg6(seg6), .seg7(seg7), .seg8(seg8),
					.roundLED(roundLED), .diffLED(diffLED));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	// Generate Inputs
	task testcase();
		@(negedge clk) begin
			rst <= 1'b1;
			confirmButton <= 1'b0;
			digitButtons <= 3'b001; // this is a single push
		end
		
		repeat(3) @(negedge clk);
		digitButtons <= 1'b0;
		
		repeat(3) @(negedge clk);
		digitButtons <= 1'b1;
		
		repeat(3) @(negedge clk);
		digitButtons <= 1'b0;		// this is 002
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b1;	// click confirm
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b0;	// let go of confirm
		
		@(posedge clk);
		#1 $display("roundLED = %d, diffLED = %d", roundLED, diffLED);
		$display("");
		
		for (int i = 0; i < 6; i++) begin
			repeat(3) @(negedge clk);
			digitButtons <= 3'b001;
			
			repeat(3) @(negedge clk);
			digitButtons <= 3'b000;
		end
		// this should be 008 now
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b1;	// click confirm
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b0;	// let go of confirm
		
		@(posedge clk);
		#1 $display("roundLED = %d, diffLED = %d", roundLED, diffLED);
		$display("");
		
		for (int i = 0; i < 5; i++) begin
			repeat(3) @(negedge clk);
			digitButtons <= 3'b001;
			
			repeat(3) @(negedge clk);
			digitButtons <= 3'b000;
		end // this should be 003 now
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b1;	// click confirm
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b0;	// let go of confirm
		
		@(posedge clk);
		#1 $display("roundLED = %d, diffLED = %d", roundLED, diffLED);
		$display("");
		
		for (int i = 0; i < 4; i++) begin
			repeat(3) @(negedge clk);
			digitButtons <= 3'b001;
			
			repeat(3) @(negedge clk);
			digitButtons <= 3'b000;
		end // this should be 007 now
		
		for (int i = 0; i < 5; i++) begin
			repeat(3) @(negedge clk);
			digitButtons <= 3'b010;
			
			repeat(3) @(negedge clk);
			digitButtons <= 3'b000;
		end // this should be 057 now
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b1;	// click confirm
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b0;	// let go of confirm
		
		@(posedge clk);
		#1 $display("roundLED = %d, diffLED = %d", roundLED, diffLED);
		$display("");
		
		for (int i = 0; i < 9; i++) begin
			repeat(3) @(negedge clk);
			digitButtons <= 3'b001;
			
			repeat(3) @(negedge clk);
			digitButtons <= 3'b000;
		end // this should be 056 now
		
		for (int i = 0; i < 4; i++) begin
			repeat(3) @(negedge clk);
			digitButtons <= 3'b010;
			
			repeat(3) @(negedge clk);
			digitButtons <= 3'b000;
		end // this should be 096 now
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b1;	// click confirm
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b0;	// let go of confirm
		
		@(posedge clk);
		#1 $display("roundLED = %d, diffLED = %d", roundLED, diffLED);
		$display("");
		
		for (int i = 0; i < 5; i++) begin
			repeat(3) @(negedge clk);
			digitButtons <= 3'b001;
			
			repeat(3) @(negedge clk);
			digitButtons <= 3'b000;
		end // this should be 091 now
		
		for (int i = 0; i < 3; i++) begin
			repeat(3) @(negedge clk);
			digitButtons <= 3'b010;
			
			repeat(3) @(negedge clk);
			digitButtons <= 3'b000;
		end // this should be 021 now
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b1;	// click confirm
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b0;	// let go of confirm
		
		@(posedge clk);
		#1 $display("roundLED = %d, diffLED = %d", roundLED, diffLED);
		$display("");
		
	endtask
	
	initial begin
		testcase();
	end
	
endmodule