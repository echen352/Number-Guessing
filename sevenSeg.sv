module sevenSeg(input logic [7:0]timer,						// timer display
					 input logic [3:0]guesses,						// number of guesses
					 input logic [3:0]guess1, guess2, guess3,	//	3 pushbutton		
					 input logic hint1, hint2, hint3,			// lower or higher
					 input logic [1:0]round,						// round status , LEDs
					 input logic [1:0]difficulty,// 
					output logic [6:0]seg1, seg2, seg3, seg4, seg6, seg7, seg8,
					output logic [2:0]roundLED, diffLED
					);
					
	always_comb
	begin
		case(timer)
			90: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			89: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b0010000;
			end
			88: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b0000000;
			end
			87: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b1111000;
			end
			86: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b0000011;
			end
			85: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b0010010;
			end
			84: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b0011001;
			end
			83: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b0110000;
			end
			82: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b0100100;
			end
			81: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b1111001;
			end
			80: begin
				seg1 <= 7'b0000000;
				seg2 <= 7'b1000000;
			end
			79: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			78: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			77: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			76: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			75: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b0010010;
			end
			74: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b0011001;
			end
			73: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b0110000;
			end
			72: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b0100100;
			end
			71: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1111001;
			end
			70: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			69: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			68: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			67: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			66: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			65: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b0010010;
			end
			64: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b0011001;
			end
			63: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b0110000;
			end
			62: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b0100100;
			end
			61: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1111001;
			end
			60: begin
				seg1 <= 7'b0010000;
				seg2 <= 7'b1000000;
			end
			59: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b1000000;
			end
			58: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b1000000;
			end
			57: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b1000000;
			end
			56: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b1000000;
			end
			55: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b0010010;
			end
			54: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b0011001;
			end
			53: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b0110000;
			end
			52: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b0100100;
			end
			51: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b1111001;
			end
			50: begin
				seg1 <= 7'b0010010;
				seg2 <= 7'b1000000;
			end
			49: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b1000000;
			end
			48: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b1000000;
			end
			47: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b1000000;
			end
			46: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b1000000;
			end
			45: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b0010010;
			end
			44: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b0011001;
			end
			43: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b0110000;
			end
			42: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b0100100;
			end
			41: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b1111001;
			end
			40: begin
				seg1 <= 7'b0011001;
				seg2 <= 7'b1000000;
			end
			39: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b1000000;
			end
			38: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b1000000;
			end
			37: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b1000000;
			end
			36: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b1000000;
			end
			35: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b0010010;
			end
			34: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b0011001;
			end
			33: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b0110000;
			end
			32: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b0100100;
			end
			31: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b1111001;
			end
			30: begin
				seg1 <= 7'b0110000;
				seg2 <= 7'b1000000;
			end
			29: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b1000000;
			end
			28: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b1000000;
			end
			27: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b1000000;
			end
			26: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b1000000;
			end
			25: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b0010010;
			end
			24: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b0011001;
			end
			23: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b0110000;
			end
			22: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b0100100;
			end
			21: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b1111001;
			end
			20: begin
				seg1 <= 7'b0100100;
				seg2 <= 7'b1000000;
			end
			19: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b1000000;
			end
			18: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b1000000;
			end
			17: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b1000000;
			end
			16: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b1000000;
			end
			15: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b0010010;
			end
			14: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b0011001;
			end
			13: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b0110000;
			end
			12: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b0100100;
			end
			11: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b1111001;
			end
			10: begin
				seg1 <= 7'b1111001;
				seg2 <= 7'b1000000;
			end
			9: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b1000000;
			end
			8: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b1000000;
			end
			7: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b1000000;
			end
			6: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b1000000;
			end
			5: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b0010010;
			end
			4: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b0011001;
			end
			3: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b0110000;
			end
			2: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b0100100;
			end
			1: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b1111001;
			end
			0: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b1000000;
			end
			default: begin
				seg1 <= 7'b1111111;
				seg2 <= 7'b1111111;
			end
		endcase
		
		case(guesses)
			1: 
				seg3 <= 7'b1111001;
			2:
				seg3 <= 7'b0100100;
			3:
				seg3 <= 7'b0110000;
			4:
				seg3 <= 7'b0011001;
			5:
				seg3 <= 7'b0010010;
			default:
				seg3 <= 7'b1111111;
		endcase

		case(hint1)
			0: // lower
				seg4 <= 7'b1000111;
			1: // higher
				seg4 <= 7'b0001001; 
			default:
				seg4 <= 7'b1110111;
		endcase
		
		case(round)
			1:
				roundLED <= 3'b001;
			2:
				roundLED <= 3'b010;
			3:
				roundLED <= 3'b100;
			default:
				roundLED <= 3'b000;
		endcase	
		
		case(difficulty)
			1:
				diffLED <= 3'b001;
			2:
				diffLED <= 3'b010;
			3:
				diffLED <= 3'b100;
			default:
				diffLED <= 3'b000;
		endcase

		case(guess1)
			0:
				seg6 <= 7'b1000000;
			1:
				seg6 <= 7'b1111001;
			2:
				seg6 <= 7'b0100100;
			3:
				seg6 <= 7'b0110000;
			4:
				seg6 <= 7'b0011001;
			5:
				seg6 <= 7'b0010010;
			6:
				seg6 <= 7'b0000010;
			7:
				seg6 <= 7'b1111000;
			8:
				seg6 <= 7'b0000000;
			9:
				seg6 <= 7'b0010000;
			default:
				seg6 <= 7'b1111111;
		endcase
		
		case(guess2)
			0:
				seg7 <= 7'b1000000;
			1:
				seg7 <= 7'b1111001;
			2:
				seg7 <= 7'b0100100;
			3:
				seg7 <= 7'b0110000;
			4:
				seg7 <= 7'b0011001;
			5:
				seg7 <= 7'b0010010;
			6:
				seg7 <= 7'b0000010;
			7:
				seg7 <= 7'b1111000;
			8:
				seg7 <= 7'b0000000;
			9:
				seg7 <= 7'b0010000;
			default:
				seg7 <= 7'b1111111;
		endcase
			
		case(guess3)
			0:
				seg8 <= 7'b1000000;
			1:
				seg8 <= 7'b1111001;
			2:
				seg8 <= 7'b0100100;
			3:
				seg8 <= 7'b0110000;
			4:
				seg8 <= 7'b0011001;
			5:
				seg8 <= 7'b0010010;
			6:
				seg8 <= 7'b0000010;
			7:
				seg8 <= 7'b1111000;
			8:
				seg8 <= 7'b0000000;
			9:
				seg8 <= 7'b0010000;
			default:
				seg8 <= 7'b1111111;		
		endcase	

		/*
		case(hint2)
			0: // lower
				seg7 <= 7'b1000111;
			1: // higher
				seg7 <= 7'b0001001;
			default:
				seg7 <= 7'b1110111;
		endcase
		case(hint3)
			0: // lower
				seg8 <= 7'b1000111;
			1: // higher
				seg8 <= 7'b0001001;
			default:
				seg8 <= 7'b1110111;
		endcase
		*/
	end
	
	endmodule