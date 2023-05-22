-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2023 at 07:17 PM
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
-- Table structure for table `inventori`
--

CREATE TABLE `inventori` (
  `id` int(11) NOT NULL,
  `uraian_akun` varchar(255) NOT NULL,
  `kode_barang` varchar(255) NOT NULL,
  `nama_barang` varchar(255) NOT NULL,
  `tahun_perolehan` date DEFAULT NULL,
  `nup` int(11) NOT NULL,
  `merk_type` varchar(255) NOT NULL,
  `kuantitas` int(11) NOT NULL,
  `nilai_bmn` int(255) NOT NULL,
  `kondisi_barang` enum('B','RR','RB') NOT NULL,
  `keberadaan_barang` enum('BD','BTD','Berlebih') NOT NULL,
  `pelabelan_kodefikasi` enum('sudah','belum') NOT NULL,
  `pegawai_id` int(11) NOT NULL,
  `gedung_id` int(11) NOT NULL,
  `ruangan_id` int(11) NOT NULL,
  `status_psp` enum('sudah','belum') NOT NULL,
  `nama_sub_satker` varchar(255) NOT NULL,
  `qr` varchar(255) NOT NULL,
  `keterangan` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventori`
--

INSERT INTO `inventori` (`id`, `uraian_akun`, `kode_barang`, `nama_barang`, `tahun_perolehan`, `nup`, `merk_type`, `kuantitas`, `nilai_bmn`, `kondisi_barang`, `keberadaan_barang`, `pelabelan_kodefikasi`, `pegawai_id`, `gedung_id`, `ruangan_id`, `status_psp`, `nama_sub_satker`, `qr`, `keterangan`, `created_at`, `updated_at`) VALUES
(3, 'Peralatan', '3100101007', 'PC Workstation', '2023-05-02', 157, 'LENOVO ThinkStation P350 Tower', 1, 35430010, 'B', 'BD', 'belum', 1, 2, 1, 'belum', 'polindra', 'gambar', 'keterangan', '2023-04-04 03:42:43', '2023-05-16 09:49:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `inventori`
--
ALTER TABLE `inventori`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `inventori`
--
ALTER TABLE `inventori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
