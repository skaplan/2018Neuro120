function [t, y] = euler_solver(odefun, tspan, y0, dt)
% Solve differential equation y' = f(t,y), from time tspan = [t0 t_final], 
% with initial condition y0. Here odefun must be a function with signature 
% odefun(t,y), which for a scalar t and a vector y returns a column vector 
% corresponding to f(t,y). The solver uses the integration timestep dt. 
% Each row in the solution array y corresponds to a time returned in the 
% column vector t.
t0 = tspan(1);
t_final = tspan(2);

t1 = t0;
y1 = y0;
i = 2;
steps = int64( (t_final - t0) / dt);
T  = zeros( steps, 1 ) ;
Y  = zeros( steps, length(y0) ) ;
T(1) = t0;
Y(1,:) = y0;

while t1 < t_final
    m = odefun(t1,y1);

    y1 = y1 + dt*m.';
    t1 = t1 + dt; 

    T(i) = t1;
    Y(i, :) = y1;
    
    i = i + 1;
end

t = T;
y = Y;
end