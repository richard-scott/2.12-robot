
% initialize the object for interfacing with the dynamixels
d = Dynamixels(2);
port = 6;
kbps = 4;
d.Connect(port, kbps);

% initialize the object for deriving arm kinematics
ak = ArmKinematics(18.0, 23.8);

% goal coordinates in cm
x = 0;
y = 16;

%if ak.inWorkspace(x,y)
%    [theta1, theta2] = ak.findThetas(x,y);
%    d.SetGoalPos(1,Dynamixels.rad2value(theta1));
%    d.SetGoalPos(2,Dynamixels.rad2value(theta2));
%else
%    disp('Point is outside of the workspace of the arm.');
%end

f = 0.5*2*pi;
a = 5;
tic;
while toc < 20
    x = a*cos(f*toc);
    y = 30 + a*sin(f*toc);
    if ak.inWorkspace(x,y)
        [theta1, theta2] = ak.findThetas(x,y);
        d.SetGoalPos(1,Dynamixels.rad2value(theta1));
        d.SetGoalPos(2,Dynamixels.rad2value(theta2));
    end
end

d.Disconnect();