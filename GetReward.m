function [ r,f ] = GetReward( x )
% Return reward attained at succrent state
% x: a vector of states
% r: the returned reward.
% f: flag variable true if the acrobot reached the goal, otherwise f is false


theta1 = x(1);
theta2 = x(2);
y_acrobot(1) = 0;
y_acrobot(2) = y_acrobot(1) - cos(theta1);
y_acrobot(3) = y_acrobot(2) - cos(theta2);    




%goal
goal = y_acrobot(1) + 1.0 ; % goal is defined when robot reaches vertical state

% initialize reward and flag 
r = -1;% reward is -1 whenever goal state is not achieved %y_acrobot(3);
f = false;

if( y_acrobot(3) >= goal) 
	r = 100; % reward for achieving goal   %10*y_acrobot(3);        
    f = true; % goal is reached episode will terminate upon flag == true.
end

   


    
   


    
