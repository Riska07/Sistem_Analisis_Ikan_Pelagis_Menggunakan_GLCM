function label_kelas = prosesData()
    % Tentukan lokasi folder dataset
    folder_utama = 'dataLatih'; % Ganti 'path_to_main_folder' dengan lokasi folder utama
    
    % Baca daftar subfolder (kelas) dalam folder utama
    kelas = dir(folder_utama);
    kelas = kelas([kelas.isdir]); % Hanya ambil subfolder (kelas)
    
    % Inisialisasi cell array untuk menyimpan citra dan labelnya
    data_citra = {};
    label_kelas = {};
    file_names = {};  % Menyimpan nama file
    
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
                file_names{end+1} = file_gambar(j).name;  % Simpan nama file
            end
        end
    end
    
    % Ubah cell array menjadi matriks untuk menyimpan data citra
    X = cat(4, data_citra{:}); % Matriks dimensi 4 untuk menyimpan citra
    Y = categorical(label_kelas); % Konversi label kelas menjadi tipe categorical
    
    % Tampilkan ukuran matriks X dan vektor label kelas Y
    fprintf('Ukuran matriks citra (X): %s\n', mat2str(size(X)));
    fprintf('Ukuran vektor label kelas (Y): %s\n', mat2str(size(Y)));

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
        % Pastikan nama file disimpan sebagai cell array dengan dimensi yang benar
        file_names = file_names';  % Transpose untuk membuat dimensi 480x1
        
        % Menggabungkan nama file dengan fitur GLCM
        file_names_glcm = cell(numel(file_names), 1);
        file_names_glcm(:) = file_names;  % Konversi file_names ke cell array yang konsisten
        % Simpan matriks fitur GLCM ke dalam file Excel untuk nilai D saat ini
        nama_file_glcm = sprintf('fitur_dataset_glcm_D%d.xlsx', d); % Nama file sesuai dengan nilai D saat ini
        nama_kolom_glcm = {'namaFile', 'Contrast', 'Correlation', 'Energy', 'Homogeneity', 'MaximumProbability', 'Entropy'};
        tabel_fitur_glcm = array2table([file_names_glcm, num2cell(fitur_glcm)], 'VariableNames', nama_kolom_glcm);
        writetable(tabel_fitur_glcm, nama_file_glcm);
    end
    label_kelas = Y;
end