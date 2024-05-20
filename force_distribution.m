% Load the result file and present the force distribution
%% Junyi Lin, force_distribution, Oct9 2023, Version 1

%% House Keeping
clear all;
close all;

%% File Loading
load('DATA/cohesion/DSC_0025_Copy_solved.mat-postProcessingWorkspace.mat');
force_data = cell2mat({particle(:).forces});

histogram(force_data, 'BinEdges', 0:0.15:2.5, 'Normalization', 'count'); % Adjust bin edges as needed
xlabel('Force Values');
ylabel('Count');
title('Histogram of Force Values');