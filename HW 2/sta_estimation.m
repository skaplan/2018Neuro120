clear all

% Load DMR stimulus specrogram and spiking responses from one neuron
load dmr_experiment

% Plot spectrogram of stimulus
% plot_spectrogram(stim_spectrogram, stim_time, stim_freq)

A = stim_spectrogram * transpose(stim_spectrogram)

imagesc(A);
%% Generate STA
t_past = 125; % in ms
t_future = 125; % in ms
sampling_rate = mean(median(diff(stim_time)));
sta_time = (-t_past/1000):sampling_rate:(t_future/1000);
sta_freq = stim_freq;

nfreq = size(sta_freq, 2);
ntimes = size(sta_time, 2);

staprime = zeros(nfreq, ntimes);

nspikes = 982;

for i = 1:nspikes
        for k = 1:ntimes
            spiketime = spikes(i);
            t = sta_time(k);
            stim_times = find(stim_time > t + spiketime & stim_time <= (t + sampling_rate + spiketime));
            stim_specs = stim_spectrogram(:, stim_times);
            staprime(:,k) = staprime(:,k)  + stim_specs;
        end
    
end

sta = staprime / nspikes;

% Plot results
figure(2)
plot_spectrogram(sta, sta_time, sta_freq);


xlabel('Time relative to spike (ms)')
colorbar