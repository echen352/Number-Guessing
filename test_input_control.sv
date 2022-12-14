`timescale 1ns/1ns
module test_input_control();

	// DUT signals
	logic clk = 1'b0, restart = 1'b1;
	logic [3:0] update_digit_1, update_digit_2, update_digit_3, previous_digit_1, previous_digit_2, previous_digit_3;
	logic [1:0] max_digits;
	logic [2:0] pushbuttons;
	
	// Connect device to test
	input_control dut(.clk(clk), .max_digits(max_digits), .pushbuttons(pushbuttons), .restart(restart),
		.update_digit_1(update_digit_1), .update_digit_2(update_digit_2), .update_digit_3(update_digit_3));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	// Generate Inputs
	task test_one_digit();
	
		$display("*********************************Testing input with 1 digit, only digit 1 can update\n");
		for (int i = 0; i < $urandom_range(30,10); i++) begin
			
			@(negedge clk) begin
				previous_digit_1 <= update_digit_1;
				previous_digit_2 <= update_digit_2;
				previous_digit_3 <= update_digit_3;
				pushbuttons <= 3'b001;
				max_digits <= 2'd1;
			end
			
			$display("%t ns", $time);
			
			@(posedge clk);
			#1 $display("After User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d\n", update_digit_1, update_digit_2, update_digit_3);
			
			if (previous_digit_1 + 1 > 9) begin
				tc1: assert (update_digit_1 == 4'd0)
					else $display("Digit 1 did not wrap around\n");
			end
			else begin
				tc2: assert (update_digit_1 == previous_digit_1 + 1)
					else $display("Digit 1 did not increment correctly\n");
			end
			
		end
		
	endtask
	
	task test_two_digits();
	
		$display("*********************************Testing input with 2 digits, only digits 1 and 2 can update\n");
		for (int i = 0; i < $urandom_range(30,10); i++) begin
		
			@(negedge clk) begin
				previous_digit_1 <= update_digit_1;
				previous_digit_2 <= update_digit_2;
				previous_digit_3 <= update_digit_3;
				pushbuttons <= 3'b011;
				max_digits <= 2'd2;
			end
			
			$display("%t ns", $time);
			
			@(posedge clk);
			#1 $display("After User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d\n", update_digit_1, update_digit_2, update_digit_3);
			
			if (previous_digit_1 + 1 > 9) begin
				tc3: assert (update_digit_1 == 4'd0)
					else $display("Digit 1 did not wrap around\n");
			end
			else if (previous_digit_2 + 1 > 9) begin
				tc4: assert (update_digit_2 == 4'd0)
					else $display("Digit 2 did not wrap around\n");
			end
			else begin
				tc5: assert (update_digit_1 == previous_digit_1 + 1 && update_digit_2 == previous_digit_2 + 1)
					else $display("Either Digit 1 and/or Digit 2 did not increment correctly\n");
			end
			$display("");
			
		end
		
	endtask
	
	task test_three_digits();
	
		$display("*********************************Testing input with 3 digits, all digits can update\n");
		for (int i = 0; i < $urandom_range(30,10); i++) begin
		
			@(negedge clk) begin
				previous_digit_1 <= update_digit_1;
				previous_digit_2 <= update_digit_2;
				previous_digit_3 <= update_digit_3;
				pushbuttons <= 3'b111;
				max_digits <= 2'd3;
			end
			
			$display("%t ns", $time);
			
			@(posedge clk);
			#1 $display("After User Input -> Digit 1 = %d, Digit 2 = %d, Digit 3 = %d\n", update_digit_1, update_digit_2, update_digit_3);
			
			if (previous_digit_1 + 1 > 9) begin
				tc6: assert (update_digit_1 == 4'd0)
					else $display("Digit 1 did not wrap around\n");
			end
			else if (previous_digit_2 + 1 > 9) begin
				tc7: assert (update_digit_2 == 4'd0)
					else $display("Digit 2 did not wrap around\n");
			end
			else if (previous_digit_3 + 1 > 9) begin
				tc8: assert (update_digit_3 == 4'd0)
					else $display("Digit 3 did not wrap around\n");
			end
			else begin
				tc9: assert (update_digit_1 == previous_digit_1 + 1 && update_digit_2 == previous_digit_2 + 1 && update_digit_3 == previous_digit_3 + 1)
					else $display("Either Digit 1, Digit 2, and/or Digit 3 did not increment correctly\n");
			end
			$display("");
			
		end
		
	endtask
	
	initial begin
		test_one_digit();
		test_two_digits();
		test_three_digits();
	end
	
endmodule