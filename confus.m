function pengujianConfusionMatrix()
    % Tentukan lokasi folder data uji
    folder_utama = 'dataUji'; % Ganti 'dataUji' dengan lokasi folder data uji

    % Baca daftar subfolder (kelas) dalam folder utama
    kelas = dir(folder_utama);
    kelas = kelas([kelas.isdir]); % Hanya ambil subfolder (kelas)

    % Inisialisasi cell array untuk menyimpan citra dan labelnya
    data_citra = {};
    label_kelas = {};

    % Iterasi melalui setiap subfolder (kelas)
    for i = 1:numel(kelas)
        if ~strcmp(kelas(i).name, '.') && ~strcmp(kelas(i).name, '..') % Lewati folder "." dan ".."
            % Baca nama kelas dari nama subfolder
            nama_kelas = kelas(i).name;

            % Baca dan simpan gambar-gambar dari setiap subfolder (kelas)
            folder_kelas = fullfile(folder_utama, nama_kelas);
            file_gambar = dir(fullfile(folder_kelas, '*.jpg')); % Ubah ekstensi file sesuai dengan ekstensi gambar yang Anda gunakan

            for j = 1:numel(file_gambar)
                file_path = fullfile(folder_kelas, file_gambar(j).name);
                citra = imread(file_path);
                data_citra{end+1} = citra;
                label_kelas{end+1} = nama_kelas;
            end
        end
    end

    % Ubah cell array menjadi matriks untuk menyimpan data citra
    X = cat(4, data_citra{:}); % Matriks dimensi 4 untuk menyimpan citra
    Y = categorical(label_kelas); % Konversi label kelas menjadi tipe categorical

    % Iterasi melalui setiap nilai D
    for d = 1:4
        % Inisialisasi matriks untuk menyimpan fitur-fitur GLCM
        fitur_glcm = zeros(numel(Y), 6); % 6 kolom untuk 6 fitur

        % Iterasi melalui setiap citra dalam dataset
        for i = 1:numel(Y)
            % Ekstraksi fitur tekstur GLCM
            citra_gray = rgb2gray(X(:, :, :, i));

            glcm = graycomatrix(citra_gray, 'Offset', [0 d; -d d; -d 0; -d -d]);

            % Normalisasi GLCM
            glcm_normalized = glcm ./ sum(glcm(:));

            % Hitung Maximum Probability
            maximum_probability = max(glcm_normalized(:));

            % Hitung Entropy
            entropy_value = -sum(glcm_normalized(:) .* log2(glcm_normalized(:) + eps)); % Tambahkan eps untuk menghindari log(0)

            % Ekstraksi fitur tekstur GLCM
            stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
            fitur_glcm(i, :) = [mean(stats.Contrast), mean(stats.Correlation), mean(stats.Energy), mean(stats.Homogeneity), maximum_probability, entropy_value];
        end

        % Baca model KNN dari file .mat
        nama_file_model = ['model_KNN_D' num2str(d) '.mat'];
        load(nama_file_model, 'knnModel');

        % Lakukan prediksi menggunakan model KNN
        prediksi = predict(knnModel, fitur_glcm);

        % Hitung confusion matrix
        cm = confusionmat(Y, prediksi);

        % Hitung akurasi keseluruhan
        akurasi = sum(diag(cm)) / sum(cm(:)) * 100;

        % Hitung TP, TN, FP, FN
        TP = diag(cm);
        FP = sum(cm, 1)' - TP;
        FN = sum(cm, 2) - TP;
        TN = sum(cm(:)) - (TP + FP + FN);

        % Hitung akurasi, presisi, dan recall per kelas
        classAccuracy = TP ./ (TP + FN) * 100;
        precision = TP ./ (TP + FP) * 100;
        recall = TP ./ (TP + FN) * 100;

        % Hitung presisi dan recall keseluruhan
        overallPrecision = sum(TP) / (sum(TP) + sum(FP)) * 100;
        overallRecall = sum(TP) / (sum(TP) + sum(FN)) * 100;

        % Tampilkan confusion matrix, akurasi, TP, TN, FP, FN, presisi, recall, dan akurasi per kelas
        disp(['Confusion Matrix untuk D = ', num2str(d), ':']);
        disp(cm);
        fprintf('Akurasi keseluruhan untuk D = %d: %.2f%%\n', d, akurasi);
        fprintf('Presisi keseluruhan untuk D = %d: %.2f%%\n', d, overallPrecision);
        fprintf('Recall keseluruhan untuk D = %d: %.2f%%\n', d, overallRecall);

        % Tampilkan TP, TN, FP, FN, presisi, recall, dan akurasi per kelas
        for i = 1:length(TP)
            fprintf('Kelas %d - TP: %d, TN: %d, FP: %d, FN: %d, Presisi: %.2f%%, Recall: %.2f%%, Akurasi: %.2f%%\n', i, TP(i), TN(i), FP(i), FN(i), precision(i), recall(i), classAccuracy(i));
        end

        % Tampilkan confusion matrix sebagai figure
        figure;
        confusionchart(Y, prediksi);
        title(['Confusion Matrix untuk D = ' num2str(d)]);

        % Simpan confusion matrix ke file Excel
        nama_file_cm = sprintf('confusion_matrix_D%d.xlsx', d);
        tabel_cm = array2table(cm, 'VariableNames', categories(Y), 'RowNames', categories(Y));
        writetable(tabel_cm, nama_file_cm, 'WriteRowNames', true);

        % Simpan akurasi ke file Excel
        nama_file_ak = sprintf('akurasi_D%d.xlsx', d);
        tabel_ak = table(akurasi, overallPrecision, overallRecall, 'VariableNames', {'Akurasi', 'PresisiKeseluruhan', 'RecallKeseluruhan'});
        writetable(tabel_ak, nama_file_ak);

        % Simpan akurasi, presisi, dan recall per kelas ke file Excel
        nama_file_class_metrics = sprintf('metrics_per_kelas_D%d.xlsx', d);
        tabel_class_metrics = table(classAccuracy, precision, recall, 'VariableNames', {'Akurasi', 'Presisi', 'Recall'});
        writetable(tabel_class_metrics, nama_file_class_metrics);
    end
end
