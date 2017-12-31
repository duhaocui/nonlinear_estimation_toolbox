clear
clc
close all

% step size
T = 0.01;

% system matrix
sysMatrix = [1, T; 0, 1];

% system noise matrix
sysNoiseMatrix = [T; 1];

% process noise
sysNoise = Gaussian(0, 0.1^2);

% create system model instance and set its parameters
sysModel = LinearSystemModel();
sysModel.setSystemMatrix(sysMatrix);
sysModel.setSystemNoiseMatrix(sysNoiseMatrix);
sysModel.setNoise(sysNoise);

% measurement matrix
H = [1, 0];

% measurement noise
measNoise = Gaussian(0, 0.05^2);

% create measurement model instance and set its parameters
measModel = LinearMeasurementModel();
measModel.setMeasurementMatrix(H);
measModel.setNoise(measNoise);

% estimator
filter = EKF();

% set initial state estimate
initialState = Gaussian(zeros(2, 1), eye(2) );
filter.setState(initialState);

% perform a prediction step
filter.predict(sysModel);

% print predicted stae mean and state covariance matrix by getting its
% Gaussian state estimate
[mean, cov] = filter.getStateMeanAndCov();
fprintf('Predicted state mean:\n');
disp(mean);
fprintf('Predicted state covariance:\n');
disp(cov);
fprintf('\n');

% measurement update
measurement = 2.139;

% perform a measurement udpate
filter.update(measModel, measurement);

% print the updated state estimate
[mean, cov] = filter.getStateMeanAndCov();
fprintf('Updated state mean:\n');
disp(mean);
fprintf('Updated state covariance:\n');
disp(cov);
fprintf('\n');