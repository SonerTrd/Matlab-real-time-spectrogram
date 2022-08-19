%Gerçek Zamanlı Ses Spektrogramı Oluşturma
%Soner Türüdü / UMCG / University of Groningen

%Kayıt ve analiz parametreleri
srate = 44100/4;
time  = 0:1/srate:1-1/srate;
n     = length(time);
hz    = linspace(0,srate,n);

% Çizimin oluşturulması
figure(1), clf

% Zaman alanı
subplot(211)
timeh = plot(time,zeros(n,1));
set(gca,'ylim',[-1 1]/7)  
xlabel('Zaman (sn.)'), ylabel('Amplitüd (dB)')
title('Zamanı Alanı')

% Frekans alanı
subplot(212)
freqh = plot(hz, zeros(n,1),'linew',2);
set(gca,'xlim',[0 500],'ylim',[0 7]*1e-6)
xlabel('Frekans (Hz)'), ylabel('Güç')
title('Frekans Alanı')


% ses kaydedici kurulumu
auddat = audiorecorder (srate,8,1);

% Kaydı başlatma ve arabellekte tutma
record (auddat);
pause(1.1);

% Ctrl-c ile çıkana kadar, projenin çalışmasını sağlama
while 1
    
    % bir önceki saniyeden veri alınması
    data = getaudiodata (auddat);
    data = data (end-srate+1:end);
    
    % çizimlerin güncel tutulması
    set(timeh,'YData', data);
    set(freqh,'YData', abs(fft(data)/n).^2);
    
    pause(.1)
end

%Durdurma
%Burada hata verebilir. Fakat önemli değil, silebilirsiniz
%Ctrl-c kullanarak çıkacağız

stop(auddat);