-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 14, 2023 at 01:33 PM
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
(4, 'Gedung Study Center', NULL, NULL);

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
-- Table structure for table `instansi`
--

CREATE TABLE `instansi` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instansi`
--

INSERT INTO `instansi` (`id`, `nama`, `created_at`, `updated_at`) VALUES
(1, 'Folafo', '2023-08-10 15:30:39', '2023-08-10 15:30:39');

-- --------------------------------------------------------

--
-- Table structure for table `inventori`
--

CREATE TABLE `inventori` (
  `id` int(11) NOT NULL,
  `uraian_akun` varchar(255) DEFAULT NULL,
  `kode_barang` varchar(11) DEFAULT NULL,
  `nama_barang` varchar(255) DEFAULT NULL,
  `tahun_perolehan` date DEFAULT NULL,
  `nup` varchar(11) DEFAULT NULL,
  `merk_type` varchar(255) DEFAULT NULL,
  `kuantitas` int(11) DEFAULT NULL,
  `nilai_bmn` int(255) DEFAULT NULL,
  `pengguna` varchar(255) DEFAULT NULL,
  `kondisi_barang` enum('B','RR','RB') DEFAULT NULL,
  `keberadaan_barang` enum('BD','BTD','Berlebih') DEFAULT NULL,
  `pelabelan_kodefikasi` enum('sudah','belum') DEFAULT NULL,
  `gedung_id` int(11) DEFAULT NULL,
  `ruangan_id` int(11) DEFAULT NULL,
  `status_psp` enum('sudah','belum') DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventori`
--

