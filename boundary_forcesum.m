% Summing up vertical force segments of a specific boundary
%% boundary_forcesum, Junyi Lin, Jun12 2024, Version 1

% Housekeeping
clear all;
close all;

% Define the directory and file
directory = 'DATA/static_verification/';
files = dir([directory, 'IMG_0765_solved.mat-postProcessingWorkspace.mat']); % which files are we processing?

% Load the data from the specified file
load([directory, files(1).name]);

% Define the particle numbers to analyze
%particle_numbers = [78, 21, 24, 129, 9, 27, 35];
particle_numbers = [92, 23, 3, 29];

% Initialize the sum of forces
Sumforce = 0;

% Loop through each particle number
for num = particle_numbers
    % Check if the particle exists in the data
    if num <= length(particle) && ~isempty(particle(num).forces)
        % Get the forces and beta values for the particle
        forces = particle(num).forces;
        beta = particle(num).betas;
        alpha = particle(num).alphas;
        
        % Loop through each force and corresponding beta value
        for i = 1:length(forces)
            % Check if the beta value is between -pi and 0
            if beta(i) >= -pi && beta(i) <= 0
                % Transfer the force segment into a vertical force segment
                vertical_force = forces(i) * (cos((pi/2) - (alpha(i) + beta(i))));
                % Sum up the forces
                Sumforce = Sumforce + vertical_force;
            end
        end
    end
end

% Display the result
disp(['Sum of vertical forces: ', num2str(Sumforce)]);
