module hint123(input logic clk, confirmButton, restart,
				input logic [3:0]key0, key1, key2, answer0, answer1, answer2,
				input logic [1:0]Max_digit,
				output logic [1:0]hint1,
				output logic [3:0]round, 
				output logic [2:0]incorrect_guess
				);

	// round starts at '1'
	logic [3:0] reg_round = 4'd1;
	logic [2:0] reg_incorrect_guess_d1 = 3'd0, reg_incorrect_guess_d2 = 3'd0, reg_incorrect_guess_d3 = 3'd0;

	assign round = reg_round;
	
	// output logic assignments depend on the difficulty of the game
	always_comb
	begin
		if (Max_digit == 2'd1)
			incorrect_guess <= reg_incorrect_guess_d1;
		else if (Max_digit == 2'd2)
			incorrect_guess <= reg_incorrect_guess_d2;
		else if (Max_digit == 2'd3)
			incorrect_guess <= reg_incorrect_guess_d3;
		else
			incorrect_guess <= 3'd0;
	end
	
	// block responsible for determining round progression, incorrect guesses, and player hints
	always_ff@(posedge clk)
	begin
		if (!restart) begin
			hint1 <= 2'b11;
			reg_round <= 1;
			reg_incorrect_guess_d1 <= 0;
			reg_incorrect_guess_d2 <= 0;
			reg_incorrect_guess_d3 <= 0;
		end else begin
			if(confirmButton)begin	// check player input only when they confirm their guess
				case(Max_digit)
					1:	begin	// case for single digit comparison
							if(key0 == answer0) begin
								reg_round++;	// move to next round upon correct guess
								hint1 <= 2'b11;		// do not provide player with any hint
							end else begin
								reg_incorrect_guess_d1++;	// record incorrect guesses
							end
							
							if(key0 > answer0)	// checks if player guess is greater than answer
								hint1 <= 0;		// prompts player to guess lower on next attempt
							if(key0 < answer0)	// checks if player guess is less than answer
								hint1 <= 1;		// prompts player to guess higher on next attempt			
						end
					
					2:	begin	// case for double digit comparison
							if(key1 == answer1 && key0 == answer0) begin
								reg_round++;	// next round if 2 digits are correct
								hint1 <= 2'b11;
							end else begin
								reg_incorrect_guess_d2++;
							end
								
							if(key1 > answer1)
								hint1 <= 0;
							if(key1 < answer1)
								hint1 <= 1;
							
							if (key1 == answer1) begin	// compare digit 1 if digit 2 is correct
								if(key0 > answer0)
									hint1 <= 0;
								if(key0 < answer0)
									hint1 <= 1;
							end
						end			
					
					3:	begin	// case for triple digit comparison
							if(key2 == answer2 && key1 == answer1 && key0 == answer0) begin
								reg_round++;	// next round if all 3 digits are correct
								hint1 <= 2'b11;
							end else begin
								reg_incorrect_guess_d3++;
							end
								
							if(key2 > answer2)
								hint1 <= 0;
							if(key2 < answer2)
								hint1 <= 1;
							
							if (key2 == answer2) begin		// compare digit 2 if digit 3 is correct
								if(key1 > answer1)
									hint1 <= 0;
								if(key1 < answer1)
									hint1 <= 1;
								
								if (key1 == answer1) begin	// compare digit 1 if digit 2 & 3 are correct
									if(key0 > answer0)
										hint1 <= 0;
									if(key0 < answer0)
										hint1 <= 1;
								end
							end				
						end
				default:begin
							hint1 <= 2'b11;
							reg_round <= 1;
							reg_incorrect_guess_d1 <= 0;
							reg_incorrect_guess_d2 <= 0;
							reg_incorrect_guess_d3 <= 0;
						end
				endcase
			end
		end
	end

endmodule