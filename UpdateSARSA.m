function [ Q ] = UpdateSARSA( s, a, r, sp, ap, Q , alpha, gamma )

% s: previous state before taking action (a)
% sp: current state after action (a)
% r: reward received from the environment after taking action (a) in state
%                                             s and reaching the state sp
% a:  the last executed action
% tab: the current Qtable
% alpha: learning rate
% gamma: discount factor
% Q: the resulting Qtable

Q(s,a) =  Q(s,a) + alpha * ( r + gamma*Q(sp,ap) - Q(s,a) );