module hint123(input logic clk, comfirmButton,
				 input logic [3:0]key0, key1, key2, answer0, answer1, answer2,
				 input logic [1:0]Max_digit,
				output logic [1:0]hint1, // 0 is lower, 1 is higher
				output logic [2:0]round = 0, 
				output logic [2:0]incorrect_guess = 0
				);


always_ff@(posedge clk)
begin
	if(comfirmButton)begin
		case(Max_digit)
			1:begin
				if(key0 == answer0)
					round <= round + 1;
				if(key0 > answer0)begin
					hint1 <= 0;
					incorrect_guess <= incorrect_guess + 1;
				end
				if(key0 < answer0)begin
					hint1 <= 1;
					incorrect_guess <= incorrect_guess + 1;				
				end
			end
			2:begin
				if(key1 == answer1 && key0 == answer0)
					round <= round + 1;
				if(key1 > answer1)begin
					hint1 <= 0;
					incorrect_guess <= incorrect_guess + 1;
				end
				if(key1 < answer1)begin
					hint1 <= 1;
					incorrect_guess <= incorrect_guess + 1;				
				end
			end			
			3:begin
				if(key2 == answer2 && key1 == answer1 && key0 == answer0)
					round <= round + 1;
				if(key2 > answer2)begin
					hint1 <= 0;
					incorrect_guess <= incorrect_guess + 1;
				end
				if(key2 < answer2)begin
					hint1 <= 1;
					incorrect_guess <= incorrect_guess + 1;				
				end			
			end
			
	end
	endcase
end

/*				
always_ff @(posedge clk)
begin
	if(comfirmButton)begin
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