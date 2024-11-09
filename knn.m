function varargout = knn(varargin)
% KNN MATLAB code for knn.fig
%      KNN, by itself, creates a new KNN or raises the existing
%      singleton*.
%
%      H = KNN returns the handle to a new KNN or the handle to
%      the existing singleton*.
%
%      KNN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KNN.M with the given input arguments.
%
%      KNN('Property','Value',...) creates a new KNN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before knn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to knn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help knn

% Last Modified by GUIDE v2.5 27-Mar-2024 01:04:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @knn_OpeningFcn, ...
                   'gui_OutputFcn',  @knn_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before knn is made visible.
function knn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to knn (see VARARGIN)

% Choose default command line output for knn
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes knn wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.axes1)
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes2)
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes3)
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.pushbutton2,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton3,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton4,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton5,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton6,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton7,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton8,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])


% --- Outputs from this function are returned to the command line.
function varargout = knn_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    [filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png; *.*','All Files'},'Select Image File');
    % Memeriksa apakah pengguna telah membatalkan pemilihan citra
    if isequal(filename,0) || isequal(pathname,0)
        % Pengguna membatalkan pemilihan citra, tampilkan pesan peringatan
        msgbox('Pemilihan citra dibatalkan.', 'Peringatan', 'warn');
    else
        Info = imfinfo(fullfile(pathname,filename));
        % Dapatkan alamat dan nama gambar
        if Info.BitDepth == 1
            msgbox('Citra masukan harus citra RGB atau Grayscale');
            return
        else
            Info.BitDepth = 8;
            gambarTest = imread(fullfile(pathname,filename));
            % Baca gambar yang sudah dipilih
            axes(handles.axes1); % Tempat tampil di axes1
            cla('reset');
            imshow(gambarTest);
            
            handles.namaFile = filename;
            handles.gambarTest = gambarTest;
            
            % Aktifkan tombol-tombol yang relevan setelah menginputkan citra
            set(handles.pushbutton2,'Enable','on', 'BackgroundColor', [0.41 0.4 0.4], 'ForegroundColor', [1 1 1]);
            set(handles.pushbutton3,'Enable','on', 'BackgroundColor', [0.41 0.4 0.4], 'ForegroundColor', [1 1 1]);
        end
        guidata(hObject,handles); % Simpan handles
    end
catch ME
    % Tangani kesalahan dan tampilkan pesan kesalahan
    errordlg(['Error: ', ME.message], 'Error', 'modal');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambarTest = handles.gambarTest;
gscale = rgb2gray(gambarTest);
axes(handles.axes2)
cla('reset')
imshow(gscale)
handles.gscale = gscale;
guidata(hObject,handles);

gscale = handles.gscale;
sgment = im2bw(gscale,graythresh(gscale));
axes(handles.axes3)
cla('reset')
imshow(sgment)
handles.sgment = sgment;
guidata(hObject,handles);
set(handles.pushbutton5,'Enable','on', 'BackgroundColor', [0.41 0.4 0.4], 'ForegroundColor', [1 1 1])


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes2)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes3)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.edit1, 'String', 'Hasil')
set(handles.edit2, 'String', '1')
data_tabel = get(handles.uitable1, 'Data'); % Menggunakan handle untuk mengakses data tabel
% Mengubah data tabel menjadi array kosong
data_tabel_baru = cell(size(data_tabel)); % Membuat array sel kosong dengan ukuran yang sama
set(handles.uitable1, 'Data', data_tabel_baru); % Mengatur data tabel menjadi array kosong
set(handles.pushbutton2,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton3,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton4,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton5,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton6,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton7,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton8,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])


% --- Executes on button press in pushbutton3.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Dapatkan file citra, hasil prediksi, dan nilai D

% Tentukan nama file untuk menyimpan citra
namaFile = handles.namaFile;

result_string = get(handles.edit1, 'String'); % Directly get the string from the edit box
hasil_prediksi = result_string;

% Pastikan hasil prediksi adalah string
nilaiD = str2double(get(handles.edit2, 'String')); % Nilai D

% Tentukan jalur folder tempat menyimpan gambar
folder_simpan = 'hasilPrediksi'; % Ganti dengan jalur folder yang diinginkan

% Dapatkan gambar yang akan disimpan
gambar = handles.gambarTest;

% Pastikan folder penyimpanan ada, jika tidak buat folder tersebut
if ~isfolder(folder_simpan)
    mkdir(folder_simpan);
end

% Simpan gambar dengan nama file dan jalur folder yang telah ditentukan
nama_file = fullfile(folder_simpan, sprintf('%s_%s_D%d.jpg', namaFile, hasil_prediksi, nilaiD));
imwrite(gambar, nama_file); % Simpan gambar

% Tampilkan pesan sukses
%pushbutton3_Callback(hObject, eventdata, handles);
msgbox(sprintf('Citra berhasil disimpan di: %s', nama_file), 'Informasi', 'help');

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gscale = handles.gscale;
gambarTest = handles.gambarTest;

% Inisialisasi matriks untuk menyimpan fitur-fitur GLCM
fitur_glcm_per_d = zeros(24, 5); % 24 baris untuk 6 fitur * 4 nilai D, 5 kolom untuk setiap sudut dan rata-rata