INSERT INTO `inventori` (`id`, `uraian_akun`, `kode_barang`, `nama_barang`, `tahun_perolehan`, `nup`, `merk_type`, `kuantitas`, `nilai_bmn`, `pengguna`, `kondisi_barang`, `keberadaan_barang`, `pelabelan_kodefikasi`, `gedung_id`, `ruangan_id`, `status_psp`, `keterangan`, `created_at`, `updated_at`) VALUES
(3, 'Peralatan 123', '2147483647', 'PC Workstation', '2023-05-02', '157', 'LENOVO ThinkStation P350 Tower', 1, 35430010, 'TI', 'B', 'BD', 'sudah', 4, 7, 'sudah', 'keterangan', '2023-04-04 03:42:43', '2023-08-08 21:09:27'),
(4, '1', '1', '1', '2022-01-01', '1', '123', 1, 1231, 'TM', 'B', 'BD', 'sudah', 1, 1, 'sudah', '123', NULL, NULL),
(5, 'Peralatan 123', '123', 'Kursi', '2022-01-01', '123', 'IKEA', 28, 2000, 'TP', 'B', 'BD', 'sudah', 4, 7, 'sudah', 'Ini Kursi', NULL, '2023-05-25 23:54:40'),
(354, 'Peralatan', '3100101007', 'PC Workstation', '2023-08-07', '156', 'LENOVO ThinkStation P350 Tower', 1, 35430010, 'TI', 'RB', 'BTD', 'sudah', 1, 1, 'sudah', 'PC tidak ada', '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(355, 'Peralatan', '3100101007', 'PC Workstation', '2023-08-07', '157', 'LENOVO ThinkStation P350 Tower', 1, 35430010, 'TI', 'RB', 'BD', 'sudah', 1, 1, 'sudah', 'PC tidak ada', '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(356, 'Peralatan', '3100101007', 'PC Workstation', '2023-08-07', '158', 'LENOVO ThinkStation P350 Tower', 1, 35430010, 'TI', 'B', 'Berlebih', 'sudah', 1, 1, 'sudah', 'PC+3monitor dell', '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(357, 'Peralatan', '3100101007', 'PC Workstation', '2023-08-07', '159', 'Lenovo ThinkStation P620 Tower', 1, 103999940, 'TM', 'B', 'BD', 'belum', 1, 1, 'belum', NULL, '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(358, 'Peralatan', '3100101007', 'PC Workstation', '2023-08-07', '160', 'Lenovo ThinkStation P620 Tower', 1, 103999940, 'TM', 'B', 'BD', 'sudah', 1, 1, 'sudah', NULL, '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(359, 'Peralatan', '3100101007', 'PC Workstation', '2023-08-07', '161', 'Lenovo ThinkStation P620 Tower', 1, 103999940, 'TM', 'B', 'Berlebih', 'belum', 1, 1, 'belum', NULL, '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(360, 'Peralatan', '3100102003', 'Note Book', '2023-08-07', '196', 'Lenovo ThinkPad P15 Gen 2', 1, 34999910, 'Rahmat', 'B', 'BD', 'sudah', 1, 1, 'sudah', NULL, '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(361, 'Peralatan', '3100102003', 'Note Book', '2023-08-07', '197', 'Lenovo ThinkPad P15 Gen 2', 1, 34999910, 'Gozali', 'B', 'Berlebih', 'belum', 1, 1, 'belum', NULL, '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(362, 'Peralatan', '3100102003', 'Note Book', '2023-08-07', '198', 'Lenovo ThinkPad P15 Gen 2', 1, 34999910, 'Azwar', 'B', 'BD', 'sudah', 1, 1, 'sudah', NULL, '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(363, 'Peralatan', '3100102003', 'Note Book', '2023-08-07', '199', 'Lenovo ThinkPad P15 Gen 2', 1, 34999910, 'TM', 'B', 'BD', 'belum', 1, 1, 'belum', NULL, '2023-08-07 09:28:06', '2023-08-07 09:28:06'),
(364, 'asd', '123', '123', '2022-01-01', '123', '123', 12, 34324, '123', 'B', 'BTD', 'sudah', 4, 6, 'belum', '123', NULL, NULL),
(365, '123', '123', '123', '2023-03-08', '1233', '123', 123, 1234, '1234', 'RR', 'BD', 'belum', 4, 7, 'sudah', 'asd', NULL, NULL);

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
(51, 2, 82, 84, 'true', '2023-05-30 01:12:49', '2023-05-30 01:14:36'),
(53, 2, 85, 86, 'true', '2023-06-22 14:00:48', '2023-06-23 22:54:03'),
(54, 2, 87, 88, 'true', '2023-06-23 22:59:12', '2023-06-23 22:59:22'),
(55, 2, 89, 90, 'true', '2023-06-23 22:59:41', '2023-06-23 23:00:17'),
(56, 2, 91, 92, 'true', '2023-06-23 23:01:39', '2023-06-23 23:01:52'),
(57, 2, 93, 94, 'true', '2023-06-23 23:06:41', '2023-06-23 23:06:58'),
(61, 2, 98, 99, 'true', '2023-07-11 04:06:34', '2023-07-11 04:06:43'),
(62, 2, 100, 101, 'true', '2023-07-11 04:25:38', '2023-07-11 04:25:55'),
(63, 2, 102, NULL, 'false', '2023-08-10 08:39:09', '2023-08-10 08:39:09');

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
-- Table structure for table `log_peminjaman`
--

CREATE TABLE `log_peminjaman` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `peminjaman_id` int(11) NOT NULL,
  `pengembalian_id` int(11) NOT NULL,
  `selesai` enum('true','false') NOT NULL,
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
(84, 2, 3, 4, 7, 'true', '2023-05-30 01:14:36', '2023-05-30 01:14:36'),
(85, 2, 3, 4, 7, 'true', '2023-06-22 14:00:48', '2023-06-23 22:54:03'),
(86, 2, 3, 4, 7, 'true', '2023-06-23 22:54:03', '2023-06-23 22:54:03'),
(87, 2, 3, 4, 7, 'true', '2023-06-23 22:59:12', '2023-06-23 22:59:22'),
(88, 2, 3, 1, 1, 'true', '2023-06-23 22:59:22', '2023-06-23 22:59:22'),
(89, 2, 3, 1, 1, 'true', '2023-06-23 22:59:41', '2023-06-23 23:00:16'),
(90, 2, 3, 4, 7, 'true', '2023-06-23 23:00:17', '2023-06-23 23:00:17'),
(91, 2, 3, 4, 7, 'true', '2023-06-23 23:01:39', '2023-06-23 23:01:52'),
(92, 2, 3, 3, 5, 'true', '2023-06-23 23:01:52', '2023-06-23 23:01:52'),
(93, 2, 3, 3, 5, 'true', '2023-06-23 23:06:41', '2023-06-23 23:06:57'),
(94, 2, 3, 4, 7, 'true', '2023-06-23 23:06:58', '2023-06-23 23:06:58'),
(98, 2, 3, 4, 7, 'true', '2023-07-11 04:06:34', '2023-07-11 04:06:43'),
(99, 2, 3, 1, 4, 'true', '2023-07-11 04:06:43', '2023-07-11 04:06:43'),
(100, 2, 3, 1, 4, 'true', '2023-07-11 04:25:38', '2023-07-11 04:25:55'),
(101, 2, 3, 4, 7, 'true', '2023-07-11 04:25:55', '2023-07-11 04:25:55'),
(102, 2, 3, 4, 7, 'false', '2023-08-10 08:39:09', '2023-08-10 08:39:09');

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
-- Table structure for table `pelabelan`
--

CREATE TABLE `pelabelan` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `inventori_id` int(11) NOT NULL,
  `status` enum('true','false') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelabelan`
--

INSERT INTO `pelabelan` (`id`, `user_id`, `inventori_id`, `status`, `created_at`, `updated_at`) VALUES
(15, 1, 3, 'false', NULL, NULL),
(20, 1, 355, 'false', NULL, NULL),
(21, 1, 358, 'false', NULL, NULL),
(22, 1, 359, 'false', NULL, NULL),
(23, 1, 360, 'false', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `peminjaman`
--

CREATE TABLE `peminjaman` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `instansi_id` int(11) DEFAULT NULL,
  `inventori_id` int(11) DEFAULT NULL,
  `ruangan_id` int(11) DEFAULT NULL,
  `kode_peminjaman` text DEFAULT NULL,
  `kondisi_barang` enum('B','RR','RB') DEFAULT NULL,
  `unit_kerja` varchar(255) DEFAULT NULL,
  `nama_kegiatan` varchar(255) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `satuan` int(11) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `tgl_pinjam` datetime DEFAULT NULL,
  `tgl_kembali` datetime DEFAULT NULL,
  `persetujuan_wadir` enum('belum','setuju','tidak_setuju') DEFAULT NULL,
  `persetujuan_pembimbing` enum('belum','setuju','tidak_setuju') DEFAULT NULL,
  `status_persetujuan` enum('belum','setuju','tidak_setuju') DEFAULT NULL,
  `keranjang` enum('true','false') NOT NULL,
  `selesai` enum('true','false') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `peminjaman`
--

INSERT INTO `peminjaman` (`id`, `user_id`, `instansi_id`, `inventori_id`, `ruangan_id`, `kode_peminjaman`, `kondisi_barang`, `unit_kerja`, `nama_kegiatan`, `jumlah`, `satuan`, `keterangan`, `tgl_pinjam`, `tgl_kembali`, `persetujuan_wadir`, `persetujuan_pembimbing`, `status_persetujuan`, `keranjang`, `selesai`, `created_at`, `updated_at`) VALUES
(17, 2, 1, 5, NULL, 'Pol-P-2-230811', 'B', 'polindra', 'pembelajaran folafo', 1, 1, 'Pembelajaran rutin folafo', '2023-08-11 11:10:00', '2023-06-23 12:00:00', 'setuju', 'setuju', 'setuju', 'false', 'true', '2023-08-11 04:06:43', '2023-08-11 04:25:01'),
(18, 2, 1, 3, NULL, 'Pol-P-2-230811', 'RR', 'polindra', 'pembelajaran folafo', 1, 1, 'Pembelajaran rutin folafo', '2023-08-11 11:10:00', '2023-06-23 12:00:00', 'setuju', 'setuju', 'setuju', 'false', 'true', '2023-08-11 04:10:43', '2023-08-11 04:25:01'),
(21, 2, 1, 358, NULL, 'Pol-P-2-230814', 'B', 'Polindra', 'Kegiatan', NULL, NULL, 'keterangan', '2023-08-14 06:07:00', '2023-06-23 12:00:00', 'belum', 'belum', 'belum', 'false', NULL, '2023-08-13 23:06:55', '2023-08-13 23:07:49');

-- --------------------------------------------------------

--
-- Table structure for table `pengembalian`
--

CREATE TABLE `pengembalian` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `peminjaman_id` int(11) NOT NULL,
  `kode_peminjaman` varchar(255) DEFAULT NULL,
  `tgl_kembali` datetime NOT NULL,
  `kondisi_barang` enum('B','RR','RB') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengembalian`
--

INSERT INTO `pengembalian` (`id`, `user_id`, `peminjaman_id`, `kode_peminjaman`, `tgl_kembali`, `kondisi_barang`, `created_at`, `updated_at`) VALUES
(5, 2, 17, 'Pol-P-2-230811', '2023-08-13 03:37:00', 'B', NULL, NULL),
(6, 2, 18, 'Pol-P-2-230811', '2023-08-13 03:37:00', 'B', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
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
-- Dumping data for table `pengguna`
--

INSERT INTO `pengguna` (`id`, `user_id`, `nama`, `alamat`, `jabatan`, `no_hp`, `created_at`, `updated_at`) VALUES
(1, 2, 'Maulana Hidayatullah asdfjkhkdlfjhsdfgf kjhkjhsdf', 'Jatibarang', 'Mahasiswa', '08989876845', '2023-04-04 03:42:43', '2023-04-04 03:42:43');

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
(8, 'App\\Models\\User', 2, 'auth_token', 'f0d4b38cc52c2064c0fb7236cdd29c2ce58fc43b5a1a21701fac578c19c404a4', '[\"*\"]', '2023-08-13 18:08:01', NULL, '2023-05-25 08:54:32', '2023-08-13 18:08:01'),
(10, 'App\\Models\\User', 2, 'auth_token', '928c41f0343c690686a00bc479ddf97a03cc86dfcdbccef5c324d5769a5094d7', '[\"*\"]', NULL, NULL, '2023-06-26 02:15:24', '2023-06-26 02:15:24'),
(11, 'App\\Models\\User', 2, 'auth_token', '7eca0935810f1c610b12a87be9f05e3ad2a193ba732efc2baa05da7ffdad003c', '[\"*\"]', NULL, NULL, '2023-07-11 03:09:03', '2023-07-11 03:09:03'),
(12, 'App\\Models\\User', 2, 'auth_token', 'd99222254fbb86dde5af21b3562d97efa40673f8c96a648c458faa089eb200c2', '[\"*\"]', NULL, NULL, '2023-07-11 04:00:00', '2023-07-11 04:00:00'),
(13, 'App\\Models\\User', 2, 'auth_token', '2cdb88fad9800644a9657864c9e316102946342a20a8487095dd87a6de94a0fd', '[\"*\"]', NULL, NULL, '2023-07-11 04:01:37', '2023-07-11 04:01:37'),
(14, 'App\\Models\\User', 2, 'auth_token', '144c7588cc71449b17482548e8394733b606a5166a41d84a7e8f8fe1501ccf77', '[\"*\"]', NULL, NULL, '2023-07-11 04:04:07', '2023-07-11 04:04:07'),
(15, 'App\\Models\\User', 2, 'auth_token', 'bf7407e857f7c2cb4d5c5c68ced21d25e60572bad57db02e37c48a08330deb2c', '[\"*\"]', NULL, NULL, '2023-07-11 04:17:50', '2023-07-11 04:17:50'),
(16, 'App\\Models\\User', 2, 'auth_token', 'a5c6bbf7064dcc6e5f5c885fb3ff391b4de06555d4f3349f53e66974b5960695', '[\"*\"]', NULL, NULL, '2023-07-11 04:21:01', '2023-07-11 04:21:01'),
(20, 'App\\Models\\User', 2, 'auth_token', '0c9af25625eb6c11abc22256ea7ceba20cbe53030c9516fc050cb41cda25984a', '[\"*\"]', NULL, NULL, '2023-08-09 20:18:00', '2023-08-09 20:18:00'),
(21, 'App\\Models\\User', 2, 'auth_token', 'f552aed05f52182d52993d65b82251d4ff5e65e5d7275da0c7a5d0440cf3582d', '[\"*\"]', NULL, NULL, '2023-08-09 20:32:58', '2023-08-09 20:32:58'),
(22, 'App\\Models\\User', 2, 'auth_token', '7c33771878f9d4f52630ac45b0763d98235da39712c831ae5add941c69cb6215', '[\"*\"]', NULL, NULL, '2023-08-09 20:33:41', '2023-08-09 20:33:41'),
(23, 'App\\Models\\User', 2, 'auth_token', '708c5e9db9f25d1c0061bad886b0bc1465ed77f41b2c497f6dbb498a720f56c2', '[\"*\"]', NULL, NULL, '2023-08-09 20:38:46', '2023-08-09 20:38:46'),
(24, 'App\\Models\\User', 2, 'auth_token', '8d7f3d8b7536b05e99a310504cbaba542c253bec524ae3e09cbabaa091d99d69', '[\"*\"]', NULL, NULL, '2023-08-09 20:41:26', '2023-08-09 20:41:26'),
(25, 'App\\Models\\User', 2, 'auth_token', '4f22aa68cbfd0df216a460d719e5a8b6028575faceca9318985a14cd8c215b24', '[\"*\"]', NULL, NULL, '2023-08-09 20:42:34', '2023-08-09 20:42:34'),
(26, 'App\\Models\\User', 2, 'auth_token', '327be85ad8264b843e8d8d0a5bf8d4dce69a02ae000227520923d843f150b01f', '[\"*\"]', NULL, NULL, '2023-08-09 20:51:25', '2023-08-09 20:51:25'),
(27, 'App\\Models\\User', 2, 'auth_token', '02b8169e11a02db7d959500cd0ddba720904a9d357a337389c5a8e1b0d3e89c4', '[\"*\"]', NULL, NULL, '2023-08-09 20:59:49', '2023-08-09 20:59:49'),
(28, 'App\\Models\\User', 2, 'auth_token', '3b91f3a613829684c7463a306893319525503b68d0bd5833b2098a811dfeb4e2', '[\"*\"]', NULL, NULL, '2023-08-09 21:01:57', '2023-08-09 21:01:57'),
(29, 'App\\Models\\User', 2, 'auth_token', '5230119409d3111b874eeabb823e21ffb13683b9eed1daef467c2ddad2af393a', '[\"*\"]', '2023-08-13 18:21:59', NULL, '2023-08-09 21:21:14', '2023-08-13 18:21:59'),
(30, 'App\\Models\\User', 2, 'auth_token', 'cc51432b954e2363e14b8578adaf9aeeecc06ca0ff6782e4071fc77fda73c7f3', '[\"*\"]', NULL, NULL, '2023-08-09 21:58:21', '2023-08-09 21:58:21'),
(31, 'App\\Models\\User', 2, 'auth_token', 'e458878a2879cf3386352834c242578f44f27d353bb689beb80d8fba389ba9f3', '[\"*\"]', NULL, NULL, '2023-08-09 22:00:51', '2023-08-09 22:00:51'),
(32, 'App\\Models\\User', 2, 'auth_token', 'd163ca6d8fbe660b40b71db1658c0430f7ea94c56f89d36b39e50ea5af75a5b1', '[\"*\"]', NULL, NULL, '2023-08-09 22:13:11', '2023-08-09 22:13:11'),
(33, 'App\\Models\\User', 2, 'auth_token', '7b410e1ba392e4741f74b0d04d643cb78ab901d6757afb73e674fbff81eff25e', '[\"*\"]', NULL, NULL, '2023-08-09 23:05:14', '2023-08-09 23:05:14'),
(34, 'App\\Models\\User', 2, 'auth_token', '8ffe323ff281df8504f1c949845f1907afb013f505c456206a98d45cd97246fc', '[\"*\"]', NULL, NULL, '2023-08-09 23:37:20', '2023-08-09 23:37:20'),
(35, 'App\\Models\\User', 2, 'auth_token', 'fae4d5fad2193a735049f31bd72f78f92beb0578d5a2e8fb7bfce426a2c2da97', '[\"*\"]', NULL, NULL, '2023-08-10 09:00:21', '2023-08-10 09:00:21'),
(36, 'App\\Models\\User', 2, 'auth_token', '6f4afd61f0fd2afc5326bbbb6f6c88d6b660d2da38c83adffcb60ee9c064bb8a', '[\"*\"]', NULL, NULL, '2023-08-13 18:07:54', '2023-08-13 18:07:54'),
(37, 'App\\Models\\User', 2, 'auth_token', '1062deb6fed5e8a28b5309b4c02a659ffa23cea3872743c4fb675f450ec29c5d', '[\"*\"]', NULL, NULL, '2023-08-13 18:19:16', '2023-08-13 18:19:16'),
(38, 'App\\Models\\User', 2, 'auth_token', '3a04d058c0585eb98fd99615289db2f683be3e389345be6da34a651c5cfb8263', '[\"*\"]', NULL, NULL, '2023-08-13 18:22:52', '2023-08-13 18:22:52'),
(39, 'App\\Models\\User', 2, 'auth_token', '723c9e468f12670ff46641040cc27eb4adc364651cb5ac0308dad3de6dbdb791', '[\"*\"]', '2023-08-13 18:26:40', NULL, '2023-08-13 18:22:57', '2023-08-13 18:26:40'),
(40, 'App\\Models\\User', 2, 'auth_token', 'f672975ce0ca56b466b21b89acaeabfed1b0749a5a973d7bc35941169a33d3c1', '[\"*\"]', '2023-08-13 19:01:52', NULL, '2023-08-13 18:29:12', '2023-08-13 19:01:52'),
(41, 'App\\Models\\User', 2, 'auth_token', '62af944d53241c54953f4df9f10e5a94b023b16ed525193e6cf6ddeaf394563e', '[\"*\"]', '2023-08-13 19:20:30', NULL, '2023-08-13 19:20:25', '2023-08-13 19:20:30'),
(42, 'App\\Models\\User', 2, 'auth_token', '4cb288154c4bba88147d91b75b61237d4921529fae75fa2af5fff255713dbdf8', '[\"*\"]', '2023-08-13 19:22:35', NULL, '2023-08-13 19:22:31', '2023-08-13 19:22:35'),
(43, 'App\\Models\\User', 2, 'auth_token', '95b26bc549e4eecd10a8243652bd255289ae16c549544104cb0f37ff19918a86', '[\"*\"]', '2023-08-13 19:27:19', NULL, '2023-08-13 19:27:14', '2023-08-13 19:27:19'),
(44, 'App\\Models\\User', 2, 'auth_token', 'ee798266182a0413beb04d0cbd24bba5e748d0442a44eb67ab46b60d7c629e15', '[\"*\"]', '2023-08-13 19:30:53', NULL, '2023-08-13 19:30:49', '2023-08-13 19:30:53'),
(45, 'App\\Models\\User', 2, 'auth_token', 'fbdc7346ac30fcec7dfa0281c61807575a267df37de9a608fcbad13f75b56608', '[\"*\"]', '2023-08-13 19:38:48', NULL, '2023-08-13 19:38:44', '2023-08-13 19:38:48'),
(46, 'App\\Models\\User', 2, 'auth_token', '3a240ee0cb9a5e251925f973120aa783432a3cd339e6bb543454e7f67d43a8e5', '[\"*\"]', '2023-08-13 21:18:58', NULL, '2023-08-13 21:18:53', '2023-08-13 21:18:58'),
(47, 'App\\Models\\User', 2, 'auth_token', '76768624e7bf47d767a736b3bb10ac759e6f5feb4365c0e49fd9ff64b1507620', '[\"*\"]', '2023-08-13 21:24:56', NULL, '2023-08-13 21:24:50', '2023-08-13 21:24:56'),
(48, 'App\\Models\\User', 2, 'auth_token', '552293336f506f523023a092d57381b1f72cc164bca7487ba6b9792bea10140e', '[\"*\"]', '2023-08-13 21:30:14', NULL, '2023-08-13 21:30:09', '2023-08-13 21:30:14'),
(49, 'App\\Models\\User', 2, 'auth_token', 'f8f058020eaab5a48e2d39a250f0314bd85be563223bdc8abb3159b7ac9279e2', '[\"*\"]', '2023-08-13 21:32:54', NULL, '2023-08-13 21:32:48', '2023-08-13 21:32:54'),
(50, 'App\\Models\\User', 2, 'auth_token', 'af75a80ca156bd109888a57eba6085ee057b24447c502d82a17bbd424a81a2af', '[\"*\"]', '2023-08-13 22:40:53', NULL, '2023-08-13 22:40:48', '2023-08-13 22:40:53'),
(51, 'App\\Models\\User', 2, 'auth_token', 'e0e73c34cb7d185f8504f1f925bf034f4a04f306bb6d78c1d71d5538b156a2e1', '[\"*\"]', '2023-08-13 22:44:04', NULL, '2023-08-13 22:43:58', '2023-08-13 22:44:04'),
(52, 'App\\Models\\User', 2, 'auth_token', 'f4b5b0cd975b0524a36e4dc229ce6e1f92c02505892b5eff0bdb11e350f05181', '[\"*\"]', '2023-08-13 22:45:05', NULL, '2023-08-13 22:45:01', '2023-08-13 22:45:05'),
(53, 'App\\Models\\User', 2, 'auth_token', '1ead5a1175cc1dfb517a2db08f188f2092d2e517fd63bba44cb58f79ada96c4b', '[\"*\"]', '2023-08-13 23:07:59', NULL, '2023-08-13 22:46:41', '2023-08-13 23:07:59'),
(54, 'App\\Models\\User', 2, 'auth_token', '751ddaf4cbcb83a699a614e289347b9c5032d926295f4204f01a71581b7e962b', '[\"*\"]', '2023-08-13 23:09:57', NULL, '2023-08-13 23:09:52', '2023-08-13 23:09:57'),
(55, 'App\\Models\\User', 2, 'auth_token', '7306038416e26ec9a18dc5d3a75e44ce93be7e6dc5d83fbe8d4165f1d6c6c89b', '[\"*\"]', '2023-08-13 23:11:50', NULL, '2023-08-13 23:11:44', '2023-08-13 23:11:50'),
(56, 'App\\Models\\User', 2, 'auth_token', '478551f1d5cc16ad1f600a874f34a106818efaa7d96780b024569f65e65dbfaf', '[\"*\"]', '2023-08-13 23:18:35', NULL, '2023-08-13 23:18:29', '2023-08-13 23:18:35'),
(57, 'App\\Models\\User', 2, 'auth_token', 'a9d22991481c426e0d7ade29ae022906fd4f7de61d73a9a60909f381cdb4ca36', '[\"*\"]', NULL, NULL, '2023-08-13 23:24:26', '2023-08-13 23:24:26'),
(58, 'App\\Models\\User', 2, 'auth_token', '86153916f06d9cc6906752c529bbffeb7d848ce9a747106da7490b86b77d07ea', '[\"*\"]', NULL, NULL, '2023-08-13 23:24:29', '2023-08-13 23:24:29'),
(59, 'App\\Models\\User', 2, 'auth_token', '30db256153fdb373dad9285cdf708a844f9351476320aff4de099a8503e21134', '[\"*\"]', NULL, NULL, '2023-08-13 23:24:57', '2023-08-13 23:24:57'),
(60, 'App\\Models\\User', 2, 'auth_token', '2e84e26c26ca75a655ea43d99c5b92a0d63c47f8c88e3277e7922ebc77ecc6ef', '[\"*\"]', '2023-08-13 23:28:19', NULL, '2023-08-13 23:28:15', '2023-08-13 23:28:19'),
(61, 'App\\Models\\User', 2, 'auth_token', '38f954cf91712fe29e3bd320ef0f170a2d38a83586a9d08885fb4fb73185d7cf', '[\"*\"]', '2023-08-13 23:30:18', NULL, '2023-08-13 23:29:44', '2023-08-13 23:30:18'),
(62, 'App\\Models\\User', 2, 'auth_token', '0ba5e7d88088727d31a1bfad818b776c152e1ed115e5baeddd4ab202af8f0182', '[\"*\"]', '2023-08-13 23:32:13', NULL, '2023-08-13 23:32:08', '2023-08-13 23:32:13'),
(63, 'App\\Models\\User', 2, 'auth_token', '10651ee744f4978029ff59eee0c3d56623b677f87a28186bb76dab9591f57a55', '[\"*\"]', '2023-08-13 23:33:11', NULL, '2023-08-13 23:33:06', '2023-08-13 23:33:11'),
(64, 'App\\Models\\User', 2, 'auth_token', '388af545b0420e51221d657b205a5be9a90a95c7e470f690b07e737341958458', '[\"*\"]', '2023-08-13 23:35:09', NULL, '2023-08-13 23:35:05', '2023-08-13 23:35:09'),
(65, 'App\\Models\\User', 2, 'auth_token', '47dde51f7ffd386ee5f8cf14e9868537314b10dae46e6bf959bb4391982ae341', '[\"*\"]', '2023-08-13 23:49:30', NULL, '2023-08-13 23:49:25', '2023-08-13 23:49:30');

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
  `instansi_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` enum('admin','user_1','user_2','user_3','user_4','user_5') NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_hp` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `instansi_id`, `name`, `email`, `email_verified_at`, `username`, `password`, `level`, `remember_token`, `alamat`, `no_hp`, `created_at`, `updated_at`) VALUES
(1, NULL, 'admin', 'admin@gmail.com', NULL, 'admin', '$2y$10$ZsIGuubGi8CBh3CQp7WqfOKKO3u9E8IliFd9VO3rsiZkB3P6BNXnK', 'admin', NULL, NULL, NULL, NULL, NULL),
(2, 1, 'User', 'user@user.com', NULL, 'user', '$2y$10$2K0QfXWM4cMKwjUwLuO/SeWQbRj56gH48CqUqtA.Ict183b0rHjX.', 'user_3', NULL, 'Jatibarang', '0895636598234', '2023-05-22 10:36:04', '2023-05-22 10:36:04'),
(4, 1, 'Maulana Hidayatullah 123', 'atomx361@gmail.com', NULL, 'lana', '$2y$10$XpKJVsm5g2LhURW1VEYwfea15kuZWq.7acSMBUrRRqZLJs4V7eShC', 'user_3', NULL, 'Jl. Lohbener lama kecamatan Lohbener kabupaten indramayu - Jawa barat Indonesia', '0895636598769', NULL, NULL),
(5, NULL, 'isa', 'isa@isa.com', NULL, 'isa', '$2y$10$gT6y.IB2ry0bLUsEUGGP/eG8MSgsDRW/.mA713GvTjA3.7JYRmJ1G', 'user_3', NULL, NULL, NULL, '2023-08-14 04:31:34', '2023-08-14 04:31:34');

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
-- Indexes for table `instansi`
--
ALTER TABLE `instansi`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `log_peminjaman`
--
ALTER TABLE `log_peminjaman`
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
-- Indexes for table `pelabelan`
--
ALTER TABLE `pelabelan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `peminjaman`
--
ALTER TABLE `peminjaman`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengembalian`
--
ALTER TABLE `pengembalian`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `instansi`
--
ALTER TABLE `instansi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `inventori`
--
ALTER TABLE `inventori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=366;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `log_pelabelan`
--
ALTER TABLE `log_pelabelan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_peminjaman`
--
ALTER TABLE `log_peminjaman`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `pelabelan`
--
ALTER TABLE `pelabelan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `peminjaman`
--
ALTER TABLE `peminjaman`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `pengembalian`
--
ALTER TABLE `pengembalian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
