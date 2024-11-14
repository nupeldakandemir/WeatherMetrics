% Hava durumu verilerini dosyadan oku
fileID = fopen('weather_data.txt', 'r');
data = textscan(fileID, '%s %f %f %s', 'Delimiter', ',');
fclose(fileID);

% Verilerden sütunları ayıkla
dates = data{1};
humidity = data{2};
temperature = data{3};
conditions = data{4};

% Farklı hava durumu koşullarını al
unique_conditions = unique(conditions);

% Ortalama sıcaklık ve veri noktası sayısını depolamak için değişkenler başlat
avg_temp = zeros(size(unique_conditions));
data_count = zeros(size(unique_conditions));

% Her bir hava durumu tipi için ortalama sıcaklığı hesapla
for i = 1:length(unique_conditions)
    condition_indices = strcmp(conditions, unique_conditions{i});
    avg_temp(i) = mean(temperature(condition_indices));
    data_count(i) = sum(condition_indices);
end

% Sonuçları ekrana yazdır
for i = 1:length(unique_conditions)
    fprintf('%s için ortalama sıcaklık: %.2f derece, Veri Noktası Sayısı: %d\n', unique_conditions{i}, avg_temp(i), data_count(i));
end

% Ortalama sıcaklıklar için bar grafiği çiz
figure;
bar(avg_temp);
xlabel('Hava Durum Tipi');
ylabel('Ortalama Sıcaklık (\circC)');
title('Hava Durumu Tipine Göre Ortalama Sıcaklıklar');
xticklabels(unique_conditions);
