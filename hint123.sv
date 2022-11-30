module hint1(input logic clk, comfirmButton,
				 input logic [3:0]key0, key1, key2, answer0, answer1, answer2,
				output logic [1:0]hint1
				);

					
always_ff @(posedge clk)
begin
	if(comfirmButton)begin
		if(key2 > answer2)begin
			hint1 <= 0;
		end else if(key2 < answer2)begin
			hint1 <= 1;
		end else begin
			if(key1 > answer1)begin
				hint1 <= 0;
			end else if(key1 < answer1)begin
				hint1 <= 1;
			end else begin
				if(key0 > answer0)begin
					hint1 <= 0;
				end else if(key0 < answer0)begin
					hint1 <= 1;
				end else
					hint1 <= 3; // all 3 digits are correct. set hint seg to default
			end
		end
	end
end

endmodule