clear all

pdt = .25;
s = 0;
f = 160;

cur = s;

S = zeros(640);
i = 1;

while cur < f

    I0 = cur;
 I1 = 15;
 hz = 50;
 omega = hz/1000*2*pi;

 Iapp  = @(t) I0 + I1*sin(omega*t);

    use_euler = false;

    theta0 = [0.0003    0.0529    0.3177    0.5961]; % Initial state
    Tfinal = 200; % Duration of simulation in ms
    dt = .01;
    if use_euler
        [t,theta] = euler_solver(@(t,x) hh_deriv(t,x,Iapp), [0 Tfinal], theta0, dt);
    else
        [t,theta] = ode45(@(t,x) hh_deriv(t,x,Iapp), [0 Tfinal], theta0);
    end

    vthresh = 20; % Consider a spike to have occured when voltage crosses this threshold (mV)
    t_thresh = 100; % Only compute firing rate using spikes occuring after this time (in ms)
    v = theta(:,1);
    tspike = t(v(1:end-1) <= vthresh & v(2:end) > vthresh);
    tspike(tspike < t_thresh) = []; % Throw away spikes occuring before t_thresh ms
    if isempty(tspike) % Handle zero firing rate
       tspike = [0 inf]; 
    end
    for ts = tspike
        vline(ts) 
    end

    fr = 1000/median(diff(tspike));
    S(i) = fr;
    fprintf('Firing rate: %d %g Hz \n', cur, fr)
    cur = cur + pdt;
    i = i + 1;
end

figure;
plot(S);