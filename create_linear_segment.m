function [R_segment, ip, i, iu, il] = create_linear_segment(f0, time, ip, i, iu, il)
% CREATE_LINEAR_SEGMENT creates a linear segment from the f0 contour <f0>
% sampled at time instances <time> based on the indices <i>, <iu> and <il>
% and updates the indices.

% create segment
pitch = ((f0(iu)-f0(il))/2) + f0(il);
duration = time(ip) - time(i);
start_time = time(i);
R_segment = [pitch, start_time, duration];

% update indices

if ip < length(f0)
    i=ip;
    if f0(ip + 1) >= f0(ip) % uphill
        il = ip;
        iu = ip + 1;
        ip = ip + 1;
    else % downhill
        iu = ip;
        il = ip + 1;
        ip = ip + 1;
    end
else
    ip = ip + 1;
    i = i + 1;
end

end

