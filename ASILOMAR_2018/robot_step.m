function [ robotPos ] = robot_step(int_robotPos,U,sV,sW,dt);
    robotPos=int_robotPos;
    
    v = U(1) + sV*randn; % noisy control for translational speed
    w = U(2) + sW*randn; % noisy control for angular speed
    robotPos(1) = robotPos(1) + -v/w*sin(robotPos(3)) + v/w*sin(wrapToPi(robotPos(3)+w*dt)); % robot position in x
    robotPos(2) = robotPos(2) + v/w*cos(robotPos(3)) - v/w*cos(wrapToPi(robotPos(3)+w*dt)); % robot position in y
    robotPos(3) = wrapToPi(robotPos(3) + w*dt);

end

