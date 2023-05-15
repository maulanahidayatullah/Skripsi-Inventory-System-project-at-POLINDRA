-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2023 at 10:30 PM
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
-- Database: `inventory_dev`
--

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
  `id` int(11) NOT NULL,
  `jurusan_id` int(11) NOT NULL,
  `nama_gedung` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventori`
--

CREATE TABLE `inventori` (
  `id` int(11) NOT NULL,
  `merk` varchar(255) NOT NULL,
  `qty` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `nup` int(11) NOT NULL,
  `tahun` year(4) NOT NULL,
  `kode_barang` int(11) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `qr` varchar(255) NOT NULL,
  `nilai_bmn` int(11) NOT NULL,
  `pelabelan` enum('sudah','belum') NOT NULL,
  `kondisi` enum('B','RR','RB') NOT NULL,
  `jurusan_id` int(11) NOT NULL,
  `gedung_id` int(11) NOT NULL,
  `ruangan_id` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventori`
--

INSERT INTO `inventori` (`id`, `merk`, `qty`, `harga`, `nup`, `tahun`, `kode_barang`, `nama_barang`, `qr`, `nilai_bmn`, `pelabelan`, `kondisi`, `jurusan_id`, `gedung_id`, `ruangan_id`, `keterangan`, `created_at`, `updated_at`) VALUES
(1, 'Xiaomi', 1, 10000, 123123, '2019', 123, 'Laptop', 'Gambar', 123, 'sudah', 'B', 1, 3, 1, 'Ini barang', '2023-04-04 03:42:43', '2023-05-15 13:26:42'),
(2, 'Lenovo', 12, 300000, 123432, '2019', 222, 'Keyboard', 'gambar', 123, 'belum', 'B', 1, 1, 1, 'Ini keyboard', '2023-04-04 03:42:43', '2023-04-04 03:42:43');

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE `jurusan` (
  `id` int(11) NOT NULL,
  `nama_jurusan` varchar(255) NOT NULL,
  `penanggung_jawab` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_brg_dtg`
--

CREATE TABLE `log_brg_dtg` (
  `id` int(11) NOT NULL,
  `inventori_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(2, 4, 13, 17, 'true', '2023-05-15 12:28:36', '2023-05-15 13:27:55'),
(3, 4, 14, NULL, 'false', '2023-05-15 12:37:25', '2023-05-15 12:37:25');

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
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mobilitas`
--

CREATE TABLE `mobilitas` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `inventori_id` int(11) NOT NULL,
  `jurusan_id` int(11) NOT NULL,
  `gedung_id` int(11) NOT NULL,
  `ruangan_id` int(11) NOT NULL,
  `selesai` enum('true','false') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mobilitas`
--

INSERT INTO `mobilitas` (`id`, `user_id`, `inventori_id`, `jurusan_id`, `gedung_id`, `ruangan_id`, `selesai`, `created_at`, `updated_at`) VALUES
(13, 4, 1, 1, 1, 1, 'true', '2023-05-15 12:28:36', '2023-05-15 13:27:55'),
(14, 4, 2, 1, 1, 1, 'false', '2023-05-15 12:37:25', '2023-05-15 12:37:25'),
(17, 4, 1, 1, 3, 1, 'true', '2023-05-15 13:27:55', '2023-05-15 13:27:55');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
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
(1, 4, 'Maulana', 'Jatibarang', 'Mahasiswa', '08989876845', '2023-04-04 03:42:43', '2023-04-04 03:42:43');

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
(1, 'App\\Models\\User', 1, 'auth_token', 'a78fdcdac8684d736c7ff1c47b80a85fe1510bab9c83d7eb2bbdc04ca57572eb', '[\"*\"]', NULL, NULL, '2023-04-04 03:17:23', '2023-04-04 03:17:23'),
(2, 'App\\Models\\User', 3, 'auth_token', '52a1845a5328c0c139f3c8fc0008a81ee1dcf6836adcb0f6f979b570e372c478', '[\"*\"]', NULL, NULL, '2023-04-04 03:39:07', '2023-04-04 03:39:07'),
(3, 'App\\Models\\User', 4, 'auth_token', '3242af13247c8665ca45d0aec90316215aabdf58b9be5fca9a75d5284ec4dec4', '[\"*\"]', NULL, NULL, '2023-04-04 03:42:43', '2023-04-04 03:42:43'),
(4, 'App\\Models\\User', 4, 'auth_token', '57f4575ec2f1b85fa018be01b6db29bc525de87bbb352d33636772b6ff1e9779', '[\"*\"]', NULL, NULL, '2023-04-04 03:44:06', '2023-04-04 03:44:06'),
(5, 'App\\Models\\User', 4, 'auth_token', '821774e050dbae0a0ad58fe6606db51543ed47027f21a0c4abf7177d8dfabfc9', '[\"*\"]', NULL, NULL, '2023-04-04 03:45:09', '2023-04-04 03:45:09'),
(6, 'App\\Models\\User', 4, 'auth_token', 'fab6f75523bf435d8262d063a3541ea0a9926baef4cccad25ca50a621a4c34f2', '[\"*\"]', NULL, NULL, '2023-04-04 03:45:10', '2023-04-04 03:45:10'),
(7, 'App\\Models\\User', 4, 'auth_token', 'e747354947661ba4a4a1cecb470a86b3494a66c830926b936eb37da5d3e28d1f', '[\"*\"]', NULL, NULL, '2023-04-04 03:45:13', '2023-04-04 03:45:13'),
(8, 'App\\Models\\User', 4, 'auth_token', 'ab36e9bdafd1efc253cdf936d0ae5dbdac89c92101220b60b5e04cc425c6cee6', '[\"*\"]', NULL, NULL, '2023-04-04 03:45:14', '2023-04-04 03:45:14'),
(9, 'App\\Models\\User', 4, 'auth_token', '65f67b8afa9914c28269b91afeb6b519d569886d48eff8b7e4b68322c31eb46e', '[\"*\"]', NULL, NULL, '2023-04-04 03:45:15', '2023-04-04 03:45:15'),
(10, 'App\\Models\\User', 4, 'auth_token', 'fcfb0382d35a53add35a5950d48c3580f2c6c72f17960b388d72864f314dd18b', '[\"*\"]', '2023-04-04 04:10:41', NULL, '2023-04-04 04:07:12', '2023-04-04 04:10:41'),
(13, 'App\\Models\\User', 4, 'auth_token', '340331b036324731485edbdabbafd5b4adf8b8f3ad5008674e7e193249eacb14', '[\"*\"]', NULL, NULL, '2023-04-07 21:32:59', '2023-04-07 21:32:59'),
(14, 'App\\Models\\User', 4, 'auth_token', '1fc1a5c7d4e04fa11e70bf532031dae5f66d4ae3ef17ed85a73f023393937a4b', '[\"*\"]', NULL, NULL, '2023-04-07 21:33:24', '2023-04-07 21:33:24'),
(15, 'App\\Models\\User', 4, 'auth_token', 'c37401fcfe00d29593b7b0de5c429cf07f159c5bf6b09cdccd263f8c7e7b4173', '[\"*\"]', NULL, NULL, '2023-04-07 21:50:49', '2023-04-07 21:50:49'),
(16, 'App\\Models\\User', 4, 'auth_token', 'a57038e126f7354b1711a0eb50cc3157b3db0280816887f44492a7366cf8f8d7', '[\"*\"]', NULL, NULL, '2023-04-07 21:53:03', '2023-04-07 21:53:03'),
(17, 'App\\Models\\User', 4, 'auth_token', '07abecad2b0c2aef345147e0f3cb874aa2ccac7d52d5a82af7d5d7b11d18b6c2', '[\"*\"]', NULL, NULL, '2023-04-07 21:53:15', '2023-04-07 21:53:15'),
(18, 'App\\Models\\User', 4, 'auth_token', 'fde4ac2b7c107a878f74924a5a594ed5743d8e190e1ece74161c0bbc0aa75538', '[\"*\"]', NULL, NULL, '2023-04-07 21:54:34', '2023-04-07 21:54:34'),
(19, 'App\\Models\\User', 4, 'auth_token', '1f010476e4f1e1bcf64fddfebbdec206c0648141a0ab61c9f251f8bba7b6b11e', '[\"*\"]', NULL, NULL, '2023-04-08 00:00:38', '2023-04-08 00:00:38'),
(20, 'App\\Models\\User', 4, 'auth_token', '7435aec1019870ec4fd5f45abdda22ff50375cac49b05d6cc14fe1368d23b4f2', '[\"*\"]', NULL, NULL, '2023-04-08 00:04:20', '2023-04-08 00:04:20'),
(21, 'App\\Models\\User', 4, 'auth_token', '17a58cd989fcb567c55df4d896c1b76628e286d35dfcaaf8c34cac8de0ffa60a', '[\"*\"]', NULL, NULL, '2023-04-08 00:08:22', '2023-04-08 00:08:22'),
(22, 'App\\Models\\User', 4, 'auth_token', 'd5551f2dd1e64d1b36bda208589c6b212e1a1d9502bf086b8ef6374985b497fd', '[\"*\"]', NULL, NULL, '2023-04-08 00:08:53', '2023-04-08 00:08:53'),
(23, 'App\\Models\\User', 4, 'auth_token', '03e7caa5824f48bfc032390cf0022f7412dd39b6da3a4bfcc980827a14babfb9', '[\"*\"]', NULL, NULL, '2023-04-08 00:11:06', '2023-04-08 00:11:06'),
(24, 'App\\Models\\User', 4, 'auth_token', '29b20d319581812641ef1ae92b9d74ee567abbf21d259f3947549835910385aa', '[\"*\"]', NULL, NULL, '2023-04-08 01:05:58', '2023-04-08 01:05:58'),
(25, 'App\\Models\\User', 4, 'auth_token', 'c6ae895f72d0aa4eed3efb474154dece60748151953540dee1bc834f044f49e4', '[\"*\"]', NULL, NULL, '2023-04-08 04:15:29', '2023-04-08 04:15:29'),
(26, 'App\\Models\\User', 4, 'auth_token', 'de46faa12993cb5c6ee9ad16024e5ba9257483b56ba3519ad8edca4e55c23e3f', '[\"*\"]', NULL, NULL, '2023-04-08 04:38:42', '2023-04-08 04:38:42'),
(27, 'App\\Models\\User', 4, 'auth_token', '3261a3076f66cd8f55b66a9c93a940bfabbf8963a0ecab01899a260531bd76fa', '[\"*\"]', NULL, NULL, '2023-04-08 05:28:53', '2023-04-08 05:28:53'),
(28, 'App\\Models\\User', 4, 'auth_token', 'ab49da3fcca54f82c85666ed8169cbb9d7b87738348759be0c45495b00927d3b', '[\"*\"]', NULL, NULL, '2023-04-12 09:01:13', '2023-04-12 09:01:13'),
(30, 'App\\Models\\User', 4, 'auth_token', 'f7d4e9ecb6880952139a9d315524a3a9a800c4f7b95115ecaac9566f28a2c806', '[\"*\"]', NULL, NULL, '2023-04-12 09:55:50', '2023-04-12 09:55:50'),
(31, 'App\\Models\\User', 4, 'auth_token', '22658576feaaa59d541853929d1708a48b0ef55e0aaf68b04f6e56716c7bbca4', '[\"*\"]', NULL, NULL, '2023-04-12 09:57:02', '2023-04-12 09:57:02'),
(32, 'App\\Models\\User', 4, 'auth_token', 'ebefa75cd4e4818f57e9508e15dd1f54877bb793bf510a16b60521a2e4422fb2', '[\"*\"]', NULL, NULL, '2023-04-12 10:00:37', '2023-04-12 10:00:37'),
(33, 'App\\Models\\User', 4, 'auth_token', '3210f4fe58ff76dd042436b127fabb4895d811104e442ae96a48217c21999c75', '[\"*\"]', NULL, NULL, '2023-05-12 20:46:46', '2023-05-12 20:46:46'),
(34, 'App\\Models\\User', 4, 'auth_token', '2cdb654d0f9c014d67165d29974bde99eca7b7acf78203a378c8332ee1067c1b', '[\"*\"]', NULL, NULL, '2023-05-12 20:49:10', '2023-05-12 20:49:10'),
(35, 'App\\Models\\User', 4, 'auth_token', '8886db085b9e68cbff1e9e8a4ef214a78a6ab040657b0d2d899b4c5dc3a98699', '[\"*\"]', NULL, NULL, '2023-05-12 20:49:18', '2023-05-12 20:49:18'),
(36, 'App\\Models\\User', 4, 'auth_token', 'd02d922fa24de2c4f0b5f1b7d8a26a651d2c30e714893ab817b8338f3ad01e9d', '[\"*\"]', NULL, NULL, '2023-05-12 20:49:20', '2023-05-12 20:49:20'),
(37, 'App\\Models\\User', 4, 'auth_token', 'a71bf366f3bc2672efdefd26b014e15e754faba8fc5d1a8b09a78edd7d1ba0b0', '[\"*\"]', NULL, NULL, '2023-05-12 20:55:13', '2023-05-12 20:55:13'),
(38, 'App\\Models\\User', 4, 'auth_token', '9ce16c676e86d62ae057f41f9a2bab3a5e600794c6901e16545bb61a7475db08', '[\"*\"]', NULL, NULL, '2023-05-12 20:59:45', '2023-05-12 20:59:45'),
(40, 'App\\Models\\User', 4, 'auth_token', 'a064603912aaa3eabd58e4c2bf9a71003ede0236b96cff434fdf30dc9264fcae', '[\"*\"]', '2023-05-12 22:36:21', NULL, '2023-05-12 21:07:09', '2023-05-12 22:36:21'),
(41, 'App\\Models\\User', 4, 'auth_token', 'a20f2e36005c8c6bb5a832d52cf74cd1ff1db3d87380e49facddc3467ec9a9d1', '[\"*\"]', '2023-05-12 22:46:19', NULL, '2023-05-12 22:36:49', '2023-05-12 22:46:19');

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `id` int(11) NOT NULL,
  `gedung_id` int(11) NOT NULL,
  `nama_ruangan` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(4, 'user123', 'user@user.com', NULL, '$2y$10$qReT6UMI9.SgpT//kFGDeuyDfldzACy6XdmMnS8nF2Txv6pKX5Aoa', NULL, '2023-04-04 03:42:43', '2023-04-04 03:42:43');

--
-- Indexes for dumped tables
--

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventori`
--
ALTER TABLE `inventori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_brg_dtg`
--
ALTER TABLE `log_brg_dtg`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

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
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gedung`
--
ALTER TABLE `gedung`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventori`
--
ALTER TABLE `inventori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jurusan`
--
ALTER TABLE `jurusan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_brg_dtg`
--
ALTER TABLE `log_brg_dtg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_mobilitas`
--
ALTER TABLE `log_mobilitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mobilitas`
--
ALTER TABLE `mobilitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
