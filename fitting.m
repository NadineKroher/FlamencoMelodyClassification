function R = fitting(f0, time, alpha)
% FITTING Implementation of the curve fitting algorithm as described in 
% Díaz-Báñez, J. M. and Mesa, A. (2001). Fitting rectilinear polygonal 
% curves to a set of points in the plane. European Journal of Operational 
% Research, 130(1):214?222. This implementation refers to its use in the
% context of melodic contour quantization.
% Input: f0 - contour in cents
%        time - time instances where f0 has been sampled
%        alpha - error tolerance
% Output: R - array describing piece-wise linear function; array holding
%             linear segments of form 
%             [start time sec] [duration sec] [pitch cents]

% initialization
f0_len = length(f0);
R = [];
i=1; % current segment start index
ip=1; % current time index

% check if sequence starts with increase or decrease in pitch
if f0(i+1) >= f0(i) 
    il = i; % index of lowest pitch value
    iu = i + 1; % index of highest pitch value
    ip = i + 1; % index of reference pitch value
else 
    iu = i; % index of highest pitch value
    il = i + 1; % index of highest pitch value
    ip = i + 1; % index of reference pitch value
end

while i < f0_len
    if ip < f0_len
        % check if we are still in the tolerance window
        epsilon_max = max(abs(f0(iu) - f0(ip)), abs(f0(il) - f0(ip))); 
        if epsilon_max <= alpha
            if f0(ip) >= f0(iu)
                iu = ip;
                ip = ip + 1;
            elseif f0(ip) <= f0(il)
                il = ip;
                ip = ip + 1;
            else
                ip = ip + 1;
            end
        else
            % create linear segment and update indices
            [R_segment, ip, i, iu, il] = create_linear_segment(f0, time, ip, i, iu, il);
            R = [R; R_segment];
        end
    else
        % create final segment
        [R_segment, ~, ~, ~, ] = create_linear_segment(f0, time, ip, i, iu, il);
        R = [R; R_segment];
        break 
    end
end


end

