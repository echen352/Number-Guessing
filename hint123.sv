module hint123(input logic clk, confirmButton, restart,
				 input logic [3:0]key0, key1, key2, answer0, answer1, answer2,
				 input logic [1:0]Max_digit,
				output logic [1:0]hint1, // 0 is lower, 1 is higher
				output logic [1:0]round, 
				output logic [2:0]incorrect_guess
				);


always_ff@(posedge clk)
begin
	if (!restart) begin
		hint1 <= 2'b11;
		round <= 1;
		incorrect_guess <= 0;
	end
	else begin
		if(confirmButton)begin
			case(Max_digit)
				1:	begin	// case for single digit comparison
						if(key0 == answer0) begin
							if (round < 2'd4) begin
								round <= round + 1'b1;	// move to next round upon correct guess
							end else begin
								round <= 0;		// reset round for next difficulty
							end
							hint1 <= 2'b11;		// do not provide player with any hint
						end else begin
							incorrect_guess <= incorrect_guess + 1'b1;	// record incorrect guesses
						end
						
						if(key0 > answer0)	// checks if player guess is greater than answer
							hint1 <= 0;		// prompts player to guess lower on next attempt
						if(key0 < answer0)	// checks if player guess is less than answer
							hint1 <= 1;		// prompts player to guess higher on next attempt			
					end
				
				2:	begin	// case for double digit comparison
						if(key1 == answer1 && key0 == answer0) begin
							if (round < 2'd4) begin
								round <= round + 1'b1;	// next round if 2 digits are correct
							end else begin
								round <= 0;
							end
							hint1 <= 2'b11;
						end else begin
							incorrect_guess <= incorrect_guess + 1'b1;
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
							if (round < 2'd4) begin
								round <= round + 1'b1;	// next round if all 3 digits are correct
							end else begin
								round <= 0;
							end
							hint1 <= 2'b11;
						end else begin
							incorrect_guess <= incorrect_guess + 1'b1;
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
						round <= 1;
						incorrect_guess <= 0;
					end
			endcase
		end
	end
end

/*				
always_ff @(posedge clk)
begin
	if(confirmButton)begin
		if(key2 > answer2)begin
			hint1 <= 0;
			incorrect_guess <= incorrect_guess + 1;
		end else if(key2 < answer2)begin
			hint1 <= 1;
			incorrect_guess <= incorrect_guess + 1;
		end else begin
			if(key1 > answer1)begin
				hint1 <= 0;
				incorrect_guess <= incorrect_guess + 1;
			end else if(key1 < answer1)begin
				hint1 <= 1;
				incorrect_guess <= incorrect_guess + 1;
			end else begin
				if(key0 > answer0)begin
					hint1 <= 0;
					incorrect_guess <= incorrect_guess + 1;
				end else if(key0 < answer0)begin
					hint1 <= 1;
					incorrect_guess <= incorrect_guess + 1;
				end else
					hint1 <= 3; // all 3 digits are correct. set hint seg to default
					round <= round + 1;
			end
		end
	end
end
*/
endmodule