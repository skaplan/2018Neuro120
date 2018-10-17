clear all

load exposure_stimulus_experiment.mat
load exposure_stimulus_experiment.mat

stimulus_start_times = 0:1/6:(60-1/6); % In seconds

% histogram(spikes_single_unit, stimulus_start_times)
F = zeros(100, 15)
for trialCount = 1:10
    start = stimulus_start_times(trialCount)
    eee = (start + 1/6)
    filtered = spikes_single_unit((start <= spikes_single_unit) & (eee > spikes_single_unit))
    mini = start:1/100:(eee - 1/100)
    [N, edges] = histcounts(filtered, mini)
    
    for spikeCount = 1:length(190)
        plot([N(spikeCount) N(spikeCount)], ...
            [trialCount-0.4 trialCount+0.4], 'k');
    end

%     disp("ab")
%     disp(size(N))
%         disp(size(F(2)))
% 
    F(trialCount,:) = N
%     for spikeCount = 1:length(spikePos)
%         plot([spikePos(spikeCount) spikePos(spikeCount)], ...
%             [trialCount-0.4 trialCount+0.4], 'k');
%     end
end
disp(F)
ylim([0 size(10, 1)+1]);
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
