`timescale 1ns/1ns
module test_input_control();
	// This testbench is for testing the FIFO with randomizes test cases

	// DUT signals
	logic clk = 1'b0, confirm;
	logic [3:0] display_digit_1, display_digit_2, display_digit_3, update_digit_1, update_digit_2, update_digit_3, test_digit_1, test_digit_2, test_digit_3;
	logic [1:0] max_digits;
	logic [2:0] pushbuttons, max_guesses, guesses_left;
	
	// Connect device to test
	input_control dut(.clk(clk), .display_digit_1(display_digit_1), .display_digit_2(display_digit_2), .display_digit_3(display_digit_3),
		.max_digits(max_digits), .max_guesses(max_guesses), .pushbuttons(pushbuttons), .confirm(confirm),
		.update_digit_1(update_digit_1), .update_digit_2(update_digit_2), .update_digit_3(update_digit_3), .guesses_left(guesses_left));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	// Generate Inputs
	task test_one_digit();
	
		for (int i = 0; i < 30; i++) begin
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
			
			$display("%t ns, Testing input with 1 digit, only digit 1 can update", $time);
			#1 $display("Before User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d", display_digit_1, display_digit_2, display_digit_3);
			
			repeat(4) @(posedge clk);
			$display("After User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d", update_digit_1, update_digit_2, update_digit_3);
			
			if (test_digit_1 + 1 > 9) begin
				tc1: assert (update_digit_1 == 4'd0)
					else $display("Digit 1 did not wrap around");
			end
			else begin
				tc2: assert (update_digit_1 == test_digit_1 + 1)
					else $display("Digit 1 did not increment correctly");
			end
			$display("");
			
		end
		
	endtask
	
	task test_two_digits();
	
		for (int i = 0; i < 30; i++) begin
			test_digit_1 = $urandom_range(9,0);
			test_digit_2 = $urandom_range(9,0);
			test_digit_3 = $urandom_range(9,0);
			
			@(negedge clk) begin
				display_digit_1 <= test_digit_1;
				display_digit_2 <= test_digit_2;
				display_digit_3 <= test_digit_3;
				pushbuttons <= 3'b011;
				max_digits <= 2'd2;
			end
			
			$display("%t ns, Testing input with 2 digits, only digits 1 and 2 can update", $time);
			#1 $display("Before User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d", display_digit_1, display_digit_2, display_digit_3);
			
			repeat (4) begin
				repeat(4) @(negedge clk);
				display_digit_1 <= update_digit_1;
				display_digit_2 <= update_digit_2;
				display_digit_3 <= update_digit_3;
			end
			#1 $display("Expect Digit 1 and 2 to both update 5 times");
			
			repeat(4) @(posedge clk);
			$display("After User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d", update_digit_1, update_digit_2, update_digit_3);
			
			if (test_digit_1 + 5 > 9 || test_digit_2 + 5 > 9) begin
				tc1: assert (update_digit_1 < 4'd5 && update_digit_2 < 4'd5)
					else $display("Either Digit 1 and/or Digit 2 did not wrap around");
			end
			else begin
				tc2: assert (update_digit_1 == test_digit_1 + 1 && update_digit_2 == test_digit_2 + 1)
					else $display("Either Digit 1 and/or Digit 2 did not increment correctly");
			end
			$display("");
			
		end
		
	endtask
	
	task test_three_digits();
	
		for (int i = 0; i < 30; i++) begin
			test_digit_1 = $urandom_range(9,0);
			test_digit_2 = $urandom_range(9,0);
			test_digit_3 = $urandom_range(9,0);
			
			@(negedge clk) begin
				display_digit_1 <= test_digit_1;
				display_digit_2 <= test_digit_2;
				display_digit_3 <= test_digit_3;
				pushbuttons <= 3'b111;
				max_digits <= 2'd3;
				confirm <= 1'b0;
			end
			
			$display("%t ns, Testing input with 3 digits, all digits can update", $time);
			#1 $display("Before User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d", display_digit_1, display_digit_2, display_digit_3);
			
			repeat (4) begin
				repeat(4) @(negedge clk);
				display_digit_1 <= update_digit_1;
				display_digit_2 <= update_digit_2;
				display_digit_3 <= update_digit_3;
			end
			@(negedge clk);
			confirm <= 1'b1;
			@(negedge clk);
			confirm <= 1'b0;
			#1 $display("Expect All digits to update 5 times");
			
			repeat(4) @(posedge clk);
			$display("After User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d", update_digit_1, update_digit_2, update_digit_3);
			
			if (test_digit_1 + 5 > 9 || test_digit_2 + 5 > 9 || test_digit_3 + 5 > 9) begin
				tc1: assert (update_digit_1 < 4'd5 && update_digit_2 < 4'd5 && update_digit_3 < 4'd5)
					else $display("Either Digit 1, Digit 2, and/pr Digit 3 did not wrap around");
			end
			else begin
				tc2: assert (update_digit_1 == test_digit_1 + 1 && update_digit_2 == test_digit_2 + 1 && update_digit_3 == test_digit_3 + 1)
					else $display("Either Digit 1, Digit 2, and/or Digit 3 did not increment correctly");
			end
			$display("");
			
		end
		
	endtask
	
	initial begin
		//test_one_digit();
		//test_two_digits();
		test_three_digits();
	end
	
endmodule