function [ mu1, sigma1, N ] = EKF_SLAM( mu0, sigma0, u, z1, N, alpha, R, Q, dt)
% EKF SLAM algorithm, as shown in Table 10.2.
% Usage: [mu1,sigma1,N] = EKF_SLAM( mu0, sigma0, u, z1, N, alpha)
% 
% arguments: (input)
%  mu0 -    matrix of the last pose and of the known positions of the
%           landmarks. The first column contains the pose [x,y,theta]', and 
%           each other column contains the values of the landmarks
%           [range,bearing,signature]'
% 
%  sigma0 - last pose's error and error on the landmarks' positions
% 
%  u    -   new command [v,w,theta]'
% 
%  z1   -   new landmarks measurements. Each column is [range,bearing,signature]
% 
%  N    -   Number of landmarks known in the last timestep. integer
%
%  alpha -  The threshold for the creation of a new landmark
% 
%  R     -  Covariance(3x3 matrix) of the additional motion noise [x,y,theta]
% 
%  Q     -  Covariance(3x3 matrix) of the additional measurement noise [range;bearing;signature]
% 
%  dt    -  Time step
% 
% arguments: (output)
%  mu1    - new matrix of the pose and the landmarks' positions. same form as mu0
% 
%  sigma1 - the new pose's error and landmarks' errors
%
%  N    -   Number of landmarks known in the current timestep. integer
% 
% Author: Olivier Dugas
% Release: 1.0
% Release date : 11/16/2012

% Calculation of the Jacobians
F = [eye(3) zeros(3,3*N)];  % State Transition Matrix

%Motion update
%new pose estimation
Fprod = F'*[-u(1)/u(2)*sin(mu0(3,1)) + u(1)/u(2)*sin(wrapToPi(mu0(3,1)+u(2)*dt)); ...
                 u(1)/u(2)*cos(mu0(3,1)) - u(1)/u(2)*cos(wrapToPi(mu0(3,1)+u(2)*dt)); ...
                 u(2)*dt ];
for col=1:numel(mu0(1,:))
    mu1_(:,col) = mu0(:,col) + Fprod((col-1)*3 +1:(col)*3);
end
mu1_(3,1) = wrapToPi(mu1_(3,1));

%Error propagation
g = [0, 0, -u(1)/u(2)*cos(mu0(3,1)) + u(1)/u(2)*cos(wrapToPi(mu0(3,1)+u(2)*dt)); ...
     0, 0, -u(1)/u(2)*sin(mu0(3,1)) + u(1)/u(2)*sin(wrapToPi(mu0(3,1)+u(2)*dt)); ...
     0, 0,  0];
G = eye(3*N+3) + F'*g*F;
sigma1_ = G*sigma0*G' + F'*R*F;

%Next loop is the measurement update
for i=1:(numel(z1)/3) %For all observed features
    %definition of the feature [range, bearing, signature]
    r=z1(1,i);
    b=z1(2,i);
    s=z1(3,i);
    feature = [r;b;s];
    %Hypothesis of a new landmark
    mu1_(:,1+N+1) = [mu1_(1,1);mu1_(2,1);s] + r*[cos(wrapToPi(b+mu1_(3,1)));
                                               sin(wrapToPi(b+mu1_(3,1)));
                                               0];
    temp = sigma1_;
    [m,n] = size(sigma1_);
    sigma1_ = eye(3*(N+2)).*999999;
    sigma1_(1:m, 1:n) = temp;

    %initialization of variables that will be updated inside the next loop
    zhat = zeros(3,N+1);
    H = zeros(3,3+3*(N+1),N+1);
    psi = zeros(3,3, N+1);
    pik = zeros(1,N+1); %Maximum likelihood correspondences
    %Loop through all known landmarks to compute various update quantities
    for k=2:1+N+1
        dx = mu1_(1,k)-mu1_(1,1);
        dy = mu1_(2,k)-mu1_(2,1);
        delta = [dx; dy];
        q = delta'*delta;

        zhat(:,k-1) = [sqrt(q);
                       wrapToPi(atan2(dy,dx)-mu1_(3,1));
                       mu1_(3,k)];

        Fk = [F zeros(3, (3*(N+2))-(numel(F(1,:))));
              zeros(3) zeros(3, 3*(k-2)) eye(3) zeros(3,3*((N+1)-(k-1)))];

        h = [-sqrt(q)*dx, -sqrt(q)*dy, 0, sqrt(q)*dx, sqrt(q)*dy, 0;
             dy,           -dx,       -q,    -dy,         dx,     0;
              0,            0,         0,      0,          0,     q];
        H(:,:,k-1) = (1/q)*h*Fk;

       %Psi is stored in it's inverted form, because only the inverted form is used.
        psi(:,:,k-1) = inv(H(:,:,k-1)*sigma1_*H(:,:,k-1)' + Q);

        error = feature-zhat(:,k-1);
        error(2) = wrapToPi(error(2));
        pik(k-1) = error' * psi(:,:,k-1) * error;
    end

    %Threshold for the creation of a new landmark
    pik(N+1) = alpha;

    %Maximum likelihood estimation
    min = Inf;
    j = 0;
    for k=1:N+1
        if pik(k) <= min
            j = k;
            min = pik(k);
        end
    end

    %Decide if the hypothesis of a new landmark is valid or not.
    %If landmark is accepted as a new one, increment N
    N = max(N,j);

    %Creation of the Kalman gain for the measurement update of the current feature
    K = sigma1_ * H(:,:,j)' * psi(:,:,j);

    %Update of the poses and their errors
    error = feature-zhat(:,j);
    error(2) = wrapToPi(error(2));
    %mu1_ = mu1_ + K * error;
    K_err_product = K * error;
    for col=1:numel(mu1_(1,:))
        mu1_(:,col) = mu1_(:,col) + K_err_product((col-1)*3 +1:(col)*3);
    end
    mu1_(3,1) = wrapToPi(mu1_(3,1));

    sigma1_ = (eye(numel(sigma1_(:,1)))-K*H(:,:,j))*sigma1_;
end

mu1 = mu1_(:,1:N+1);
sigma1 = sigma1_(1:3*N+3, 1:3*N+3);
end