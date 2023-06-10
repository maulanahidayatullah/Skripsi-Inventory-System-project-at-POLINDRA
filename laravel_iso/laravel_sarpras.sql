-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2023 at 08:05 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel_sarpras`
--

-- --------------------------------------------------------

--
-- Table structure for table `barangs`
--

CREATE TABLE `barangs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `kategori_id` varchar(255) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `satuan` varchar(255) NOT NULL,
  `jumlah` varchar(255) NOT NULL,
  `jumlah_rusak` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gedung`
--

CREATE TABLE `gedung` (
  `id_gedung` int(11) NOT NULL,
  `gedung` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gedung`
--

INSERT INTO `gedung` (`id_gedung`, `gedung`, `created_at`, `updated_at`) VALUES
(1, 'Gedung 1', NULL, NULL),
(3, 'Gedung 2', NULL, NULL),
(4, 'Gedung GSC', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `input_ruangan`
--

CREATE TABLE `input_ruangan` (
  `id_input_ruangan` bigint(20) UNSIGNED NOT NULL,
  `id_ruangan_barang` int(11) NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `jumlah_masuk` varchar(255) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `jumlah_rusak_ruangan` varchar(255) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `input_ruangan`
--
DELIMITER $$
CREATE TRIGGER `tg_barang_masuk` AFTER INSERT ON `input_ruangan` FOR EACH ROW BEGIN
                UPDATE barangs
                SET jumlah = jumlah - NEW.jumlah_masuk
                WHERE
                id_barang = NEW.id_barang;
                END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `inventori`
--

CREATE TABLE `inventori` (
  `id` int(11) NOT NULL,
  `uraian_akun` varchar(255) NOT NULL,
  `kode_barang` int(11) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `tahun_perolehan` date DEFAULT NULL,
  `nup` int(11) NOT NULL,
  `merk_type` varchar(255) NOT NULL,
  `kuantitas` int(11) NOT NULL,
  `nilai_bmn` int(255) NOT NULL,
  `pengguna` varchar(255) NOT NULL,
  `kondisi_barang` enum('B','RR','RB') NOT NULL,
  `keberadaan_barang` enum('BD','BTD','Berlebih') NOT NULL,
  `pelabelan_kodefikasi` enum('sudah','belum') NOT NULL,
  `gedung_id` int(11) NOT NULL,
  `ruangan_id` int(11) NOT NULL,
  `status_psp` enum('sudah','belum') NOT NULL,
  `keterangan` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventori`
--

INSERT INTO `inventori` (`id`, `uraian_akun`, `kode_barang`, `nama_barang`, `tahun_perolehan`, `nup`, `merk_type`, `kuantitas`, `nilai_bmn`, `pengguna`, `kondisi_barang`, `keberadaan_barang`, `pelabelan_kodefikasi`, `gedung_id`, `ruangan_id`, `status_psp`, `keterangan`, `created_at`, `updated_at`) VALUES
(3, 'Peralatan 123', 2147483647, 'PC Workstation', '2023-05-02', 157, 'LENOVO ThinkStation P350 Tower', 1, 35430010, 'TI', 'B', 'BD', 'belum', 4, 7, 'sudah', 'keterangan', '2023-04-04 03:42:43', '2023-05-26 09:30:45'),
(4, '1', 1, '1', '2022-01-01', 1, '123', 1, 1231, 'TM', 'B', 'BD', 'sudah', 1, 1, 'sudah', '123', NULL, NULL),
(5, 'Peralatan 123', 123, 'Kursi', '2022-01-01', 123, 'IKEA', 28, 2000, 'TP', 'B', 'BD', 'sudah', 4, 7, 'sudah', 'Ini Kursi', NULL, '2023-05-25 23:54:40');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` bigint(20) UNSIGNED NOT NULL,
  `nama_kategori` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keluar`
--

CREATE TABLE `keluar` (
  `id_keluar` bigint(20) UNSIGNED NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `jumlah_keluar` varchar(255) NOT NULL,
  `untuk` varchar(255) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `keluar`
--
DELIMITER $$
CREATE TRIGGER `tg_barang_keluar` AFTER INSERT ON `keluar` FOR EACH ROW BEGIN
                UPDATE barangs
                SET jumlah = jumlah - NEW.jumlah_keluar
                WHERE
                id_barang = NEW.id_barang;
                END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_keluar`
--

CREATE TABLE `keranjang_keluar` (
  `id_keluar` bigint(20) UNSIGNED NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `jumlah_keluar` varchar(255) NOT NULL,
  `untuk` varchar(255) NOT NULL,
  `tanggal_keluar` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_masuk`
--

CREATE TABLE `keranjang_masuk` (
  `id_masuk` bigint(20) UNSIGNED NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `jumlah_asup` varchar(255) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `harga_satuan` varchar(255) NOT NULL,
  `harga_total` varchar(255) NOT NULL,
  `nama_toko` varchar(255) NOT NULL,
  `merek` varchar(255) NOT NULL,
  `sumber_dana` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_peminjaman`
--

CREATE TABLE `keranjang_peminjaman` (
  `id_peminjaman` bigint(20) UNSIGNED NOT NULL,
  `nama_peminjam` varchar(255) NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `jumlah_pinjam` varchar(255) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_ruangan`
--

CREATE TABLE `keranjang_ruangan` (
  `id_input_ruangan` bigint(20) UNSIGNED NOT NULL,
  `id_ruangan` varchar(255) NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `jumlah_masuk` varchar(255) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_rusak_luar`
--

CREATE TABLE `keranjang_rusak_luar` (
  `id_rusak_luar` bigint(20) UNSIGNED NOT NULL,
  `id_barang_rusak_luar` varchar(255) NOT NULL,
  `jumlah_rusak_luar` varchar(255) NOT NULL,
  `tanggal_rusak_luar` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `user_id_luar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keranjang_rusak_ruangan`
--

CREATE TABLE `keranjang_rusak_ruangan` (
  `id_rusak_ruangan` bigint(20) UNSIGNED NOT NULL,
  `id_barang_rusak` varchar(255) NOT NULL,
  `jumlah_rusak_ruangan` varchar(255) NOT NULL,
  `id_ruangan_rusak` varchar(255) NOT NULL,
  `tanggal_rusak` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `user_id_ruangan` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_mobilitas`
--

CREATE TABLE `log_mobilitas` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mobilitas_id_sebelum` int(11) DEFAULT NULL,
  `mobilitas_id_sesudah` int(11) DEFAULT NULL,
  `selesai` enum('true','false') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_mobilitas`
--

INSERT INTO `log_mobilitas` (`id`, `user_id`, `mobilitas_id_sebelum`, `mobilitas_id_sesudah`, `selesai`, `created_at`, `updated_at`) VALUES
(36, 2, 55, 56, 'true', '2023-05-26 00:05:00', '2023-05-26 00:05:07'),
(39, 2, 59, 60, 'true', '2023-05-26 00:14:00', '2023-05-26 00:14:11'),
(40, 2, 61, 62, 'true', '2023-05-26 00:15:11', '2023-05-26 00:15:16'),
(41, 2, 63, 64, 'true', '2023-05-26 00:16:57', '2023-05-26 00:17:01'),
(43, 2, 66, 67, 'true', '2023-05-26 09:30:33', '2023-05-26 09:30:45'),
(44, 2, 68, 69, 'true', '2023-05-29 00:22:24', '2023-05-29 00:22:38'),
(45, 2, 70, 71, 'true', '2023-05-29 00:43:52', '2023-05-29 00:44:06'),
(46, 2, 72, 73, 'true', '2023-05-29 00:47:36', '2023-05-29 00:47:40'),
(47, 2, 74, 75, 'true', '2023-05-29 00:48:25', '2023-05-29 00:48:34'),
(48, 2, 76, 77, 'true', '2023-05-29 00:54:36', '2023-05-29 00:54:41'),
(49, 2, 78, 79, 'true', '2023-05-29 00:55:07', '2023-05-29 00:55:11'),
(50, 2, 80, 81, 'true', '2023-05-29 00:56:22', '2023-05-29 00:56:25'),
(51, 2, 82, 84, 'true', '2023-05-30 01:12:49', '2023-05-30 01:14:36');

-- --------------------------------------------------------

--
-- Table structure for table `log_pelabelan`
--

CREATE TABLE `log_pelabelan` (
  `id` int(11) NOT NULL,
  `inventori_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_pencatatan`
--

CREATE TABLE `log_pencatatan` (
  `id` int(11) NOT NULL,
  `inventori_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `masuk`
--

CREATE TABLE `masuk` (
  `id_masuk` bigint(20) UNSIGNED NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `jumlah_asup` varchar(255) NOT NULL,
  `tanggal_masuk` date NOT NULL,
  `harga_satuan` varchar(255) NOT NULL,
  `harga_total` varchar(255) NOT NULL,
  `nama_toko` varchar(255) NOT NULL,
  `merek` varchar(255) NOT NULL,
  `sumber_dana` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `masuk`
--
DELIMITER $$
CREATE TRIGGER `tg_masuk_barang` AFTER INSERT ON `masuk` FOR EACH ROW BEGIN
                UPDATE barangs
                SET jumlah = jumlah + NEW.jumlah_asup
                WHERE
                id_barang = NEW.id_barang;
                END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2020_05_13_034444_create_rusak_ruangan', 1),
(6, '2020_05_13_034701_create_rusak_luar', 1),
(7, '2020_05_13_034908_create_ruangan', 1),
(8, '2020_05_13_035014_create_peminjaman', 1),
(9, '2020_05_13_035436_create_masuk', 1),
(10, '2020_05_13_035635_create_keranjang_rusak_ruangan', 1),
(11, '2020_05_13_035943_create_keranjang_rusak_luar', 1),
(12, '2020_05_13_064635_create_keranjang_ruangan', 1),
(13, '2020_05_13_064823_create_keranjang_peminjaman', 1),
(14, '2020_05_13_065038_create_keranjang_masuk', 1),
(15, '2020_05_13_065429_create_keranjang_keluar', 1),
(16, '2020_05_13_065558_create_keluar', 1),
(17, '2020_05_13_065732_create_kategori', 1),
(18, '2020_05_13_065838_create_input_ruangan', 1),
(19, '2020_05_13_070559_create_barangs', 1),
(20, '2020_05_13_071648_add_trigger', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mobilitas`
--

CREATE TABLE `mobilitas` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `inventori_id` int(11) NOT NULL,
  `gedung_id` int(11) NOT NULL,
  `ruangan_id` int(11) NOT NULL,
  `selesai` enum('true','false') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mobilitas`
--

INSERT INTO `mobilitas` (`id`, `user_id`, `inventori_id`, `gedung_id`, `ruangan_id`, `selesai`, `created_at`, `updated_at`) VALUES
(55, 2, 3, 4, 7, 'true', '2023-05-26 00:05:00', '2023-05-26 00:05:07'),
(56, 2, 3, 4, 7, 'true', '2023-05-26 00:05:07', '2023-05-26 00:05:07'),
(59, 2, 5, 4, 7, 'true', '2023-05-26 00:14:00', '2023-05-26 00:14:11'),
(60, 2, 5, 4, 7, 'true', '2023-05-26 00:14:11', '2023-05-26 00:14:11'),
(61, 2, 5, 4, 7, 'true', '2023-05-26 00:15:11', '2023-05-26 00:15:16'),
(62, 2, 5, 4, 7, 'true', '2023-05-26 00:15:16', '2023-05-26 00:15:16'),
(63, 2, 5, 4, 7, 'true', '2023-05-26 00:16:57', '2023-05-26 00:17:01'),
(64, 2, 5, 4, 7, 'true', '2023-05-26 00:17:01', '2023-05-26 00:17:01'),
(66, 2, 3, 4, 5, 'true', '2023-05-26 09:30:33', '2023-05-26 09:30:45'),
(67, 2, 3, 4, 7, 'true', '2023-05-26 09:30:45', '2023-05-26 09:30:45'),
(68, 2, 5, 4, 7, 'true', '2023-05-29 00:22:24', '2023-05-29 00:22:38'),
(69, 2, 5, 4, 7, 'true', '2023-05-29 00:22:38', '2023-05-29 00:22:38'),
(70, 2, 3, 4, 7, 'true', '2023-05-29 00:43:52', '2023-05-29 00:44:06'),
(71, 2, 3, 4, 7, 'true', '2023-05-29 00:44:06', '2023-05-29 00:44:06'),
(72, 2, 3, 4, 7, 'true', '2023-05-29 00:47:36', '2023-05-29 00:47:40'),
(73, 2, 3, 4, 7, 'true', '2023-05-29 00:47:40', '2023-05-29 00:47:40'),
(74, 2, 3, 4, 7, 'true', '2023-05-29 00:48:25', '2023-05-29 00:48:34'),
(75, 2, 3, 4, 7, 'true', '2023-05-29 00:48:34', '2023-05-29 00:48:34'),
(76, 2, 3, 4, 7, 'true', '2023-05-29 00:54:36', '2023-05-29 00:54:41'),
(77, 2, 3, 4, 7, 'true', '2023-05-29 00:54:41', '2023-05-29 00:54:41'),
(78, 2, 5, 4, 7, 'true', '2023-05-29 00:55:07', '2023-05-29 00:55:11'),
(79, 2, 5, 4, 7, 'true', '2023-05-29 00:55:11', '2023-05-29 00:55:11'),
(80, 2, 5, 4, 7, 'true', '2023-05-29 00:56:22', '2023-05-29 00:56:25'),
(81, 2, 5, 4, 7, 'true', '2023-05-29 00:56:25', '2023-05-29 00:56:25'),
(82, 2, 3, 4, 7, 'true', '2023-05-30 01:12:49', '2023-05-30 01:14:36'),
(84, 2, 3, 4, 7, 'true', '2023-05-30 01:14:36', '2023-05-30 01:14:36');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pegawai`
--

CREATE TABLE `pegawai` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `jabatan` varchar(255) NOT NULL,
  `no_hp` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pegawai`
--

INSERT INTO `pegawai` (`id`, `user_id`, `nama`, `alamat`, `jabatan`, `no_hp`, `created_at`, `updated_at`) VALUES
(1, 2, 'Maulana', 'Jatibarang', 'Mahasiswa', '08989876845', '2023-04-04 03:42:43', '2023-04-04 03:42:43');

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id_peminjaman` bigint(20) UNSIGNED NOT NULL,
  `nama_peminjam` varchar(255) NOT NULL,
  `id_barang` varchar(255) NOT NULL,
  `jumlah_pinjam` varchar(255) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `peminjaman`
--
DELIMITER $$
CREATE TRIGGER `tg_pinjam` AFTER INSERT ON `peminjaman` FOR EACH ROW BEGIN
                UPDATE barangs
                SET jumlah = jumlah - NEW.jumlah_pinjam
                WHERE
                id_barang = NEW.id_barang;
                END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '167e032a3d7ee1110139b992d12f6205045c2cdd59c9603c89cebfc82f2f946e', '[\"*\"]', '2023-05-22 01:45:28', NULL, '2023-05-22 01:42:20', '2023-05-22 01:45:28'),
(3, 'App\\Models\\User', 2, 'auth_token', 'dc271912ebe1463ad67a2bc31561a495e96761e4ec7bc6c57ac944d59dbe9540', '[\"*\"]', '2023-05-22 11:22:37', NULL, '2023-05-22 11:22:06', '2023-05-22 11:22:37'),
(4, 'App\\Models\\User', 2, 'auth_token', '6111670001dc98657bf4fceb81af9a639feac4bf3affcb4d039a929f75943af4', '[\"*\"]', '2023-05-22 11:23:56', NULL, '2023-05-22 11:23:46', '2023-05-22 11:23:56'),
(5, 'App\\Models\\User', 2, 'auth_token', '54f634a16d34f23626398addb827722a8f1523aa2c6047960b505859d60edb17', '[\"*\"]', '2023-05-22 11:26:23', NULL, '2023-05-22 11:26:14', '2023-05-22 11:26:23'),
(6, 'App\\Models\\User', 2, 'auth_token', '250e2d8b9151e4df3f7b32db3357f59dbe6ccaecbbf36d2c9001c2335644186d', '[\"*\"]', NULL, NULL, '2023-05-25 08:20:06', '2023-05-25 08:20:06'),
(7, 'App\\Models\\User', 2, 'auth_token', 'fcbe403ab1e47d8b1fe12a3f5b8698f48b17d0cf192dedc1f7d20ea679f3790b', '[\"*\"]', NULL, NULL, '2023-05-25 08:53:46', '2023-05-25 08:53:46'),
(8, 'App\\Models\\User', 2, 'auth_token', 'f0d4b38cc52c2064c0fb7236cdd29c2ce58fc43b5a1a21701fac578c19c404a4', '[\"*\"]', '2023-05-30 01:14:41', NULL, '2023-05-25 08:54:32', '2023-05-30 01:14:41');

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `id_ruangan` bigint(20) UNSIGNED NOT NULL,
  `ruangan` varchar(255) NOT NULL,
  `id_pembimbing` varchar(255) DEFAULT NULL,
  `id_pj` varchar(255) DEFAULT NULL,
  `id_gedung` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ruangan`
--

INSERT INTO `ruangan` (`id_ruangan`, `ruangan`, `id_pembimbing`, `id_pj`, `id_gedung`, `created_at`, `updated_at`) VALUES
(1, 'Ruangan', NULL, NULL, 1, NULL, NULL),
(4, 'Ruangan 2', NULL, NULL, 1, NULL, NULL),
(5, 'Ruangan Gedung 2', NULL, NULL, 3, NULL, NULL),
(6, 'RK 401', NULL, NULL, 4, NULL, NULL),
(7, 'RK 501', NULL, NULL, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `rusak_luar`
--

CREATE TABLE `rusak_luar` (
  `id_rusak_luar` bigint(20) UNSIGNED NOT NULL,
  `id_barang_rusak_luar` varchar(255) NOT NULL,
  `jumlah_rusak_luar` varchar(255) NOT NULL,
  `tanggal_rusak_luar` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `user_id_luar` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `rusak_luar`
--
DELIMITER $$
CREATE TRIGGER `tg_rusak_luar` AFTER INSERT ON `rusak_luar` FOR EACH ROW BEGIN
                UPDATE barangs
                SET jumlah = jumlah - NEW.jumlah_rusak_luar
                WHERE
                id_barang = NEW.id_barang_rusak_luar;
                END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rusak_ruangan`
--

CREATE TABLE `rusak_ruangan` (
  `id_rusak_ruangan` bigint(20) UNSIGNED NOT NULL,
  `id_barang_rusak` varchar(255) NOT NULL,
  `jumlah_rusak_ruangan` varchar(255) NOT NULL,
  `id_ruangan_rusak` varchar(255) NOT NULL,
  `tanggal_rusak` date NOT NULL,
  `status` varchar(255) NOT NULL,
  `user_id_ruangan` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Triggers `rusak_ruangan`
--
DELIMITER $$
CREATE TRIGGER `tg_rusak_ruangan` AFTER INSERT ON `rusak_ruangan` FOR EACH ROW BEGIN
                UPDATE input_ruangan
                SET jumlah_masuk = jumlah_masuk - NEW.jumlah_rusak_ruangan
                WHERE
                id_barang = NEW.id_barang_rusak
                AND
                id_ruangan_barang=NEW.id_ruangan_rusak;
                END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` enum('admin','user_1','useer_2','user_3') NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `username`, `password`, `level`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@gmail.com', NULL, 'admin', '$2y$10$ZsIGuubGi8CBh3CQp7WqfOKKO3u9E8IliFd9VO3rsiZkB3P6BNXnK', 'admin', NULL, NULL, NULL),
(2, 'User', 'user@user.com', NULL, 'user', '$2y$10$F2gLEdvm32md0dUG3nA8g.Toq8Z3k1PGB2EHgKEKa.Rxe5XhSOHMa', 'admin', NULL, '2023-05-22 10:36:04', '2023-05-22 10:36:04'),
(3, 'coba 1', 'coba1@gmail.com', NULL, 'coba1', '$2y$10$Scspe3XUBdvIFg.e5a5E.eri2.qu4OuBtLVodR.e0Rc0T8QKCpOkW', 'user_1', NULL, '2023-05-22 10:39:23', '2023-05-22 10:39:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barangs`
--
ALTER TABLE `barangs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `gedung`
--
ALTER TABLE `gedung`
  ADD PRIMARY KEY (`id_gedung`);

--
-- Indexes for table `input_ruangan`
--
ALTER TABLE `input_ruangan`
  ADD PRIMARY KEY (`id_input_ruangan`);

--
-- Indexes for table `inventori`
--
ALTER TABLE `inventori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `keluar`
--
ALTER TABLE `keluar`
  ADD PRIMARY KEY (`id_keluar`);

--
-- Indexes for table `keranjang_keluar`
--
ALTER TABLE `keranjang_keluar`
  ADD PRIMARY KEY (`id_keluar`);

--
-- Indexes for table `keranjang_masuk`
--
ALTER TABLE `keranjang_masuk`
  ADD PRIMARY KEY (`id_masuk`);

--
-- Indexes for table `keranjang_peminjaman`
--
ALTER TABLE `keranjang_peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `keranjang_ruangan`
--
ALTER TABLE `keranjang_ruangan`
  ADD PRIMARY KEY (`id_input_ruangan`);

--
-- Indexes for table `keranjang_rusak_luar`
--
ALTER TABLE `keranjang_rusak_luar`
  ADD PRIMARY KEY (`id_rusak_luar`);

--
-- Indexes for table `keranjang_rusak_ruangan`
--
ALTER TABLE `keranjang_rusak_ruangan`
  ADD PRIMARY KEY (`id_rusak_ruangan`);

--
-- Indexes for table `log_mobilitas`
--
ALTER TABLE `log_mobilitas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_pelabelan`
--
ALTER TABLE `log_pelabelan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_pencatatan`
--
ALTER TABLE `log_pencatatan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `masuk`
--
ALTER TABLE `masuk`
  ADD PRIMARY KEY (`id_masuk`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mobilitas`
--
ALTER TABLE `mobilitas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`id_ruangan`);

--
-- Indexes for table `rusak_luar`
--
ALTER TABLE `rusak_luar`
  ADD PRIMARY KEY (`id_rusak_luar`);

--
-- Indexes for table `rusak_ruangan`
--
ALTER TABLE `rusak_ruangan`
  ADD PRIMARY KEY (`id_rusak_ruangan`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `barangs`
--
ALTER TABLE `barangs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gedung`
--
ALTER TABLE `gedung`
  MODIFY `id_gedung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `input_ruangan`
--
ALTER TABLE `input_ruangan`
  MODIFY `id_input_ruangan` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventori`
--
ALTER TABLE `inventori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id_kategori` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keluar`
--
ALTER TABLE `keluar`
  MODIFY `id_keluar` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_keluar`
--
ALTER TABLE `keranjang_keluar`
  MODIFY `id_keluar` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_masuk`
--
ALTER TABLE `keranjang_masuk`
  MODIFY `id_masuk` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_peminjaman`
--
ALTER TABLE `keranjang_peminjaman`
  MODIFY `id_peminjaman` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_ruangan`
--
ALTER TABLE `keranjang_ruangan`
  MODIFY `id_input_ruangan` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_rusak_luar`
--
ALTER TABLE `keranjang_rusak_luar`
  MODIFY `id_rusak_luar` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keranjang_rusak_ruangan`
--
ALTER TABLE `keranjang_rusak_ruangan`
  MODIFY `id_rusak_ruangan` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_mobilitas`
--
ALTER TABLE `log_mobilitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `log_pelabelan`
--
ALTER TABLE `log_pelabelan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_pencatatan`
--
ALTER TABLE `log_pencatatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `masuk`
--
ALTER TABLE `masuk`
  MODIFY `id_masuk` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `mobilitas`
--
ALTER TABLE `mobilitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id_peminjaman` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ruangan`
--
ALTER TABLE `ruangan`
  MODIFY `id_ruangan` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rusak_luar`
--
ALTER TABLE `rusak_luar`
  MODIFY `id_rusak_luar` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rusak_ruangan`
--
ALTER TABLE `rusak_ruangan`
  MODIFY `id_rusak_ruangan` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
