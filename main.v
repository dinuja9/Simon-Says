////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////
//////////////////////////
/////////
//
// Code by: Dinuja Wattage, Ammar Homidan
//
// This project is a simon says implementation, through verilog using the MAX DE10-Lite board.
//
/////////
//////////////////////////
//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////




//This calls all modules that will implement the overall functionality of our project.
module main(switch_LEDs,turn, player1, player2, status, LED10,LED11,LED12,LED13,
				LED14,LED15,LED16,LED20,LED21,LED22,LED23,LED24,LED25,LED26,LED30,LED31,LED32,LED33,
				LED34,LED35,LED36,LED40,LED41,LED42,LED43,LED44,LED45,LED46,LED50,LED51,LED52,LED53,
				LED54,LED55,LED56, cin,reset,cout,firseg,LED60,LED61,LED62,LED63,LED64,LED65,LED66,
				check,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,counter,simon);

 
input simon,turn,cin,reset,check,sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7;

output  LED10,LED11,LED12,LED13,LED14,LED15,LED16,LED20,LED21,LED22,LED23,LED24,LED25,LED26,LED30,
		  LED31,LED32,LED33,LED34,LED35,LED36,LED40,LED41,LED42,LED43,LED44,LED45,LED46,LED50,LED51,
		  LED52,LED53,LED54,LED55,LED56,LED60,LED61,LED62,LED63,LED64,LED65,LED66,cout;		  

output [3:0]firseg;
output [1:0] status;
output [31:0] counter;
output [7:0] switch_LEDs; 
output [31:0] player1, player2;

//*******************************************************************************************************
//The block below will call our modules that will store the sequences and display them on
//the seven-segment display. We also implemented a clock for the countdown for each player.

clock clk(cin,cout,firseg,LED60,LED61,LED62,LED63,LED64,LED65,LED66,turn,reset,counter);

storing(sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,turn,status,check,reset,cin,counter,switch_LEDs,simon);

outcome_SSD outcome(LED10,LED11,LED12,LED13,LED14,LED15,LED16,status);

Static_SSD letter_P(0,0,1,1,0,0,0,LED20,LED21,LED22,LED23,LED24,LED25,LED26); //the letter 'P'

turn_SSD player_turn(LED30,LED31,LED32,LED33,LED34,LED35,LED36,turn); //the current player playing

Static_SSD letter_G(0,1,0,0,0,0,1,LED40,LED41,LED42,LED43,LED44,LED45,LED46); //the letter 'G'
	
Static_SSD letter_O(0,0,0,0,0,0,1,LED50,LED51,LED52,LED53,LED54,LED55,LED56); //the letter 'O'

endmodule 
//*******************************************************************************************************


//*****************************************************************************************************************************

// This module stores the values of each player in their respective registers and compares the player values
// to check if Player 2 stored the same values as simon (Player1). It also indicates whether the outcome is
// W or L (Win or Lose)
module storing(sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,turn,status,check,reset,cin,counter,switch_LEDs,simon);
	input sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,turn,check,reset,cin,simon;
	reg [31:0] player1 = 8'b00000000;	 
	reg [31:0] player2 = 8'b00000000;	
	reg [1:0] win;
	output [1:0] status;
	input [31:0] counter;
	output reg [7:0] switch_LEDs;
	
	assign status = win;
	
//***********************************************************************************************
//This always block will operate at the negative edge of the clock at which it will set
//the corresponding values to the players when the switches are flipped.
//
//
	always@(negedge cin)begin
		
			if(check == 0) begin// check player values
				if(counter == 0) begin //when timer is off
						win = 2'b00;
						player1 = 0;	 
						player2 = 0;	
				end
				else begin // player 1 has finished
					if(turn==1)	begin //checking only after player 2 has entered their sequence
						if(player1 == player2) begin // a match
							win = 2'b11; 
						end
						else begin // not a match
							win = 2'b01; 
						end
					end
				end
			end
			
			else if(check == 1) begin
				if(turn == 0 && simon==1) begin //player 1 turn
					if(sw0 == 1)begin
						player1[0] = 4'b0001; 
						switch_LEDs[0] = 1;
					end
					if(sw1 == 1)begin
						player1[1] = 4'b0001;
						switch_LEDs[1] = 1;	
					end
					if(sw2 == 1)begin
						player1[2] = 4'b0001; 
						switch_LEDs[2] = 1;
					end
						if(sw3 == 1)begin
						player1[3] = 4'b0001; 
						switch_LEDs[3] = 1;
					end
					if(sw4 == 1)begin
						player1[4] = 4'b0001;
						switch_LEDs[4] = 1;	
					end
					if(sw5 == 1)begin
						player1[5] = 4'b0001; 
						switch_LEDs[5] = 1;
					end
						if(sw6 == 1)begin
						player1[6] = 4'b0001; 
						switch_LEDs[6] = 1;
					end
					if(sw7 == 1)begin
						player1[7] = 4'b0001;
						switch_LEDs[7] = 1;	
					end
								
