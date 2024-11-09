# Sistem Klasifikasi Jenis Ikan Pelagis Menggunakan K-Nearest Neighbor (K-NN)

Repositori ini berisi sistem klasifikasi jenis ikan pelagis berbasis MATLAB yang menggunakan metode K-Nearest Neighbor (K-NN) dan fitur tekstur Gray Level Co-occurrence Matrix (GLCM). Proyek ini dirancang untuk mengklasifikasikan jenis ikan pelagis berdasarkan analisis tekstur gambar.

## Struktur Program

Struktur program mencakup beberapa folder dan file sebagai berikut:

- **Folder**:
  - `Dataset`: Folder dataset asli, yang akan dibagi menjadi data latih dan data uji.
  - `dataLatih`: Folder untuk menyimpan data latih.
  - `dataUji`: Folder untuk menyimpan data uji.
  - `hasilPrediksi`: Folder untuk menyimpan hasil klasifikasi citra.

- **File**:
  - **File Excel**: Berfungsi untuk menyimpan hasil ekstraksi fitur GLCM dengan berbagai nilai sudut (D1-D4) dari data latih.
  - **File Sumber MATLAB**:
    - `knn.fig`: File GUI MATLAB yang mendefinisikan tata letak antarmuka.
    - `knn.m`: Berisi logika untuk GUI.
    - `latih.m`: Melatih model K-NN menggunakan data latih.
    - `pembagianData.m`: Membagi dataset menjadi data latih (`dataLatih`) dan data uji (`dataUji`).
    - `prosesData.m`: Membaca data citra dari data latih, melakukan ekstraksi fitur GLCM, dan menyimpannya dalam file Excel.
    - **`confus.m`**: Menghitung dan menampilkan matriks kebingungan (confusion matrix) untuk mengevaluasi kinerja model klasifikasi.

### Alur Program

1. **Mengunduh Dataset**: Unduh dataset dari link [Google Drive ini](https://drive.google.com/drive/folders/1Up5jD_0O3l5qk-bRME489Co1h6WhGwMy?usp=drive_link) dan letakkan dalam folder `Dataset`.
2. **Pembagian Data**: Jalankan `pembagianData.m` untuk membagi dataset menjadi data latih dan data uji.
3. **Ekstraksi Fitur**: Jalankan `prosesData.m` untuk mengekstrak fitur tekstur dari citra dalam `dataLatih`.
4. **Pelatihan Model**: Jalankan `latih.m` untuk melatih model K-NN menggunakan fitur yang telah diekstraksi.
5. **Klasifikasi**: Gunakan GUI (`knn.fig` atau `knn.m`) untuk melakukan klasifikasi citra baru berdasarkan fitur tekstur.
6. **Evaluasi Model**: Gunakan **`confus.m`** untuk menghasilkan matriks kebingungan yang menunjukkan akurasi dan performa model.

## Antarmuka Pengguna Grafis (GUI)

GUI memungkinkan pengguna untuk berinteraksi dengan program melalui beberapa tombol dan area tampilan:

1. **Unggah Citra**: Tombol "Buka Citra" memungkinkan pengguna memasukkan citra yang akan dianalisis.
2. **Pemrosesan Citra**:
   - **Konversi Grayscale**: Mengonversi citra yang diunggah menjadi grayscale.
   - **Segmentasi**: Melakukan segmentasi pada citra grayscale.
   - **Ekstraksi Fitur**: Mengekstrak fitur tekstur menggunakan GLCM, menampilkan hasil ekstraksi pada tabel.
3. **Analisis**: Setelah fitur diekstraksi, tombol "Analisis" aktif untuk melakukan analisis pada citra.
4. **Evaluasi Klasifikasi**: Setelah klasifikasi selesai, gunakan **`confus.m`** untuk menampilkan matriks kebingungan, yang menunjukkan akurasi dan sensitivitas klasifikasi.

## Persyaratan

- MATLAB dengan Image Processing Toolbox
- Pustaka atau dependensi MATLAB yang diperlukan untuk fungsionalitas GUI

## Memulai

1. Clone repositori ini.
2. Buka MATLAB dan arahkan ke direktori proyek.
3. Jalankan GUI dengan membuka `knn.fig` atau `knn.m`.

## Mendapatkan Folder Dataset

Dataset yang digunakan dalam proyek ini dapat diunduh melalui link Google Drive berikut:

**[Link Google Drive Dataset](https://drive.google.com/drive/folders/1Up5jD_0O3l5qk-bRME489Co1h6WhGwMy?usp=drive_link)**

1. Klik link di atas untuk membuka halaman Google Drive.
2. Pilih folder yang ingin diunduh, klik kanan, lalu pilih **"Download"** untuk mengunduh dataset ke komputer Anda.
3. Ekstrak folder jika diperlukan, dan pindahkan folder ke direktori proyek sesuai struktur yang dibutuhkan.
