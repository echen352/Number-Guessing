module synch_confirm(input logic sig,
					input logic clk, reset,
					output logic sigSync, rising_ind, falling_ind);


logic sig_FF1, sig_FF2, sig_FF3;

always_ff @(posedge clk or negedge reset)
begin
	if (!reset) begin
		sig_FF1 <= 1'b0;
		sig_FF2 <= 1'b0;
		sig_FF3 <= 1'b0;
	end
	else begin
		sig_FF1 <= sig;
		sig_FF2 <= sig_FF1;
		sig_FF3 <= sig_FF2;
	end
end

always_comb
begin
	sigSync <= sig_FF2;
	falling_ind <= ~sig_FF2 & sig_FF3;
	rising_ind <= sig_FF2 & ~sig_FF3;
end

endmodule
