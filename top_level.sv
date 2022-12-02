module top_level(input logic clk, rst, confirmButton,
					input logic [2:0] digitButtons);

// synchronized logic
logic rstSync;
logic confirmSync;
logic [2:0] digitSync;

// timer logic
logic [6:0] currentTimerCount;

// input control logic
logic [3:0] digitDisplay1, digitDisplay2, digitDisplay3;

// hint logic
logic [1:0] LOWorHIGH;
/*********************************************************************************************************/


// asynchronous assert synchronous deassert reset
resetSync fReset(.clk(clk), .rst(rst), .rstSync(rstSync));



// synchronize pushbutton control for digits
synch_digit_inputs fSynchDigits(.sig(digitButtons), .clk(clk), .reset(rstSync),
					.falling_ind(digitSync));



// synchronize pushbutton control for player confirm					
synch_confirm fSynchDigits(.sig(confirmButton), .clk(clk), .reset(rstSync),
					.falling_ind(confirmSync));



/*	controls player input
	inputs: [2:0] digitButtons, [0] confirm, [1:0] max digits, [0] clk,
			[3:0] last confirmed digit1, last confirmed digit2, last confirmed digit3
	outputs: [3:0] new digit 1 to display, [3:0] new digit 2 to display, [3:0] new digit 3 to display,
			 [3:0] new confirmed digit1, new confirmed digit2, new confirmed digit3
*/
input_control fInput(.clk(clk),
					.display_digit_1(digitDisplay1), .display_digit_2(digitDisplay2), .display_digit_3(digitDisplay3),
					input logic [1:0] .max_digits(),
					.pushbuttons(digitSync),
					.confirm(confirmSync),
					.update_digit_1(digitDisplay1), .update_digit_2(digitDisplay2), .update_digit_3(digitDisplay3),
					output logic [3:0] confirm_digit_1, confirm_digit_2, confirm_digit_3);



/*	controls the progression of the game
	inputs: [2:0] num incorrect guesses, [2:0] num rounds, [6:0] timer, [0] confirm button
	outputs: [2:0] max incorrect guesses, [1:0] max digits
*/
fsm fFSM(.clk(clk), .restart(rstSync),
			.incorrect_guesses(), .round(), .timer(), .confirmButton(), .Max_digit();


/*	controls how much time left in game before game over
	inputs: [0] clk, [1:0] max digits
	outputs: [6:0] counter
*/
timer fTimer(.clk(clk),
				 .difficulty(), // <- may need to update var name
				 .counter(currentTimerCount));


/*	displays contents of game
	inputs: [7:0] timer, [2:0] guesses left, [1:0] hint, [1:0] round, [1:0] difficulty, [1:0] win or lose,
			[3:0] guess1 (digit1), [3:0] guess2 (digit2), [3:0] guess3 (digit3)
	outputs: [2:0] round (LEDs), [2:0] difficulty (LEDs),
			 [6:0] for all 8 7-segments
*/
sevenSeg f7Seg(.timer(currentTimerCount), .guesses(), .guess1(digitDisplay1), guess2(digitDisplay2), .guess3(digitDisplay3),		
					 .hint1(LOWorHIGH),
					 input logic [1:0]round,						// round status , LEDs
					 input logic [1:0]difficulty,
					 input logic [1:0]WINorLOSE,					// should get vaule from other module. 11 is diff 1, 2 or 3. 1 is win, 0 is lose
					output logic [6:0]seg1, seg2, seg3, seg4, seg6, seg7, seg8, seg5,
					output logic [2:0]roundLED, diffLED
					);

endmodule