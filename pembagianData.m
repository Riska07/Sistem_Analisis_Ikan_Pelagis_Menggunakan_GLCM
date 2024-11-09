% Tentukan path ke folder yang berisi dataset
folderPath = 'Dataset';

% Buat ImageDatastore dari folder tersebut
imds = imageDatastore(folderPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% Tentukan persentase data yang akan digunakan untuk data latih (misal: 80%) dan data uji (misal: 20%)
percentTrain = 0.6;
percentValidation = 0.4;

% Memecah dataset menjadi data latih dan data uji
[imdsTrain, imdsValidation] = splitEachLabel(imds, percentTrain, percentValidation, 'randomized');

% Membuat folder untuk data latih dan data uji
trainFolderPath = 'dataLatih';
validationFolderPath = 'dataUji';

% Membuat folder untuk data latih dan data uji jika belum ada
if ~exist(trainFolderPath, 'dir')
    mkdir(trainFolderPath);
end
if ~exist(validationFolderPath, 'dir')
    mkdir(validationFolderPath);
end

% Membuat folder untuk setiap kelas di dalam folder data latih
for i = 1:numel(imdsTrain.Labels)
    classFolder = fullfile(trainFolderPath, char(imdsTrain.Labels(i)));
    if ~exist(classFolder, 'dir')
        mkdir(classFolder);
    end
end

% Membuat folder untuk setiap kelas di dalam folder data uji
for i = 1:numel(imdsValidation.Labels)
    classFolder = fullfile(validationFolderPath, char(imdsValidation.Labels(i)));
    if ~exist(classFolder, 'dir')
        mkdir(classFolder);
    end
end

% Menyalin data latih ke dalam folder latih
for i = 1:numel(imdsTrain.Files)
    [~,imageName,ext] = fileparts(imdsTrain.Files{i});
    destinationFolder = fullfile(trainFolderPath, char(imdsTrain.Labels(i)), [imageName, ext]);
    copyfile(imdsTrain.Files{i}, destinationFolder);
end

% Menyalin data uji ke dalam folder uji
for i = 1:numel(imdsValidation.Files)
    [~,imageName,ext] = fileparts(imdsValidation.Files{i});
    destinationFolder = fullfile(validationFolderPath, char(imdsValidation.Labels(i)), [imageName, ext]);
    copyfile(imdsValidation.Files{i}, destinationFolder);
end
