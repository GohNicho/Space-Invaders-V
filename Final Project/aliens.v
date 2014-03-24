module aliens(input clock, input reset, input right, input left, input [9:0] x, input [9:0] y,
	output [9:0] red, output [9:0] green, output [9:0] blue);
	reg [2:0] idx;
	reg [7:0] x_incre = 0;
	reg [7:0] y_incre = 0;
	reg direction = 0;
		
	reg [9:0] x_pos = 0;
	reg [9:0] y_pos = 0;
	reg [9:0] x_posP = 0;

	reg [22:0] c_clock;
	
	// CLOCK DELAY (DON'T TOUCH)
	always @(negedge clock) 
		begin
			c_clock = c_clock + 1;
		end
// ---------------------------------------------
// ENEMY SECTION		
	// Direction loop
	always @(negedge c_clock[21] or negedge reset)
		begin
		if(~reset)
			begin
				x_pos <= 0;
				y_pos <= 0;
				direction <= 0;
			end
		else if(direction == 0)
			begin
				x_pos <= x_pos + 10;
				if(x_pos >= 560)
					begin
						direction <= 1;
						y_pos <= y_pos + 20;
					end
			end
		else
			begin
				x_pos <= x_pos - 10;
				if(20 >= x_pos) 
					begin
						direction <= 0;
						y_pos <= y_pos + 20;
					end
			end
		end
/*
		// Enemy ships
	always @ (x, y)
		begin
			if((x > 20 + x_pos) && (x < 40 + x_pos) && (y > 20 + y_pos) && (y < 40 + y_pos)) idx <= 3'd7;
			else idx <= 3'd0;
		end
*/
// END ENEMY SECTION
// ---------------------------------------------
		
// ---------------------------------------------
// PLAYER SECTION	
		// Movement
	always @ (negedge c_clock[21])
	begin
		if(~left)
			begin
				if(x_posP >= -215)
					x_posP <= x_posP - 5;
			end
		else if(~right)
			begin
				if(215 >= x_posP)
					x_posP <= x_posP + 5;
			end
	end
	
	// Drawing loop
	always @ (x, y)
		begin
			if((x > 20 + x_pos) && (x < 40 + x_pos) && (y > 20 + y_pos) && (y < 40 + y_pos)) idx <= 3'd7;
			else if((x > 272 + x_posP) && (x < 278 + x_posP) && (y > 392) && (y < 401)) idx <= 3'd7;
			else if((x > 260 + x_posP) && (x < 290 + x_posP) && (y > 400) && (y < 410)) idx <= 3'd7;
			else idx <= 3'd0;
		end
// END PLAYER SECTION
// ---------------------------------------------
	assign red = (idx[0]? 10'h3ff: 10'h000);
	assign green = (idx[1]? 10'h3ff: 10'h000);
	assign blue = (idx[2]? 10'h3ff: 10'h000);
endmodule