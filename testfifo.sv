`timescale 1ns/1ns
module test_input_control();
	// This testbench is for testing the FIFO with randomizes test cases

	// DUT signals
	logic clk = 1'b0;
	logic [3:0] display_digit_1, display_digit_2, display_digit_3, update_digit_1, update_digit_2, update_digit_3, test_digit_1, test_digit_2, test_digit_3;
	logic [1:0] max_digits;
	logic [2:0] pushbuttons;
	
	// Connect device to test
	input_control dut(.clk(clk), .display_digit_1(test_digit_1), .display_digit_2(test_digit_2), .display_digit_3(test_digit_3),
		.max_digits(max_digits), .pushbuttons(pushbuttons),
		.update_digit_1(update_digit_1), .update_digit_2(update_digit_1), .update_digit_3(update_digit_1));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	// Generate Inputs
	task test_one_digit();
	
		for (int i = 0; i < 20; i++) begin
			test_digit_1 = $urandom_range(9,0);
			test_digit_2 = $urandom_range(9,0);
			test_digit_3 = $urandom_range(9,0);
			
			@(negedge clk) begin
				display_digit_1 <= test_digit_1;
				display_digit_2 <= test_digit_2;
				display_digit_3 <= test_digit_3;
				pushbuttons <= 3'b001;
				max_digits <= 2'd1;
			end
			
			$display("%t ns, Testing Input With One Digit", $time);
			#1 $display("Before User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d", display_digit_1, display_digit_2, display_digit_3);
			
			repeat(4) @(posedge clk);
			$display("After User Input -> Digit 1 = %d, Digit 2 = %d, Digit = %d", update_digit_1, update_digit_2, update_digit_3);
			
			if (test_digit_1 + 1 > 9) begin
				tc1: assert (update_digit_1 == 4'd0)
					else $display("Digit 1 did not wrap around");
			end
			else begin
				tc2: assert (update_digit_1 == test_digit_1 + 1)
					else $display("Digit 1 did not increment correctly");
			end
			
		end
		
	endtask
	
	initial begin
		test_one_digit();
	end
	
endmodule