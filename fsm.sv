  module FIFO_fsm(input logic clk, key3,
					   input logic [2:0]guess, round,
					   input logic [6:0]timer,
						
					  output logic [6:0]Max_timer,
					  output logic [2:0]Max_guess, 
					  output logic [1:0]Max_digit
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
				
					if( timer > 0 && guess <= 3 && round > 3) begin
						nextState <= diff2;
					end else if ( timer == 0 && guess > 3 && round <= 3) begin
							nextState <= gameover;
					end else
							nextState <= diff1;
							
				end
				
				diff2: begin
				
					if( timer > 0 && guess <= 4 && round > 3) begin
						nextState <= diff3;
					end else if ( timer == 0 && guess > 4 && round <= 3) begin
							nextState <= gameover;
					end else
							nextState <= diff2;
				end
				
				diff3: begin
				
					if( timer > 0 && guess <= 5 && round > 3) begin
						nextState <= win;
					end else if ( timer == 0 && guess > 5 && round <= 3) begin
							nextState <= gameover;
					end else
							nextState <= diff3;
				end	
				
				win: begin
					if(key3)
						nextState <= diff1;
					else 
						nextState <= win;
				end
				
				gameover: begin
					if(key3)
						nextState <= diff1;
					else 
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
				Max_timer <= 30;
				Max_guess <= 3;
				Max_digit <= 1;
			end
			diff2: begin
				Max_timer <= 60;
				Max_guess <= 4;
				Max_digit <= 2;
			end
			diff3: begin
				Max_timer <= 90;
				Max_guess <= 5;
				Max_digit <= 3;
			end
			gameover: begin
				Max_timer <= 0;
				Max_guess <= 0;
				Max_digit <= 0;
			end
			win: begin
				Max_timer <= 0;
				Max_guess <= 0;
				Max_digit <= 0;
			end
		endcase
	end

endmodule