% Iterasi melalui setiap nilai D
for d = 1:4
    glcm = graycomatrix(gscale, 'Offset', [0 d; -d d; -d 0; -d -d]);

    % Normalisasi GLCM
    glcm_normalized = glcm ./ sum(glcm(:));

    % Hitung Maximum Probability
    maximum_probability = max(glcm_normalized(:));
    
    % Hitung Entropy
    entropy_value = -sum(glcm_normalized(:) .* log2(glcm_normalized(:) + eps)); % Tambahkan eps untuk menghindari log(0)

    % Ekstraksi fitur tekstur GLCM
    stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
    fitur_glcm_per_d_klasifikasi(:, d) = [mean(stats.Contrast); mean(stats.Correlation); mean(stats.Energy); mean(stats.Homogeneity); maximum_probability; entropy_value];
    
    % Menyimpan fitur untuk setiap sudut
    for angle = 1:4
        % Hitung indeks untuk kolom
        kolom_idx = angle;
        
        % Mendapatkan fitur untuk sudut tertentu
        temp_fitur = [stats.Contrast(angle); stats.Correlation(angle); stats.Energy(angle); stats.Homogeneity(angle)];
        
        % Menyimpan fitur pada kolom yang sesuai
        fitur_glcm_per_d((d-1)*6+1:d*6, kolom_idx) = [temp_fitur; maximum_probability; entropy_value];
    end
    
    % Hitung rata-rata untuk setiap baris
    avg_fitur = mean(fitur_glcm_per_d((d-1)*6+1:d*6, 1:4), 2);
    
    % Menyimpan rata-rata dalam kolom tambahan
    fitur_glcm_per_d((d-1)*6+1:d*6, 5) = avg_fitur;
end
fitur_glcm = reshape(fitur_glcm_per_d_klasifikasi, 1, []);
% Menyusun data untuk dimasukkan ke dalam tabel
data = num2cell(fitur_glcm_per_d);

% Membuat label untuk baris tabel
baris_label = {'Contrast_D1', 'Correlation_D1', 'Energy_D1', 'Homogeneity_D1', 'MaximumProbability_D1', 'Entropy_D1', ...
               'Contrast_D2', 'Correlation_D2', 'Energy_D2', 'Homogeneity_D2', 'MaximumProbability_D2', 'Entropy_D2', ...
               'Contrast_D3', 'Correlation_D3', 'Energy_D3', 'Homogeneity_D3', 'MaximumProbability_D3', 'Entropy_D3', ...
               'Contrast_D4', 'Correlation_D4', 'Energy_D4', 'Homogeneity_D4', 'MaximumProbability_D4', 'Entropy_D4'};

% Label untuk kolom
kolom_label = {'0', '45', '90', '135', 'Average'};

% Memperbarui data dan label dalam tabel
set(handles.uitable1, 'Data', data)
set(handles.uitable1, 'RowName', baris_label)
set(handles.uitable1, 'ColumnName', kolom_label)

% Menyimpan fitur GLCM dalam handles untuk digunakan nanti
handles.fiturGlcm = fitur_glcm;
guidata(hObject, handles);


set(handles.pushbutton6,'Enable','on', 'BackgroundColor', [0.41 0.4 0.4], 'ForegroundColor', [1 1 1])
set(handles.pushbutton7,'Enable','on', 'BackgroundColor', [0.41 0.4 0.4], 'ForegroundColor', [1 1 1])
set(handles.pushbutton8,'Enable','on', 'BackgroundColor', [0.41 0.4 0.4], 'ForegroundColor', [1 1 1])



% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ambil nilai D yang dimasukkan oleh pengguna dari kontrol UI edit2
nilaiD = str2double(get(handles.edit2, 'String'));

% Tentukan nama file model KNN berdasarkan nilai D yang dipilih
nama_file_model = ['model_KNN_D' num2str(nilaiD) '.mat'];

% Cek apakah file model KNN tersedia
if exist(nama_file_model, 'file') == 2
    % Jika file model KNN tersedia, muat model KNN yang sesuai
    loadedData = load(nama_file_model);
    knnModel = loadedData.knnModel; % Anggap 'knnModel' adalah nama variabel yang menyimpan model KNN
    
    % Pilih variabel fitur GLCM sesuai dengan nilai D yang dipilih
    switch nilaiD
        case 1
            fitur_glcm = handles.fiturGlcm(:, 1:6);
        case 2
            fitur_glcm = handles.fiturGlcm(:, 7:12);
        case 3
            fitur_glcm = handles.fiturGlcm(:, 13:18);
        case 4
            fitur_glcm = handles.fiturGlcm(:, 19:24);
        otherwise
            error('Nilai D tidak valid.');
    end

    % Lakukan klasifikasi menggunakan model KNN yang telah dimuat
    hasilKlasifikasi = predict(knnModel, fitur_glcm);

    % Tampilkan hasil klasifikasi pada kontrol UI edit1
    set(handles.edit1, 'String', hasilKlasifikasi);
    set(handles.pushbutton4,'Enable','on', 'BackgroundColor', [0.41 0.4 0.4], 'ForegroundColor', [1 1 1])
else
    % Jika file model KNN tidak tersedia, beri peringatan kepada pengguna
    msgbox(['Model KNN untuk nilai D = ' num2str(nilaiD) ' tidak tersedia.']);
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%tombol untuk -1
val = str2double(get(handles.edit2,'String'))-1;
if val < 1
    val = 1; %value tidak bisa kurang dari 1
end
set(handles.edit2,'String',val)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%tombol untuk +1
val = str2double(get(handles.edit2,'String'))+1;
if val > 4
    val = 4; %nilai tidak bisa lebih dari 10
end
set(handles.edit2,'String',val)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
