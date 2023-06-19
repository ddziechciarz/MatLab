values = [1 2]

% Create a cell array of strings for the column headers
headers = {'Index', 'Value'};

% Create a table with two columns
tableData = table(values, 'VariableNames', headers);

% Display the table
disp(tableData);