//---------------------------------------------
					if(sw0 == 0)begin
						switch_LEDs[0] = 0;
					end
					if(sw1 == 0)begin
						switch_LEDs[1] = 0;	
					end
					if(sw2 == 0)begin 
						switch_LEDs[2] = 0;
					end
					if(sw3 == 0)begin
						switch_LEDs[3] = 0;	
					end
					if(sw4 == 0)begin 
						switch_LEDs[4] = 0;
					end	
					if(sw5 == 0)begin
						switch_LEDs[5] = 0;
					end
					if(sw6 == 0)begin
						switch_LEDs[6] = 0;	
					end
					if(sw7 == 0)begin
						switch_LEDs[7] = 0;
					end
				end
				
				else if(turn == 1) begin //player 2 turn
					if(sw0 == 1)begin
						player2[0] = 4'b0001; 
						switch_LEDs[0] = 1;
					end
					if(sw1 == 1)begin
						player2[1] = 4'b0001;
						switch_LEDs[1] = 1;	
					end
					if(sw2 == 1)begin
						player2[2] = 4'b0001; 
						switch_LEDs[2] = 1;
					end
						if(sw3 == 1)begin
						player2[3] = 4'b0001; 
						switch_LEDs[3] = 1;
					end
					if(sw4 == 1)begin
						player2[4] = 4'b0001;
						switch_LEDs[4] = 1;	
					end
					if(sw5 == 1)begin
						player2[5] = 4'b0001; 
						switch_LEDs[5] = 1;
					end
						if(sw6 == 1)begin
						player2[6] = 4'b0001; 
						switch_LEDs[6] = 1;
					end
					if(sw7 == 1)begin
						player2[7] = 4'b0001;
						switch_LEDs[7] = 1;	
					end
					
								
//---------------------------------------------
					if(sw0 == 0)begin
						switch_LEDs[0] = 0;
					end
					if(sw1 == 0)begin
						switch_LEDs[1] = 0;	
					end
					if(sw2 == 0)begin 
						switch_LEDs[2] = 0;
					end
					if(sw3 == 0)begin
						switch_LEDs[3] = 0;	
					end
					if(sw4 == 0)begin 
						switch_LEDs[4] = 0;
					end	
					if(sw5 == 0)begin
						switch_LEDs[5] = 0;
					end
					if(sw6 == 0)begin
						switch_LEDs[6] = 0;	
					end
					if(sw7 == 0)begin
						switch_LEDs[7] = 0;
					end	
				end

			end
	end
//***********************************************************************************************
endmodule


//*******************************************************************************************************
//This module was implemented in Lab 4, only a few tweaks were made to adjust for the time limit in our
//case which was 9 seconds.
module clock(cin,cout, firseg,LED60,LED61,LED62,LED63,LED64,LED65,LED66,turn,reset,counter);

input cin, turn,reset;
output reg cout;
output reg [3:0]firseg;
output LED60,LED61,LED62,LED63,LED64,LED65,LED66;

output [31:0] counter;
reg [31:0] count; 
parameter D = 32'd25000000;

assign counter = count;
SSD ss1(firseg[3],firseg[2],firseg[1],firseg[0],LED60,LED61,LED62,LED63,LED64,LED65,LED66);

always @(posedge cin)
begin
   count <= count - 32'd1;
      if(reset==0) begin //reset condition
				cout <= ~cout;
				count <= 450000000;
				firseg <= 4'b1001; // 9
      end
		else if(reset==1) begin 
		
			if(firseg[3]==0 & firseg[2]==0 & firseg[1]==0 & firseg[0]==0)  
				count <= 0;
  
		   case(count)  
				400000000: firseg <= firseg - 4'b0001;
				350000000: firseg <= firseg - 4'b0001;
				300000000: firseg <= firseg - 4'b0001;
				250000000: firseg <= firseg - 4'b0001;  
				200000000: firseg <= firseg - 4'b0001;
				150000000: firseg <= firseg - 4'b0001;
				100000000: firseg <= firseg - 4'b0001;
				 50000000: firseg <= firseg - 4'b0001;
						 10: firseg <= firseg - 4'b0001;
        endcase
       end   
end
endmodule 
//*******************************************************************************************************
//This module was implemented in Lab 2, no changes were made except that we had to create another module
//to account for the letters P,G,O,L,w(displayed as "|_|")
module SSD(w,x,y,z,LED0,LED1,LED2,LED3,LED4,LED5,LED6);

input w,x,y,z;
output LED0,LED1,LED2,LED3,LED4,LED5,LED6;

