% a = [55,36,43,27,96,08,15,22,04,44,02,36,01,04,36,12,10,96,13,31,29,48,02,32,15,28,04,26,41,36,01,04,22,48,30,96,13,27,13,30,08,45,55,37,09,40,01,14,96,37,42,36,38,48,05,18,49,43,40,06,08,33,04,97,08,01,14,44,18,24,16,30,04,27,43,08,97,21,07,21,15,18,24,21,55,60,24,41,40,01,14]
% 
% z = zeros(100,1)
% 
% for i = 1:length(a)
%     z(a(i)) =  z(a(i))+1
% end
% 
% bar(z)

text = "WXQOWK LXCFRXBCXUAWJO R URXLXCFRXBCXUAWJO J AKAWXQOBM WXNXRUSDEQOWKBCUKBM FDEPACOQK UO NOLDEOWDEROBM";
text = upper(text);
text = regexprep(text, '[^A-Z]', '');

text = char(text);
% Count occurrences of each letter
alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
counts = zeros(1, length(alphabet));
for ii = 1:length(text)
    letter = text(ii);
    index = find(alphabet == letter);
    counts(index) = counts(index) + 1;
end

% Plot bar chart
x_values = 1:length(alphabet);
bar(x_values, counts)
set(gca, 'XTick', x_values)
xlabel('Letter')
ylabel('Occurrences')
title('Occurrences of each letter in text')