`timescale 1ns/1ns
module test_fsm();

	// DUT signals
	logic clk = 1'b0, restart;
	logic [1:0] Max_digit, WINorLOSE;
	logic [3:0] round;
	logic [2:0] incorrect_guesses, guesses_left;
	logic [6:0] timer;
	
	// Connect device to test
	fsm dut(.clk(clk), .restart(restart), .incorrect_guesses(incorrect_guesses),
			.round(round), .timer(timer),
			.Max_digit(Max_digit), .WINorLOSE(WINorLOSE), .guesses_left(guesses_left));
	
	// Generate clock
	always #25 clk <= ~clk;
	
	// Generate Inputs
	task test_lose_on_time();
	
		$display("Test 1: Try to achieve Game over state by running out of time\n");
		@(negedge clk) begin
			restart <= 1'b1;
			incorrect_guesses <= 3'd0;
			round <= 4'd1;
			timer <= 7'd30;
		end
		
		@(posedge clk);
		#1 $display("Current Timer = %d", timer);
		
		for (int i = 0; i < 40; i++) begin
			@(negedge clk);
			timer <= timer - 1'b1;
			
			@(posedge clk);
			#1 $display("Current Timer = %d", timer);
			
			@(posedge clk);
			#1 $display("Max Digit = %d, WINorLOSE = %d, guesses_left = %d", Max_digit, WINorLOSE, guesses_left);
			if (timer == -7'd1) begin
				tc1: assert(WINorLOSE == 2'd0) $display("Game over due to 'time is up' correct\n");
				else $display("Error: Game did not end when timer ran down to 0\n");
			end
		end
		
	endtask
	
	task test_reset_game_to_diff1();
	
		$display("\nTest 2: Try to reset the win/lose flag to default by reseting game to difficulty 1\n");
		@(negedge clk);
		restart <= 1'b0;
		
		repeat(3) @(negedge clk);
		restart <= 1'b1;
		
		repeat(3) @(posedge clk);
		#1 $display("Difficulty 1 logic: Max Digit = %d, WINorLOSE = %d, guesses_left = %d", Max_digit, WINorLOSE, guesses_left);
		tc2: assert(WINorLOSE == 2'd3) $display("Reset worked correctly; win/lose condition reset\n");
			else $display("Reset did not work\n");
	endtask
	
	task verify_game_parameters_by_difficulty();
	
		$display("\nTest 3: Try to verify max num digits, max num allowed incorect guesses, and max timer value scale by difficulty\n");
		$display("Try to see updates to difficulty 2\n");
		@(negedge clk) begin
			round <= 4'd4;
			timer <= 7'd60;
		end
		
		repeat(3) @(posedge clk);
		#1 $display("Difficulty 2 logic: Max Digit = %d, WINorLOSE = %d, guesses_left = %d", Max_digit, WINorLOSE, guesses_left);
		tc3: assert(Max_digit == 2'd2) $display("Max digits updated properly");
			else $display("Max digits did NOT update properly");
		tc4: assert(WINorLOSE == 2'd3) $display("win/lose value good");
			else $display("Error: win/lose value not possible at this state");
		tc5: assert(guesses_left == 3'd4) $display("Num available guesses updated properly");
			else $display("Num available guesses did NOT update properly");
			
		$display("Try to see updates to difficulty 3\n");
		@(negedge clk) begin
			round <= 4'd7;
			timer <= 7'd90;
		end
		
		repeat(3) @(posedge clk);
		#1 $display("Difficulty 3 logic: Max Digit = %d, WINorLOSE = %d, guesses_left = %d", Max_digit, WINorLOSE, guesses_left);
		tc6: assert(Max_digit == 2'd3) $display("Max digits updated properly");
			else $display("Max digits did NOT update properly");
		tc7: assert(WINorLOSE == 2'd3) $display("win/lose value good");
			else $display("Error: win/lose value not possible at this state");
		tc8: assert(guesses_left == 3'd5) $display("Num available guesses updated properly");
			else $display("Num available guesses did NOT update properly");
		
	endtask
	
	task test_lose_on_guesses();
	
		$display("\nTest 4: Try to achieve game over state by running out of guesses\n");
		$display("Try to use up all 5 incorrect attempts in difficulty 3\n");
		@(negedge clk) begin
			round <= 4'd7;
			timer <= 7'd90;
		end
		
		repeat(3) @(posedge clk);
		#1 $display("Difficulty 3 logic: Max Digit = %d, WINorLOSE = %d, guesses_left = %d", Max_digit, WINorLOSE, guesses_left);
		
		for (int i = 0; i < 6; i++) begin
			@(negedge clk);
			incorrect_guesses <= incorrect_guesses + 1'b1;
			
			repeat(3) @(posedge clk);
			#1 $display("Difficulty 3 logic: Max Digit = %d, WINorLOSE = %d, guesses_left = %d", Max_digit, WINorLOSE, guesses_left);
			if (guesses_left < 0) begin
				tc9: assert(WINorLOSE == 2'd0) $display("game over achieved successfully by using up all guesses");
					else $display("Game over was NOT achieved despite win/lose flag indicating losing condition");
			end
		end
		
	endtask
	
	task test_win();
	
		$display("\nTest 5: Try to win the game\n");
		@(negedge clk) begin
			round <= 4'd10;
			timer <= 7'd90;
			incorrect_guesses <= 3'd0;
		end
		
		repeat(3) @(posedge clk);
		#1 $display("Max Digit = %d, WINorLOSE = %d, guesses_left = %d", Max_digit, WINorLOSE, guesses_left);
		tc10: assert(WINorLOSE == 2'd1) $display("Winning state has been achieved");
			else $display("Did not achieve a winning state");
		
	endtask
	
	initial begin
		test_lose_on_time();
		test_reset_game_to_diff1();
		verify_game_parameters_by_difficulty();
		test_lose_on_guesses();
		test_reset_game_to_diff1();
		test_win();
	end
	
endmodule