assign LED0=(~w & ~x & ~y & z)|(~w & x & ~y & ~z)|(w & ~x & y & z)|(w & x & ~y & z);
assign LED1=(~w & x & ~y & z)|(~w & x & y & ~z)|(w & ~x & y & z)|(w & x & ~y & ~z)|(w & x & y & ~z)|(w & x & y & z);
assign LED2=(~w & ~x & y & ~z)|(w & x & y)|(w & x & ~z);
assign LED3=(~w & ~x & ~y & z)|(~w & x & ~y & ~z)|(~w & x & y & z)|(w & ~x & y & ~z)|(w & x & y & z);
assign LED4=(~w & ~x & ~y & z)|(~w & ~x & y & z)|(~w & x & ~y & ~z)|(~w & x & ~y & z)|(w & ~x & ~y & z)|(~w & x & y & z);
assign LED5=(~w & ~x & ~y & z)|(~w & ~x & y & ~z)|(~w & ~x & y & z)|(~w & x & y & z)|(w & x & ~y & z);
assign LED6=(~w & ~x & ~y & ~z)|(~w & ~x & ~y & z)|(~w & x & y & z)|(w & x & ~y & ~z);

endmodule

//*******************************************************************************************************************
//This module will display which player is going (Player1 or Player2) and switching the players will be caused by the 
//flip of switch 9 on the board
module turn_SSD(LED0,LED1,LED2,LED3,LED4,LED5,LED6,turn);

input turn;
reg w,x,y,z;

output LED0,LED1,LED2,LED3,LED4,LED5,LED6;

always@(turn,w,x,y,z)begin
if(turn == 0) begin
	// player1
	w = 0;
	x = 0;
	y = 0;
	z = 1;
end
else if(turn == 1) begin
	//player2
	w = 0;
	x = 0;
	y = 1;
	z = 0;
end
end

assign LED0=(~w & ~x & ~y & z)|(~w & x & ~y & ~z)|(w & ~x & y & z)|(w & x & ~y & z);
assign LED1=(~w & x & ~y & z)|(~w & x & y & ~z)|(w & ~x & y & z)|(w & x & ~y & ~z)|(w & x & y & ~z)|(w & x & y & z);
assign LED2=(~w & ~x & y & ~z)|(w & x & y)|(w & x & ~z);
assign LED3=(~w & ~x & ~y & z)|(~w & x & ~y & ~z)|(~w & x & y & z)|(w & ~x & y & ~z)|(w & x & y & z);
assign LED4=(~w & ~x & ~y & z)|(~w & ~x & y & z)|(~w & x & ~y & ~z)|(~w & x & ~y & z)|(w & ~x & ~y & z)|(~w & x & y & z);
assign LED5=(~w & ~x & ~y & z)|(~w & ~x & y & ~z)|(~w & ~x & y & z)|(~w & x & y & z)|(w & x & ~y & z);
assign LED6=(~w & ~x & ~y & ~z)|(~w & ~x & ~y & z)|(~w & x & y & z)|(w & x & ~y & ~z);

endmodule

//*******************************************************************************************************
//This module displays the letters G and O as we pass in the values of each seperate LED. This module
//will only be touched for displaying letters that will most likely remain static throughout the code.
//

module Static_SSD(y1,y2,y3,y4,y5,y6,y7,LED0,LED1,LED2,LED3,LED4,LED5,LED6);

input y1,y2,y3,y4,y5,y6,y7;
output LED0,LED1,LED2,LED3,LED4,LED5,LED6;

assign LED0= y1;
assign LED1= y2;
assign LED2= y3; 
assign LED3= y4;
assign LED4= y5;
assign LED5= y6;
assign LED6= y7;

endmodule
//*******************************************************************************************************
//This module displays the Win letter (w or |_|), Lose letter (L), or it will display nothing which would 
//mean that the game is in progress. neutral can also mean reset as this allows the players to continue 
//playing the game
module outcome_SSD(LED0,LED1,LED2,LED3,LED4,LED5,LED6,status);

output LED0,LED1,LED2,LED3,LED4,LED5,LED6;
input [1:0]status;
reg y0,y1,y2,y3,y4,y5,y6;

always@(status,y0,y1,y2,y3,y4,y5,y6)begin
	if(status==2'b11)begin
		//display w
		y0 = 1;
		y1 = 1;
		y2 = 0;
		y3 = 0;
		y4 = 0;
		y5 = 1;
		y6 = 1;
	end
	else if(status==2'b01)begin
		//display L
		y0 = 1;
		y1 = 1;
		y2 = 1;
		y3 = 0;
		y4 = 0;
		y5 = 0;
		y6 = 1;
	end
	else if(status==2'b00)begin
		//display nothing
		y0 = 1;
		y1 = 1;
		y2 = 1;
		y3 = 1;
		y4 = 1;
		y5 = 1;
		y6 = 1;
	end
end

assign LED0= y0;
assign LED1= y1;
assign LED2= y2; 
assign LED3= y3;
assign LED4= y4;
assign LED5= y5;
assign LED6= y6;

endmodule 