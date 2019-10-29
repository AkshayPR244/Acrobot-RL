function  [ xp ] = DoAction( torque, x )
	% Captures the dynamics of the problem
%constants
maxSpeed1 = 4*pi;       % maximum permissible velocity of first rod     
maxSpeed2 = 9*pi;       % maximum permissible velocity of second rod
m1        = 1;          % mass of first rod 
m2        = 1;          % mass of second rod 
l1        = 1;          % lenght of first rod
l2        = 1;          % length of second rod 
l1Square  = l1*l1; 
l2Square  = l2*l2; 
lc1       = 0.5;        % distance of centre of mass of fisrt rod from point of fixture
lc2       = 0.5;        % distance of centre of mass of second rod from end of first rod 
lc1Square = lc1*lc1; 
lc2Square = lc2*lc2;     
I1        = 1;          % moment of inertia of second rod
I2        = 1;          % moment of inertia of first rod
g         = 9.8;        % acceleration due to gravity
delta_t   = 0.05;       % time step

%Unpacking the state
theta1        = x(1); 
theta2        = x(2);
theta1_dot    = x(3);
theta2_dot    = x(4);

% Dynamics Equations 
d1     = m1*lc1Square + m2*(l1Square + lc2Square + 2*l1*lc2 * cos(theta2)) + I1 + I2; 
d2     = m2*(lc2Square+l1*lc2*cos(theta2)) + I2; 

phi2   = m2*lc2*g*cos(theta1+theta2-pi/2); 
phi1   = -m2*l1*lc2*theta2_dot*sin(theta2)*(theta2_dot-2*theta1_dot)+(m1*lc1+m2*l1)*g*cos(theta1-(pi/2))+phi2; 

accel2 = (torque+phi1*(d2/d1)-m2*l1*lc2*theta1_dot*theta1_dot*sin(theta2)-phi2); 
accel2 = accel2/(m2*lc2Square+I2-(d2*d2/d1)); 
accel1 = -(d2*accel2+phi1)/d1; 

    %  Beginning of loop
    for i=1:4
	    theta1_dot = theta1_dot + accel1*delta_t;
        if(theta1_dot<-maxSpeed1) 
            theta1_dot=-maxSpeed1; 
        end        
        if(theta1_dot>maxSpeed1) 
            theta1_dot=maxSpeed1; 
        end
        
	    theta1     =  theta1 + theta1_dot*delta_t; 	    
	    theta2_dot =  theta2_dot + accel2*delta_t;
        
        
        if(theta2_dot<-maxSpeed2)
            theta2_dot=-maxSpeed2; 
        end
        if(theta2_dot>maxSpeed2)
            theta2_dot=maxSpeed2; 
        end
	    
	    theta2 = theta2 + theta2_dot*delta_t; 
    end

% enforcing the limits on angles
if(theta1<-pi) 
    theta1 = -pi; 
end
if(theta1>pi)
    theta1 = pi; 
end    
if(theta2<-pi)
    theta2 = -pi; 
end
if(theta2>pi)
    theta2 = pi; 
end

% Repackaging the state vector
xp(1) = theta1;
xp(2) = theta2;
xp(3) = theta1_dot;
xp(4) = theta2_dot;

        






