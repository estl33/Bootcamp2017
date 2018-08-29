//receive commands from AVR guide wire
//if getChar = 's', stop - turn off motorLeft and motorRight
//else if getChar = 'r', right - make left motor turn faster
//else if getChar = 'l', left - make right motor turn faster
//else if getChar = 'f', forward - make left and right motor same speed
//else if getChar = 'b', backward - make left and right motor same speed and reverse direction
//else if getChar = 'r', rotate 180 degrees - make one motor stationary and turn the other motor until field aligns  

void speed(int speed, int motor, int backward);
void stop(void);
void turnRight(void);
void turnLeft(void);
void forward(void);
void backward(void);
void rotate180(void);

void speed(int speed, int motor, int backward)
{
	//change left motor speed
	if(motor = 0)
	{
		out0 = 0;
		out1 = percent;
	}
	//change right motor speed
	if(motor = 1)
	{
		out2 = 0;
		out3 = percent;
	}
	//change both motor speed
	else
	{
		if(!backward)
		{
			out0 = 0;
			out1 = percent;
			out2 = 0;
			out3 = percent;
		}
		else
		{
			out0 = percent;
			out1 = 0;
			out2 = percent;
			out3 = 0;
	}
}

void stop()
{
	//make both motors stop
	speed(0,2,0);
}

void turnRight()
{
	//make left motor turn faster
	speed(100,0);
	//stop right motor 
	speed(0,1);
}

void turnLeft()
{
	//make right motor turn faster
	speed(100,1);
	//stop left motor 
	speed(0,0);
}

void forward()
{
	//set both motors to eqaul default speed
	speed(100,2,0);
}

void backward()
{
	//set both motors to eqaul default speed and reverse direction
	speed(100,2,1);
}

void rotate180()
{
	//equivalent to turn left or turn right
	turnRight();
}
















