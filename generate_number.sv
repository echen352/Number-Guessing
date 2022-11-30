module generate_number(output logic [3:0] digit_1, digit_2, digit_3);

always_comb
begin
	digit_1 <= $urandom_range(9, 0); // difficulty 1 -> 1 digit range from 0 to 9
	digit_2 <= $urandom_range(9, 0); // difficulty 2 -> 2 digits range from 0 to 99
	digit_3 <= $urandom_range(9, 0); // difficulty 3 -> 3 digits range from 0 to 999
end

endmodule