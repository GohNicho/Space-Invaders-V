module player (input clock, input reset, input left, input right, input [9:0] x, input [9:0] y,
	output [9:0] red, output [9:0] green, output [9:0] blue);
	
	reg [2:0] idx;
	reg [9:0] x_pos;
	reg [9:0] y_pos;
	reg [20:0] c_clock;
	
	// CLOCK DELAY (DON'T TOUCH)
	always @(negedge clock) 
		begin
			c_clock = c_clock + 1;
		end
		
	// Player movement
	always @ (c_clock[20])
	begin
		if(~left && x_pos < -250)
			x_pos <= x_pos - 5;
		else if (~right && x_pos < 250)
			x_pos <= x_pos + 5;
	end
	
	// Drawing loop
	always @ (x, y)
		begin
			if((x > 270 + x_pos) && (x < 290 + x_pos) && (y > 420 + y_pos) && (y < 440 + y_pos)) idx <= 3'd7;
			else idx <= 3'd0;
		end

	assign red = (idx[0]? 10'h3ff: 10'h000);
	assign green = (idx[1]? 10'h3ff: 10'h000);
	assign blue = (idx[2]? 10'h3ff: 10'h000);
endmodule
	