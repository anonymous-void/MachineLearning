function [h, display_array] = displayData(X, example_width)
%DISPLAYDATA Display 2D data in a nice grid
%   [h, display_array] = DISPLAYDATA(X, example_width) displays 2D data
%   stored in X in a nice grid. It returns the figure handle h and the 
%   displayed array if requested.

% Set example_width automatically if not passed in
if ~exist('example_width', 'var') || isempty(example_width) 
	example_width = round(sqrt(size(X, 2)));
% This func wants to display square image, so here use __sqrt() to find
% the width of each image patch
end

% Gray Image
colormap(gray);

% Compute rows, cols
[m n] = size(X);
example_height = (n / example_width);

% Compute number of items to display
% SYM: this funct wants to display given image data in square form
% so, the image patch number must be squarable, then here calc how
% many patches to display in each row.
display_rows = floor(sqrt(m));
display_cols = ceil(m / display_rows);

% Between images padding
% _pad_ is the var for setting black edge between each patch
pad = 1;

% Setup blank display
display_array = - ones(pad + display_rows * (example_height + pad), ...
                       pad + display_cols * (example_width + pad));

% Copy each example into a patch on the display array
curr_ex = 1;	% _curr_ex_ is index var indicating which image patch is under ctrl
for j = 1:display_rows
	for i = 1:display_cols
		if curr_ex > m, 
			break; 
		end
		% Copy the patch
		
		% Get the max value of the patch
% In each image patch, there are 400 pixels (20x20), every pixel
% is represented by float number approximatly between -0.1 ~ 1.1
% Here the _max_val_ used for normalizing the data to strictly between 0 ~ 1
		max_val = max(abs(X(curr_ex, :)));
% This line reshape 400 pixels in each image patch to a matrix array with 
% _example_height_ and _example_width as height and width respectively.
		display_array(pad + (j - 1) * (example_height + pad) + (1:example_height), ...
		              pad + (i - 1) * (example_width + pad) + (1:example_width)) = ...
						reshape(X(curr_ex, :), example_height, example_width) / max_val;
		curr_ex = curr_ex + 1;
	end
	if curr_ex > m, 
		break; 
	end
end

% Display Image

h = imagesc(display_array, [-1 1]);

% Do not show axis
axis image off

drawnow;

end
