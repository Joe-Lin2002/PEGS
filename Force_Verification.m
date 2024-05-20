% Verify the force on the top most layer
%% Force_Verification, Junyi Lin, Jun2 2023, Version 1

clear all; %Housekeeping
close all; %Housekeeping

directory = 'DATA/large_container_static/';
load([directory, 'frame_210_solved.mat-postProcessingWorkspace.mat']); %Load the data resulted from PeGSForceAdjMat.m

hold on;
for n=1:length(particle)
    viscircles([particle(n).x; particle(n).y]', particle(n).r,'EdgeColor',particle(n).color); %draw particle outline
    hold on;
    plot(particle(n).x,particle(n).y,'rx'); %Mark particle centers
    text(particle(n).x,particle(n).y,num2str(particle(n).id),'Color','k','BackgroundColor','w');
end
yvalue = [particle.y]; %Data Transfer
thres_height = min(yvalue)+particle(find(yvalue==min(yvalue))).r; %Find out the base line
yline(thres_height,'Color','r','LineWidth',3);

top_layer_index = find(yvalue<thres_height); %Finding the index number of grains above threshold line
sum_force = 0;

for n=1:length(top_layer_index)
    beta_value = particle(top_layer_index(n)).betas; %Export all beta angle value for the grain
    valid_index_no = find(beta_value < ((-pi/2)+0.3) & beta_value > ((-pi/2)-0.3));
    top_force = particle(top_layer_index(n)).forces(valid_index_no);
    if isempty(top_force)
        top_force = 0;
    end
    sum_force = sum_force + sum(top_force);
    text(particle(top_layer_index(n)).x-50,particle(top_layer_index(n)).y-150,[num2str(top_force),'N'],'Color','k');
end

text(100,100,['Sum of Forces at Top Layer: ',num2str(sum_force),'N'],'Color','k','FontSize',14);