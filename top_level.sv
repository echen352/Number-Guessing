module top_level(input logic clk, rst, confirmButton,
					input logic [2:0] digitButtons,
					output logic [6:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,
					output logic [2:0] roundLED, diffLED);

// divided clock
logic oclk;

// synchronized logic
logic rstSync;			// rstSync -> all FFs
logic confirmSync;		// Sync -> Input Control
logic [2:0] digitSync;	// Sync -> Input Control

// timer logic
logic [6:0] currentTimerCount;	// Timer -> 7-Seg

// input control logic
logic [3:0] digitDisplay1, digitDisplay2, digitDisplay3;	// loop Input Control -> Input Control
logic [3:0] confirm_digit_1, confirm_digit_2, confirm_digit_3;	// Input Control -> Hint

// hint logic
logic [1:0] LOWorHIGH;	// Hint -> 7-Seg
logic [3:0] round;		// Hint -> FSM; Hint -> 7-Seg
logic [2:0] incorrect_guesses;	// Hint -> FSM

// get target number logic
logic [3:0] target_digit_1, target_digit_2, target_digit_3; // get target number -> Hint

// fsm logic
logic [1:0] max_digits;	// FSM -> Input Control; FSM -> 7-Seg; FSM -> Timer
logic [1:0] WINorLOSE;	// FSM -> 7-Seg
logic [2:0] guesses_left;	// FSM -> 7-Seg
/*************************************************************************************************************************************************/

// clock divider
clockdiv fClockdiv(.iclk(clk), .oclk(oclk));
						
						

// asynchronous assert synchronous deassert reset
resetSync fReset(.clk(clk), .rst(rst), .rstSync(rstSync));



// synchronize pushbutton control for digits
synch_digit_inputs fSynchDigits(.sig(digitButtons), .clk(clk), .reset(rstSync),
					.falling_ind(digitSync));



// synchronize pushbutton control for player confirm					
synch_confirm fSynchConfirm(.sig(confirmButton), .clk(clk), .reset(rstSync),
					.falling_ind(confirmSync));



/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	input_control:	controls player input
	inputs: [2:0] digitButtons, [0] confirm, [1:0] max digits, [0] clk, [0] restart,
			[3:0] last confirmed digit1, last confirmed digit2, last confirmed digit3
	outputs: [3:0] new digit 1 to display, [3:0] new digit 2 to display, [3:0] new digit 3 to display,
			 [3:0] new confirmed digit1, new confirmed digit2, new confirmed digit3
*/
input_control fInput(.clk(clk), .restart(rstSync),
					//.display_digit_1(digitDisplay1), .display_digit_2(digitDisplay2), .display_digit_3(digitDisplay3),
					.max_digits(max_digits),
					.pushbuttons(digitSync),
					.confirm(confirmSync),
					.update_digit_1(digitDisplay1), .update_digit_2(digitDisplay2), .update_digit_3(digitDisplay3));
					//.compare_digit_1(confirm_digit_1), .compare_digit_2(confirm_digit_2), .compare_digit_3(confirm_digit_3));



/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	fsm:	controls the progression of the game
	inputs: [2:0] num incorrect guesses, [1:0] num rounds, [6:0] timer, [0] confirm button, [0] restart, [0] clk
	outputs: [1:0] max digits, [1:0] Win/Lose, [2:0] guesses left
*/
fsm fFSM(.clk(clk), .restart(rstSync), .confirmButton(confirmSync),
			.incorrect_guesses(incorrect_guesses), .round(round), .timer(currentTimerCount),
			.Max_digit(max_digits), .WINorLOSE(WINorLOSE), .guesses_left(guesses_left));


/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	timer:	controls how much time left in game before game over
	inputs: [0] clk, [0] restart, [1:0] max digits
	outputs: [6:0] counter
*/
timer fTimer(.clk(oclk), .restart(rstSync),
				 .Max_digit(max_digits),
				 .counter(currentTimerCount));



/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	hint:	controls the comparison of digits and control of hint feature
	inputs: [0] clk, [0] confirm button, [0] restart,
			[3:0] player digit 1, [3:0] player digit 2, [3:0] player digit 3
			[3:0] answer digit 1, [3:0] answer digit 2, [3:0] answer digit 3
	output:	[1:0] hint
*/
/*hint123 fHint(.clk(clk), .confirmButton(confirmSync), .restart(rstSync), .Max_digit(max_digits),
				 .key0(confirm_digit_1), .key1(confirm_digit_2), .key2(confirm_digit_3),
				 .answer0(target_digit_1), .answer1(target_digit_2), .answer2(target_digit_3),
				.hint1(LOWorHIGH), .incorrect_guess(incorrect_guesses), .round(round));*/
hint123 fHint(.clk(clk), .confirmButton(confirmSync), .restart(rstSync), .Max_digit(max_digits),
				 .key0(digitDisplay1), .key1(digitDisplay2), .key2(digitDisplay3),
				 .answer0(target_digit_1), .answer1(target_digit_2), .answer2(target_digit_3),
				.hint1(LOWorHIGH), .incorrect_guess(incorrect_guesses), .round(round));


/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	get target number:	gets the target number for the player to guess
	inputs: [1:0] Max digit, [2:0] round,
	output:	[3:0] target digit 1, [3:0] target digit 2, [3:0] target digit 3
*/
get_target_number fGetNum(.clk(clk), .Max_digit(max_digits), .round(round),
				.target_digit_1(target_digit_1), .target_digit_2(target_digit_2), .target_digit_3(target_digit_3));



/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	sevenSeg:	displays contents of game
	inputs: [7:0] timer, [2:0] guesses left, [1:0] hint, [1:0] round, [1:0] difficulty, [1:0] win or lose,
			[3:0] guess1 (digit1), [3:0] guess2 (digit2), [3:0] guess3 (digit3)
	outputs: [2:0] round (LEDs), [2:0] difficulty (LEDs),
			 [6:0] for all 8 7-segments
*/
sevenSeg f7Seg(.clk(clk), .timer(currentTimerCount), .guesses(guesses_left), .guess1(digitDisplay1), .guess2(digitDisplay2), .guess3(digitDisplay3),		
					 .hint1(LOWorHIGH), .round(round),
					 .difficulty(max_digits),
					 .WINorLOSE(WINorLOSE),
					.seg1(seg1), .seg2(seg2), .seg3(seg3), .seg4(seg4), .seg5(seg5), .seg6(seg6), .seg7(seg7), .seg8(seg8),
					.roundLED(roundLED), .diffLED(diffLED));

endmodule