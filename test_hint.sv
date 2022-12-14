`timescale 1ns/1ns
module test_hint();

	// DUT signals
	logic clk = 1'b0, restart = 1'b1, confirmButton;
	logic [3:0] key0, key1, key2, answer0, answer1, answer2, round;
	logic [1:0] Max_digit, hint1;
	logic [2:0] incorrect_guess;
	
	// Connect device to test
	hint123 dut(.clk(clk), .confirmButton(confirmButton), .restart(restart),
				.key0(key0), .key1(key1), .key2(key2), .answer0(answer0), .answer1(answer1), .answer2(answer2),
				.Max_digit(Max_digit), .hint1(hint1), .round(round), .incorrect_guess(incorrect_guess));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	task reset();
		$display("Reset\n");
		repeat(3) @(negedge clk);
		restart <= 1'b0;
		
		repeat(3) @(negedge clk);
		restart <= 1'b1;
		
	endtask
	
	task testcase();
		@(negedge clk) begin
			Max_digit <= 2'd3;
			answer0 <= $urandom_range(9,0);
			answer1 <= $urandom_range(9,0);
			answer2 <= $urandom_range(9,0);
		end
		
		@(posedge clk);
		#1 $display("%t ns, (Difficulty 3) Target number: %d %d %d \n", $time, answer0, answer1, answer2);
		
		// 1st try all digits random
		@(negedge clk) begin
			key0 <= $urandom_range(9,0);
			key1 <= $urandom_range(9,0);
			key2 <= $urandom_range(9,0);
			confirmButton <= 1'b1;
		end
		
		@(negedge clk);
		confirmButton <= 1'b0;
		
		@(posedge clk);
		#1 $display("Player input: %d%d%d", key0, key1, key2);
		$display("Hint = %d, round = %d, incorrect_guess = %d", hint1, round, incorrect_guess);
		check_hint();
		
		// 2nd try 2 digits random
		@(negedge clk) begin
			key0 <= answer1;
			key1 <= $urandom_range(9,0);
			key2 <= $urandom_range(9,0);
			confirmButton <= 1'b1;
		end
		
		@(negedge clk);
		confirmButton <= 1'b0;
		
		@(posedge clk);
		#1 $display("Player input: %d%d%d", key0, key1, key2);
		$display("Hint = %d, round = %d, incorrect_guess = %d", hint1, round, incorrect_guess);
		check_hint();
		
		// 3rd try 1 digit random
		@(negedge clk) begin
			key0 <= answer0;
			key1 <= $urandom_range(9,0);
			key2 <= answer2;
			confirmButton <= 1'b1;
		end
		
		@(negedge clk);
		confirmButton <= 1'b0;
		
		@(posedge clk);
		#1 $display("Player input: %d%d%d", key0, key1, key2);
		$display("Hint = %d, round = %d, incorrect_guess = %d", hint1, round, incorrect_guess);
		check_hint();

		// 4th try correct digits
		@(negedge clk) begin
			key0 <= answer0;
			key1 <= answer1;
			key2 <= answer2;
			confirmButton <= 1'b1;
		end
		
		@(negedge clk);
		confirmButton <= 1'b0;
		
		@(posedge clk);
		#1 $display("Player input: %d%d%d", key0, key1, key2);
		$display("Hint = %d, round = %d, incorrect_guess = %d", hint1, round, incorrect_guess);
		check_hint();
		
	endtask
	
	task check_hint();
		if (key0 > answer0 || key1 > answer1 || key2 > answer2) begin
			if (hint1 != 2'd0)
				$display("Warning: Hint should be '0' (lower)!\n");
			else
				$display("Hint is '0' (lower): looks good\n");
		end
		else if (key0 < answer0 || key1 < answer1 || key2 < answer2) begin
			if (hint1 != 2'd1)
				$display("Warning: Hint should be '1' (higher)!\n");
			else
				$display("Hint is '1' (higher): looks good\n");
		end
		else begin
			if (hint1 != 2'd3)
				$display("Warning: Hint should be '3' (no hint)!\n");
			else
				$display("Hint is '3' (no hint): looks good\n");
		end
	endtask
	
	initial begin
		repeat(3) testcase();
	end
	
endmodule