function main()
    % Jalankan proses data untuk menghasilkan fitur GLCM dan label kelas
    label_kelas = prosesData();
    
    % Tentukan nilai numNeighbors yang akan diuji
    numNeighbors = 3; % Tetapkan nilai K = 3

    % Inisialisasi variabel untuk menyimpan akurasi setiap model
    akurasi_models = zeros(4, 1);
    jarak_euclidean_models = cell(4, 1);

    % Iterasi melalui setiap nilai D
    for d = 1:4
        % Baca fitur-fitur GLCM dari file Excel untuk nilai D saat ini
        file_glcm = ['fitur_dataset_glcm_D' num2str(d) '.xlsx'];
        data = readtable(file_glcm);
        % Konversi tabel menjadi matriks numerik, mulai dari kolom kedua (melewati kolom Nama File)
        fitur_glcm = table2array(data(:, 2:end));  % Ambil semua kolom kecuali kolom pertama (Nama File)
        
        
        % Pastikan jumlah label kelas sesuai dengan jumlah fitur yang dihasilkan
        if numel(label_kelas) ~= size(fitur_glcm, 1)
            error('Jumlah label kelas tidak sesuai dengan jumlah fitur yang dihasilkan.');
        end
        
        % Latih model KNN untuk nilai D saat ini
        knnModel = fitcknn(fitur_glcm, label_kelas, 'NumNeighbors', numNeighbors);

        % Simpan model KNN untuk nilai D saat ini
        nama_file_model = ['model_KNN_D' num2str(d) '.mat'];
        save(nama_file_model, 'knnModel', 'numNeighbors');
        
        % Tampilkan model yang telah dilatih (opsional)
        disp(['KNN Model (k = ', num2str(numNeighbors), ', D', num2str(d), '):']);
        disp(knnModel);

        % Evaluasi model dengan data latih menggunakan KNN kustom
        [prediksi2, allDistances] = customKNN(fitur_glcm, label_kelas, fitur_glcm, numNeighbors);
        
        % Evaluasi model dengan data latih
        prediksi = predict(knnModel, fitur_glcm);
        
        % Hitung akurasi pelatihan
        akurasi = sum(prediksi == label_kelas') / numel(label_kelas) * 100;
        % Tampilkan hasil akurasi
        disp(['Akurasi untuk D = ', num2str(d), ': ', num2str(akurasi)]);
        % Menampilkan akurasi
        fprintf('Akurasi untuk D = %d adalah %.2f%%\n', d, akurasi);
        akurasi_models(d) = akurasi;
        
        % Simpan hasil perhitungan jarak Euclidean
        jarak_euclidean_models{d} = allDistances;
        
        % Simpan jarak Euclidean ke workspace
        assignin('base', ['jarak_euclidean_D' num2str(d)], allDistances);
        
    end
    % Simpan akurasi di file Excel
    akurasi_tabel = array2table(akurasi_models, 'VariableNames', {'Akurasi'});
    writetable(akurasi_tabel, 'akurasi_models.xlsx');
    
    % Simpan akurasi ke workspace
    assignin('base', 'akurasi_models', akurasi_models);
    % Tampilkan akurasi semua model
    disp('Akurasi semua model:');
    disp(akurasi_models);
end

function [predictedLabels, allDistances] = customKNN(trainFeatures, trainLabels, testFeatures, k)
    numTest = size(testFeatures, 1);
    predictedLabels = strings(numTest, 1);
    allDistances = cell(numTest, 1);

    for i = 1:numTest
        distances = sqrt(sum((trainFeatures - testFeatures(i, :)).^2, 2)); % Jarak Euclidean
        allDistances{i} = distances; % Simpan semua jarak untuk setiap data uji
        [~, sortedIdx] = sort(distances);
        nearestNeighbors = trainLabels(sortedIdx(1:k));
        
        % Menggunakan model dari tetangga terdekat
        predictedLabels(i) = mode(categorical(nearestNeighbors));
    end
end
