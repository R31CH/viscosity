clear;
clc;
V = VideoReader('bubbles_water.mp4');
fps = V.FrameRate;
Num = floor(V.Duration*fps); % how many images in my video
pixel2cm = 3/35;% distance(cm) / number of pixels
xcut = [226 300]; ycut = [319 658];
Nstart = 150; Nskip = 3;
figure(1)

clf; % clear figure
colormap gray
it = 0;
for ii=Nstart:Nskip:Num
    it = it + 1;
    Io = read(V,ii-1); %Io = permute(Io,[2 1 3]);
    Bo = Io(:,:,3);
    I = read(V,ii); %I = permute(I,[2 1 3]);
    R = I(:,:,1); G = I(:,:,2); B = I(:,:,3);
    Ic = B(ycut(1):ycut(2),xcut(1):xcut(2)); 
    %Ico = Bo(ycut(1):ycut(2),xcut(1):xcut(2));
    imagesc(255-(Ic))
    axis tight
    title(num2str(ii))
    [xo,yo,k] = ginput(1);
    switch(char(k))
        case 'q'
            it = it-1;
            break
        case 's'
            it = it-1;
        otherwise
            x(it) = xo*pixel2cm;
            y(it) = yo*pixel2cm;
            t(it) = it/fps; % in seconds
    end
end

figure(2)
plot(t,y,'o')
xlabel('Time(s)')
ylabel('Position (cm)')
title('Position')

figure(3)
plot(t,gradient(y),'o')
xlabel('Time(s)')
ylabel('Velocity(cm)')
title('Velocity (approx.)')