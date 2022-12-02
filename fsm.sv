  module fsm(input logic clk, restart, 		// restart is reset button, change to sw
					   input logic [2:0]incorrect_guesses, round,
					   input logic [6:0]timer,
						input logic confirmButton,		// comfirm the input number
					  //output logic [6:0]Max_timer,
					  output logic [2:0]Max_incorrect_guesses, 
					  output logic [1:0]Max_digit,
					  output logic diff_timer
						);
			   
	typedef enum logic [2:0] {diff1, diff2, diff3, gameover, win} stateType;
	
	stateType presentState = diff1, nextState;

	always_ff @(posedge clk)
	begin
			presentState <= nextState;
	end
	
	
	always_ff @(posedge clk)
	begin	
			case(presentState)
				diff1: begin
						diff_timer <= 1;
					if(confirmButton)begin
						if( timer > 0 && incorrect_guesses <= 2 && round > 4 ) begin
							nextState <= diff2;
						end else if ( timer == 0 || incorrect_guesses > 2 ) begin
								nextState <= gameover;
						end else
								nextState <= diff1;
					end else
						nextState <= diff1;
				end
				
				diff2: begin
						diff_timer <= 2;
					if(confirmButton)begin				
						if( timer > 0 && incorrect_guesses <= 3 && round > 4 ) begin
							nextState <= diff3;
						end else if ( timer == 0 || incorrect_guesses > 3 ) begin
								nextState <= gameover;
						end else
								nextState <= diff2;
					end else
						nextState <= diff2;
				end
				
				diff3: begin
						diff_timer <= 3;
					if(confirmButton)begin				
						if( timer > 0 && incorrect_guesses <= 4 && round > 4 ) begin
							nextState <= win;
						end else if ( timer == 0 || incorrect_guesses > 4 ) begin
								nextState <= gameover;
						end else
								nextState <= diff3;
					end else
						nextState <= diff3;
				end	
				
				win: begin
					diff_timer <= 0;
					if(confirmButton)begin
						if(restart)
							nextState <= diff1;
						else 
							nextState <= win;
					end else
						nextState <= win;
				end
				
				gameover: begin
						diff_timer <= 0;
					if(confirmButton)begin
							if(restart)
								nextState <= diff1;
							else 
								nextState <= gameover;					
					end else
						nextState <= gameover;
				end
				
				default: begin
					nextState <= diff1;
				end
				
			endcase
	end
			
	always_comb
	begin
		case(presentState)
			diff1: begin
				//Max_timer <= 30;
				Max_incorrect_guesses <= 3;
				Max_digit <= 1;
			end
			diff2: begin
				//Max_timer <= 60;
				Max_incorrect_guesses <= 4;
				Max_digit <= 2;
			end
			diff3: begin
				//Max_timer <= 90;
				Max_incorrect_guesses <= 5;
				Max_digit <= 3;
			end
			gameover: begin
				//Max_timer <= 0;
				Max_incorrect_guesses <= 0;
				Max_digit <= 0;
			end
			win: begin
				//Max_timer <= 0;
				Max_incorrect_guesses <= 0;
				Max_digit <= 0;
			end
		endcase
	end

endmodule
