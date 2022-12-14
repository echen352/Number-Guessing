  module fsm(input logic clk, restart,
						input logic [2:0]incorrect_guesses,
						input logic [3:0] round,
						input logic [6:0]timer,
						output logic [1:0]Max_digit,
						output logic [1:0]WINorLOSE,
						output logic [2:0]guesses_left
						);
	
	logic [2:0]Max_incorrect_guesses;	// max possible incorrect guesses depends on state
	logic [1:0] reg_max_digit = 2'b01;	// register initializes max digit value
	
	assign guesses_left = Max_incorrect_guesses - incorrect_guesses;	// for the player to see
	assign Max_digit = reg_max_digit;	// output max digit from register
	
	typedef enum logic [2:0] {diff1, diff2, diff3, gameover, win} stateType;
	
	stateType presentState = diff1, nextState;

	always_ff @(posedge clk)
	begin
		if (!restart) begin
			presentState <= diff1;	// go to 1st difficulty on reset
		end else
			presentState <= nextState;
	end
	
	
	always_ff @(posedge clk)
	begin
		if (!restart) begin
			reg_max_digit <= 2'b01;	// reset register for max digit value
		end
			case(presentState)			
				diff1: begin
							if( round > 3 ) begin	// guess correctly 3x for 1st difficulty
								reg_max_digit <= 2'b10;	// increase max digit value to 2
								nextState <= diff2;	// move to 2nd difficulty
							end else if ( timer == 0 || incorrect_guesses > Max_incorrect_guesses ) begin
								nextState <= gameover;	// time runs out or too many bad guesses
							end else
								nextState <= diff1;	// no player activity
						end
					
				diff2: begin		
							if( round > 6 ) begin	// guess correctly 3x for 2nd difficulty
								reg_max_digit <= 2'b11;	// increase max digit value to 3
								nextState <= diff3;	// move to 3rd difficulty
							end else if ( timer == 0 || incorrect_guesses > Max_incorrect_guesses ) begin
								nextState <= gameover;
							end else
								nextState <= diff2;
					end
					
				diff3: begin				
							if( round > 9 ) begin	// guess correctly 3x for 3rd difficulty
								nextState <= win;	// move to win state
							end else if ( timer == 0 || incorrect_guesses > Max_incorrect_guesses ) begin
								nextState <= gameover;
							end else
								nextState <= diff3;
					end	
					
				win: begin
						nextState <= win;	// stay in win state until reset
					end
					
				gameover: begin
						nextState <= gameover;	// stay in game over state until reset
					end
					
				default: begin
						nextState <= diff1;
					end		
			endcase
	end
			
	always_ff@(posedge clk)
	begin
		case(presentState)
			diff1: begin
				Max_incorrect_guesses <= 3;
				WINorLOSE <= 2'b11;	// Continue gameplay
			end
			
			diff2: begin
				Max_incorrect_guesses <= 4;
				WINorLOSE <= 2'b11;
			end
			
			diff3: begin
				Max_incorrect_guesses <= 5;
				WINorLOSE <= 2'b11;
			end
			
			gameover: begin
				Max_incorrect_guesses <= 0;
				WINorLOSE <= 2'b0;	// Lose condition
			end
			
			win: begin
				Max_incorrect_guesses <= 0;
				WINorLOSE <= 2'b1;	// Win condition
			end
			
		endcase
	end

endmodule
