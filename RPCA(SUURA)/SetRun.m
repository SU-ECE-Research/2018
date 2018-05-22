%time test RPCA run

disp('test 01');
run_tests('\\ecefs2\ResearchData\2018\RPCA(SUURA)\Data\0.000001\', 'IMG_%04d.JPG', 0031, 0063, 0.000001)
disp('test 02');
run_tests('\\ecefs2\ResearchData\2018\RPCA(SUURA)\Data\0.00001\', 'IMG_%04d.JPG', 0031, 0063, 0.00001)
disp('test 03');
run_tests('\\ecefs2\ResearchData\2018\RPCA(SUURA)\Data\0.0001\', 'IMG_%04d.JPG', 0031, 0063, 0.0001)
disp('test 04');
run_tests('\\ecefs2\ResearchData\2018\RPCA(SUURA)\Data\0.001\', 'IMG_%04d.JPG', 0031, 0063, 0.001)
disp('test 05');
run_tests('\\ecefs2\ResearchData\2018\RPCA(SUURA)\Data\0.01\', 'IMG_%04d.JPG', 0031, 0063, 0.01)
disp('test 06');
run_tests('\\ecefs2\ResearchData\2018\RPCA(SUURA)\Data\0.1\', 'IMG_%04d.JPG', 0031, 0063, 0.1)
disp('test 07');
run_tests('\\ecefs2\ResearchData\2018\RPCA(SUURA)\Data\1\', 'IMG_%04d.JPG', 0031, 0063, 1)
