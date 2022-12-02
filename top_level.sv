module top_level(input logic clk, rst, confirmButton,
					input logic [2:0] digitButtons,
					output logic [6:0] seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8
					output logic [2:0] roundLED, diffLED);

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
logic [2:0] round;		// Hint -> FSM; Hint -> 7-Seg

// fsm logic
logic [1:0] max_digits;	// FSM -> Input Control; FSM -> 7-Seg; FSM -> Timer
/*************************************************************************************************************************************************/


// asynchronous assert synchronous deassert reset
resetSync fReset(.clk(clk), .rst(rst), .rstSync(rstSync));



// synchronize pushbutton control for digits
synch_digit_inputs fSynchDigits(.sig(digitButtons), .clk(clk), .reset(rstSync),
					.falling_ind(digitSync));



// synchronize pushbutton control for player confirm					
synch_confirm fSynchDigits(.sig(confirmButton), .clk(clk), .reset(rstSync),
					.falling_ind(confirmSync));



/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	controls player input
	inputs: [2:0] digitButtons, [0] confirm, [1:0] max digits, [0] clk,
			[3:0] last confirmed digit1, last confirmed digit2, last confirmed digit3
	outputs: [3:0] new digit 1 to display, [3:0] new digit 2 to display, [3:0] new digit 3 to display,
			 [3:0] new confirmed digit1, new confirmed digit2, new confirmed digit3
*/
input_control fInput(.clk(clk),
					.display_digit_1(digitDisplay1), .display_digit_2(digitDisplay2), .display_digit_3(digitDisplay3),
					input logic [1:0] .max_digits(max digits),
					.pushbuttons(digitSync),
					.confirm(confirmSync),
					.update_digit_1(digitDisplay1), .update_digit_2(digitDisplay2), .update_digit_3(digitDisplay3),
					.confirm_digit_1(confirm_digit_1), .confirm_digit_2(confirm_digit_2), .confirm_digit_3(confirm_digit_3));



/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	controls the progression of the game
	inputs: [2:0] num incorrect guesses, [2:0] num rounds, [6:0] timer, [0] confirm button
	outputs: [2:0] max incorrect guesses, [1:0] max digits
*/
fsm fFSM(.clk(clk), .restart(rstSync),
			.incorrect_guesses(), .round(round), .timer(), .confirmButton(), .Max_digit(max_digits);


/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	controls how much time left in game before game over
	inputs: [0] clk, [1:0] max digits
	outputs: [6:0] counter
*/
timer fTimer(.clk(clk),
				 .difficulty(max_digits), // <- may need to update var name
				 .counter(currentTimerCount));



/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	controls the comparison of digits and control of hint feature
	inputs: [0] clk, [0] confirm button,
			[3:0] player digit 1, [3:0] player digit 2, [3:0] player digit 3
			[3:0] answer digit 1, [3:0] answer digit 2, [3:0] answer digit 3
	output:	[1:0] hint
*/
hint1 fHint(.clk(clk), .confirmButton(confirmSync),
				 .key0(confirm_digit_1), .key1(confirm_digit_2), .key2(confirm_digit_3), answer0, answer1, answer2,
				.hint1(LOWorHIGH), .incorrect_guesses(incorrect_guesses), .round(round));


/*	-----------------------------------------------------------------------------------------------------------------------------------------------
	displays contents of game
	inputs: [7:0] timer, [2:0] guesses left, [1:0] hint, [1:0] round, [1:0] difficulty, [1:0] win or lose,
			[3:0] guess1 (digit1), [3:0] guess2 (digit2), [3:0] guess3 (digit3)
	outputs: [2:0] round (LEDs), [2:0] difficulty (LEDs),
			 [6:0] for all 8 7-segments
*/
sevenSeg f7Seg(.timer(currentTimerCount), .guesses(), .guess1(digitDisplay1), guess2(digitDisplay2), .guess3(digitDisplay3),		
					 .hint1(LOWorHIGH), .round(round),
					 .difficulty(max_digits),
					 input logic [1:0]WINorLOSE,
					.seg1(seg1), .seg2(seg2), .seg3(seg3), .seg4(seg4), .seg5(seg5), .seg6(seg6), .seg7(seg7), .seg8(seg8),
					.roundLED(roundLED), .diffLED(diffLED));

endmodule