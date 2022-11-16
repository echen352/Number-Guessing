  module FIFO_fsm(input logic clk, key0, key1, key2, key3,
						input logic [2:0]guess, round,
						input logic [6:0]downcounter;
						output logic full,
						output logic empty,
						output logic wen, ren
						);
			   
	typedef enum logic [2:0] {diff1, diff2, diff3, gameover, win} stateType;
	
	stateType presentState = diff1, nextState;

	always_ff @(posedge clk)
	//begin
	//	if(!rstSync)
	//		presentState <= idle;
	//	else
			presentState <= nextState;
	end
	
	logic [6:0]timer;
	
	always_ff @(posedge clk)
	begin	
//		if(!rstSync) begin
//				nextState <= idle;
//				wrAddr <= 2'b00;
//				rdAddr <= 2'b00;	
//		end else begin	
			case(presentState)
				diff1: begin
					timer <= downcounter;
				
					if( timer > 0 && guess <= 3 && round > 3) begin
						nextState <= diff2;
					end else if ( timer == 0 && guess > 3 && round <= 3) begin
							nextState <= gameover;
					end else
							nextState <= diff1;
							
				end
				
				diff2: begin
					timer <= downcounter;
				
					if( timer > 0 && guess <= 4 && round > 3) begin
						nextState <= diff3;
					end else if ( timer == 0 && guess > 4 && round <= 3) begin
							nextState <= gameover;
					end else
							nextState <= diff2;
				end
				
				diff3: begin
					timer <= downcounter;
				
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
	
		//end
	end
endmodule
