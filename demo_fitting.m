% SCRIPT DEMONSTRATING THE USE OF fitting.m TO CONVERT A PITCH CONTOUR INTO
% A PIECE-WISE LINEAR FUNCTION

% load demo f0 data
f0 = load('./data/f0_test.csv');
t = f0(:,1);
f0 = f0(:,2);

% convert f0 from Hz to cents
f0 = 1200 * log2(f0 / 440);

% run curve fitting algorithm
R = fitting(f0, t, 100);

% plot the result
plot(t, f0);
hold on;
for i = 1 : length(R)
    plot([R(i, 2), R(i, 2) + R(i, 3)], [R(i, 1), R(i, 1)], 'r-', 'LineWidth',2);
end
