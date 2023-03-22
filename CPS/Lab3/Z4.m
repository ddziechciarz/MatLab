function L3Z4
					%% point A: unpacking the packets
	clc
	close all;
	clear all;
	
	load('lab_03.mat');
	
	K = 8;			% frame amount
	N = 512;		% data sample amount
	M = 32;			% prefix sample amount
	
	%plot(x_13);
	
	f = rand(1,512+32);
	kek = unpackFrame(f,N,M,0);
	
	for i = 1:K		% unpacking all the frames into a matrix
		offset = (i-1)*(M+N)+1;
		x(i,:) = unpackFrame(x_13,N,M,offset);
					
		%cheb120Win = chebwin(N,120)';		% can use the Chebyshev window to increase the visibility
		%x(i,:) = x(i,:) .* cheb120Win;
	end

					%% performing transform
	for i = 1:K
		X(i,:) = fft(x(i,:))./N;
	end
	
					%% plotting
					
	%fs = 2048000;
	fs = N;
	dt = 1/fs;
	df = 1/(N*dt);
	f = 0:df:(N-1)*df;
	
	for i = 1:K
		figure('Name',['Frame number: ' num2str(i)],'NumberTitle','off');
		plot(f,20*log10(abs(X(i,:))),'r');	% plotting in dB for better visibility
		%plot(f,abs(X(i,:)),'b');
		%plot(f(1:length(f)/2),abs(X(i,1:length(X)/2)));
	end
	
end

function [x] = unpackFrame(f,N,M,offset)
	x = f(M+1+offset:N+M+offset);
end
