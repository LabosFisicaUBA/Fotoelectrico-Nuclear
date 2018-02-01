%% NI daq, como las sensordaq

disp('NI USB-6210')
disp('MANUAL: ')

%para saber que aparatos hay conectados
%hw = daqhwinfo('nidaq'); 
hw=daq.getDevices
disp(hw)
%hw.InstalledBoardIds
%hw.BoardNames


%ai = analoginput('nidaq','Dev3');%inicializo la conexion (uso DevX sacada de las lineas anteriores)
ai= daq.createSession('ni');
ch=addAnalogInputChannel(ai,'Dev3','ai1','Voltage')
%addchannel(ai, 0);%agrego canales (ver manual)

%%
duracion=0.3;
ai.DurationInSeconds = duracion;
%duracion = 10;%duracion en segundos
%ai.SampleRate = 250000;%configuro rate (en Hz)
ai.Rate = 250000;%configuro rate (en Hz)
%ai.SamplesPerTrigger = ai.SampleRate*duracion;

%configuro el modo diferencial o singleended
% ai.InputType='SingleEnded';%%[ NonReferencedSingleEnded | SingleEnded | {Differential} ]
ch.InputType = 'Differential';%%[ NonReferencedSingleEnded | SingleEnded | {Differential} ]

X=linspace(0,10,8192);%bins
hist_todos=zeros(size(X));
tic
%%
for j=1:50
  %  start(ai);%mando un trigger, arranco la medicion
    [data,time] = ai.startForeground();
    data2 = (data.^2).^(0.5); %pido voltaje positivo
    pause(duracion+0.1)%espero un poquito mas que lo que dura la medicion
  %  [data time] = getdata(ai);%le pido los datos
    [pks,locs] = findpeaks(data2,'MINPEAKHEIGHT',0.3); %valor a partir del cual se considera que es un pico
    
    figure(1);clf;
    subplot(2,1,1);hold all
    plot(time,data2)
    plot(time(locs),pks,'k^','markerfacecolor',[1 0 0]); 
    ylim([-1 3])
     
    h=hist(pks,X);
    hist_todos=hist_todos+h; % se van sumando los histrogramas de cada ciclo
    
    subplot(2,1,2);hold all
    plot(X,hist_todos,'.')
    plot(X,smooth(hist_todos,8)) %suavizado del histograma
    set(gca,'yscale','log')%setea escala logaritmica en el eje y
    drawnow
    fprintf('%d - %f sec, %d Datos\n',j,toc, sum(hist_todos)) % muestra por cual ciclo va, el timpo que transcurre desde el tic, y el numero total de picos
end
