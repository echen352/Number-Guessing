`timescale 1ns/1ns
module test_all();

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
	
	task confirm();
		repeat(3) @(negedge clk);
		confirmButton <= 1'b1;	// click confirm
		
		repeat(3) @(negedge clk);
		confirmButton <= 1'b0;	// let go of confirm
		
		@(posedge clk);
		#1 $display("roundLED = %d, diffLED = %d\n", roundLED, diffLED);
	endtask
	
	task press_key_0();
		repeat(3) @(negedge clk);
		digitButtons <= 3'b001;	// press pushbutton to update digit 1
		
		repeat(3) @(negedge clk);
		digitButtons <= 3'b000;	// depress pushbutton
	endtask
	
	task press_key_1();
		repeat(3) @(negedge clk);
		digitButtons <= 3'b010;	// press pushbutton to update digit 2
		
		repeat(3) @(negedge clk);
		digitButtons <= 3'b000;	// depress pushbutton
	endtask
	
	task press_key_2();
		repeat(3) @(negedge clk);
		digitButtons <= 3'b100;	// press pushbutton to update digit 3
		
		repeat(3) @(negedge clk);
		digitButtons <= 3'b000;	// depress pushbutton
	endtask
	
	task beat_diff1();
		@(negedge clk) begin
			rst <= 1'b1;
			confirmButton <= 1'b0;
		end
		
		repeat(2) press_key_0();
		// this should be 002 now
		
		confirm();
		
		repeat(6) press_key_0();
		// this should be 008 now
		
		confirm();
		
		repeat(5) press_key_0();
		// this should be 003 now
		
		confirm();
		
	endtask
	
	task beat_diff2();
		repeat(4) press_key_0();
		// this should be 007 now
		
		repeat(5) press_key_1();
		// this should be 057 now
		
		confirm();
		
		repeat(9) press_key_0();
		// this should be 056 now
		
		repeat(4) press_key_1();
		// this should be 096 now
		
		confirm();
		
		repeat(5) press_key_0();
		// this should be 091 now
		
		repeat(3) press_key_1();
		// this should be 021 now
		
		confirm();
		
	endtask
	
	task beat_diff3();
		repeat(2) press_key_0();
		// this should be 023 now
		
		repeat(0) press_key_1();
		// this should be 023 now
		
		repeat(1) press_key_2();
		// this should be 123 now
		
		confirm();
		
		repeat(2) press_key_0();
		// this should be 125 now
		
		repeat(3) press_key_1();
		// this should be 155 now
		
		repeat(4) press_key_2();
		// this should be 555 now
		
		confirm();
		
		repeat(4) press_key_0();
		// this should be 559 now
		
		repeat(4) press_key_1();
		// this should be 599 now
		
		repeat(4) press_key_2();
		// this should be 999 now
		
		confirm();
		
	endtask
	
	task win_case();
		//********start at difficulty 1********
		
		beat_diff1();
		
		//********move to difficulty 2********
		
		beat_diff2();
		
		//********move to difficulty 3********
		
		beat_diff3();
		
		repeat(10) @(posedge clk);
		check_win();
		check_lose();
		
	endtask
	
	task lose_case_diff1();
		@(negedge clk) begin
			rst <= 1'b1;
			confirmButton <= 1'b0;
		end
		
		repeat(2) press_key_0();
		// this should be 002 now
		
		confirm();
		
		repeat(6) press_key_0();
		// this should be 008 now
		
		confirm();
		
		for (int i = 0; i < 4; i++) begin	// make more than 3 incorrect guesses
		
			press_key_0();
		
			confirm();
			
		end
		
		repeat(10) @(posedge clk);
		check_win();
		check_lose();
		
	endtask
	
	task lose_case_diff2();
		//********start at difficulty 1********
		
		beat_diff1();
		
		//********move to difficulty 2********
		
		repeat(4) press_key_0();
		// this should be 007 now
		
		repeat(5) press_key_1();
		// this should be 057 now
		
		confirm();
		
		repeat(9) press_key_0();
		// this should be 056 now
		
		repeat(4) press_key_1();
		// this should be 096 now
		
		confirm();
		
		for (int i = 0; i < 5; i++) begin	// make more than 4 incorrect guesses
		
			press_key_0();
			
			press_key_1();
			
			confirm();
			
		end

		repeat(10) @(posedge clk);
		check_win();
		check_lose();
		
	endtask
	
	task lose_case_diff3();
		//********start at difficulty 1********
		
		beat_diff1();
		
		//********move to difficulty 2********
		
		beat_diff2();
		
		//********move to difficulty 3********
		
		for (int i = 0; i < 6; i++) begin	// make more than 5 incorrect guesses
		
			press_key_0();
			
			press_key_1();
			
			press_key_2();
			
			confirm();
			
		end
		
		repeat(10) @(posedge clk);
		check_win();
		check_lose();
		
	endtask
	
	task check_win();
		checkwin: assert(seg1 == 7'b0010000 && seg2 == 7'b0100011 && seg3 == 7'b0100011 && seg4 == 7'b0100001 && seg5 == 7'b1111111
		&& seg6 == 7'b1110001 && seg7 == 7'b0100011 && seg8 == 7'b0000011) $display("7-segment shows the win message\n");
		else $display("7-segment does not show the win message 'good job'\n");
	endtask
	
	task check_lose();
		checklose: assert(seg1 == 7'b0010001 && seg2 == 7'b0100011 && seg3 == 7'b1100011 && seg4 == 7'b1111111 && seg5 == 7'b1000111
		&& seg6 == 7'b0100011 && seg7 == 7'b0010010 && seg8 == 7'b0000100) $display("7-segment shows the game over message\n");
		else $display("7-segment does not show game over message 'you lose'\n");
	endtask
	
	task reset();
		$display("Reset Game\n");
		repeat(100) @(negedge clk);
		rst <= 1'b0;
		
		repeat(3) @(negedge clk);
		rst <= 1'b1;
		
		repeat(3) @(negedge clk);
		
	endtask
	
	initial begin
		$display("%t ns, Test case for Win Condition", $time);
		win_case();
		reset();
		
		$display("%t ns, Test case for Lose Condition on difficulty 1", $time);
		lose_case_diff1();
		reset();
		
		$display("%t ns, Test case for Lose Condition on difficulty 2", $time);
		lose_case_diff2();
		reset();
		
		$display("%t ns, Test case for Lose Condition on difficulty 3", $time);
		lose_case_diff3();
		
	end
	
endmodule