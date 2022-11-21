sintable = zeros(100,2);

% for i=0:1:24
%     for a=1:1:4
%         point = rand*2*pi + i*2*pi;
%         value = sin(point);
%         sinrandom(i*4+a,1) = point;
%         sinrandom(i*4+a,2)=value;
%     end
% end

for i=0:1:24
    for a=1:1:4
        point = i*2*pi + (a-1)*pi/4;
        value = sin(point);
        sintable(i*4+a,1)=point;
        sintable(i*4+a,2)=value;
    end
end

plot(sintable(:,1), sintable(:,2));