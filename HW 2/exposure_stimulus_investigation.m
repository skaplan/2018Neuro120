clear all

load exposure_stimulus_experiment.mat

stimulus_start_times = 0:1/6:(60-1/6); % In seconds

% histogram(spikes_single_unit, stimulus_start_times)
F = cell(360,1)
for trialCount = 1:360
    start = stimulus_start_times(trialCount)
    eee = (start + 1/6)
    filtered = spikes_single_unit((start <= spikes_single_unit) & (eee > spikes_single_unit)) - start
    disp(filtered)
    F{trialCount} = transpose(filtered )
end
plotSpikeRaster(F)
% plot(F)
% ylim([0 size(spikeMat, 1)+1]);

% s = 360
% X  = zeros( s, 1 )
% 
% for i = 1:s
%     acc = 0
%     X(i) = sum(normpdf(spikes_single_unit, stimulus_start_times(i), 5/1000))
% end

% histogram(X, stimulus_start_times)
