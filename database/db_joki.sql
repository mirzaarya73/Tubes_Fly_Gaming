-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2025 at 04:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_joki`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_isi_saldo` (IN `p_user_id` INT, IN `p_jumlah` INT, IN `p_keterangan` VARCHAR(255))   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    
    UPDATE akses SET saldo = saldo + p_jumlah WHERE id = p_user_id;

    
    INSERT INTO mutasi_saldo (user_id, tipe, jumlah, keterangan)
    VALUES (p_user_id, 'kredit', p_jumlah, p_keterangan);

    COMMIT;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `hitung_diamond_magicwheel` (`poin_sekarang` INT) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE sisa_poin INT;
    DECLARE jumlah_5x INT;
    DECLARE sisa_1x INT;
    DECLARE total_diamond INT;

    -- Hitung sisa poin hanya jika poin valid
    SET sisa_poin = CASE
        WHEN poin_sekarang >= 200 THEN 0
        ELSE 200 - poin_sekarang
    END;

    -- Cek jika sisa_poin 0, diamond juga 0
    SET total_diamond = CASE
        WHEN sisa_poin = 0 THEN 0
        ELSE 
            (sisa_poin DIV 5) * 270 + (sisa_poin MOD 5) * 60
    END;

    RETURN total_diamond;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `akses`
--

CREATE TABLE `akses` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','pembeli') NOT NULL,
  `foto` varchar(255) DEFAULT 'img/default.png',
  `saldo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `akses`
--

INSERT INTO `akses` (`id`, `username`, `password`, `role`, `foto`, `saldo`) VALUES
(5, 'pembeli', '$2y$10$R.HLBX2YBfPjxWhVxcZ2WueqTESImfs3wXryb3LgKHAPQ33Tev/WS', 'pembeli', 'uploads/619cd27ae2af5278080df7e459d7bc68~tplv-tiktokx-cropcenter-1080-1080.jpeg', 25000),
(6, 'user', '$2y$10$mefFU0B/XRRq91.PcWxapO0sMk62JONN3f/XlMHFHdX4T/ewFixCK', 'pembeli', 'img/default.jpg', 9000),
(9, 'admin', '$2y$10$7Y7gd82Srx1pXjPgJw14G.Or500tbM6MWeENnlH/wKTTjOxkQ/Cb6', 'admin', 'img/default.jpg', 0);

-- --------------------------------------------------------

--
-- Table structure for table `data_joki`
--

CREATE TABLE `data_joki` (
  `id` int(11) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `platform` enum('Moonton','Tiktok','Facebook') NOT NULL,
  `id_pengguna` varchar(50) NOT NULL,
  `catatan` text DEFAULT NULL,
  `paket` varchar(100) NOT NULL,
  `harga` int(11) NOT NULL,
  `metode_pembayaran` varchar(50) NOT NULL,
  `nominal_pembayaran` int(11) DEFAULT NULL,
  `nomor_whatsapp` varchar(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `tanggal_pesan` timestamp NOT NULL DEFAULT current_timestamp(),
  `invoice` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `data_joki`
--

INSERT INTO `data_joki` (`id`, `nickname`, `platform`, `id_pengguna`, `catatan`, `paket`, `harga`, `metode_pembayaran`, `nominal_pembayaran`, `nomor_whatsapp`, `status`, `tanggal_pesan`, `invoice`) VALUES
(58, '7713', 'Moonton', 'user', 'jshsfh', '2 Bintang Epic + (1 Bintang)', 7000, 'SALDO', NULL, '103701837', 'pending', '2025-06-15 13:29:36', 'INV01'),
(59, 'saya', 'Moonton', 'user', 'kk', '8 Bintang Epic + (2 Bintang)', 24000, 'SALDO', NULL, '109913', 'pending', '2025-06-15 13:35:08', 'INV02'),
(60, 'uyeu', 'Moonton', 'user', 'uyquh', '2 Bintang Epic + (1 Bintang)', 7000, 'BCA', NULL, '88174', 'pending', '2025-06-15 13:56:55', 'INV03'),
(61, 'iadiaf', 'Moonton', 'user', '183871', '2 Bintang Epic + (1 Bintang)', 7000, 'BNI', NULL, '9137913', 'pending', '2025-06-15 14:05:22', 'INV04'),
(62, 'u914', 'Tiktok', 'user', 'iruiu', '2 Bintang Epic + (1 Bintang)', 7000, 'BCA', NULL, '1974', 'pending', '2025-06-15 14:11:05', 'INV05'),
(63, 'qkej', 'Moonton', 'user', 'ajfjaf', '2 Bintang Epic + (1 Bintang)', 7000, 'BCA', NULL, '19414', 'pending', '2025-06-15 14:23:30', 'INV06'),
(64, '1ieu1u', 'Moonton', 'user', 'kfhh', '2 Bintang Epic + (1 Bintang)', 7000, 'BCA', NULL, '1938913', 'pending', '2025-06-15 14:27:10', 'INV07'),
(65, '12i912i', 'Moonton', 'user', 'jhdjhf', '2 Bintang Epic + (1 Bintang)', 7000, 'SALDO', NULL, '01330193', 'pending', '2025-06-15 14:42:35', 'INV08'),
(66, 'saya', 'Tiktok', 'user', 'kk', '2 Bintang Epic + (1 Bintang)', 7000, 'SALDO', NULL, '19913', 'pending', '2025-06-15 14:43:23', 'INV09'),
(67, 'oque', 'Tiktok', 'user', 'ksfihf', '2 Bintang Epic + (1 Bintang)', 7000, 'SALDO', NULL, '81738163', 'berhasil', '2025-06-15 14:44:32', 'INV10'),
(68, 'iajdidj', 'Moonton', 'user', 'ajdidja', '2 Bintang Epic + (1 Bintang)', 7000, 'SALDO', NULL, '918871', 'pending', '2025-06-15 14:45:59', 'INV11'),
(69, 'jqhdjh', 'Moonton', 'user', 'iqdiqud', '2 Bintang Epic + (1 Bintang)', 7000, 'BCA', NULL, '18787', 'pending', '2025-06-15 14:46:22', 'INV12');

--
-- Triggers `data_joki`
--
DELIMITER $$
CREATE TRIGGER `kurangi_saldo` AFTER INSERT ON `data_joki` FOR EACH ROW BEGIN
  IF NEW.metode_pembayaran = 'SALDO' THEN
    UPDATE akses 
    SET saldo = saldo - NEW.harga 
    WHERE username = NEW.id_pengguna;
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_cek_saldo_sebelum_pesan` BEFORE INSERT ON `data_joki` FOR EACH ROW BEGIN
  DECLARE saldo_pengguna INT;

  
  SELECT saldo INTO saldo_pengguna
  FROM akses
  WHERE username = NEW.id_pengguna;

  
  IF saldo_pengguna < NEW.harga THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Saldo tidak mencukupi untuk melakukan pemesanan.';
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hasil_pesanan`
--

CREATE TABLE `hasil_pesanan` (
  `id` int(11) NOT NULL,
  `invoice_id` varchar(10) NOT NULL,
  `user_id` varchar(10) NOT NULL,
  `nama_game` varchar(50) NOT NULL,
  `paket` varchar(50) NOT NULL,
  `harga` int(11) NOT NULL,
  `status` enum('Proses','Selesai','Batal') DEFAULT 'Proses',
  `tanggal_pemesanan` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hasil_pesanan`
--

INSERT INTO `hasil_pesanan` (`id`, `invoice_id`, `user_id`, `nama_game`, `paket`, `harga`, `status`, `tanggal_pemesanan`) VALUES
(1, 'NV01', '28323', 'Mobile Legends', '1 bintang', 20000, 'Proses', '2025-05-15'),
(2, 'NV02', '283223', 'Mobile Legends', '1 bintang', 20000, 'Selesai', '2025-05-15');

-- --------------------------------------------------------

--
-- Table structure for table `mutasi_saldo`
--

CREATE TABLE `mutasi_saldo` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tipe` enum('kredit','debit') NOT NULL,
  `jumlah` int(11) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mutasi_saldo`
--

INSERT INTO `mutasi_saldo` (`id`, `user_id`, `tipe`, `jumlah`, `keterangan`, `created_at`) VALUES
(1, 6, 'kredit', 2000, 'Isi saldo manual via form', '2025-06-01 20:32:54'),
(2, 6, 'kredit', 2000, 'Isi saldo manual via form', '2025-06-01 20:34:33'),
(3, 6, 'kredit', 2000, 'Isi saldo manual via form', '2025-06-04 19:06:03'),
(4, 6, 'kredit', 7000, 'Isi saldo manual via form', '2025-06-04 19:06:16'),
(5, 6, 'kredit', 20000, 'Isi saldo manual via form', '2025-06-15 07:21:09'),
(6, 6, 'kredit', 90000, 'Isi saldo manual via form', '2025-06-15 07:37:18'),
(7, 6, 'kredit', 20000, 'Isi saldo manual via form', '2025-06-15 14:17:32'),
(8, 6, 'kredit', 2000, 'Isi saldo manual via form', '2025-06-15 14:25:21'),
(9, 6, 'kredit', 20000, 'Isi saldo manual via form', '2025-06-15 15:48:32'),
(10, 6, 'kredit', 7000, 'Isi saldo manual via form', '2025-06-15 20:56:37'),
(11, 6, 'kredit', 10000, 'Isi saldo manual via form', '2025-06-15 21:42:15'),
(12, 6, 'kredit', 14000, 'Isi saldo manual via form', '2025-06-15 21:43:08'),
(13, 6, 'kredit', 20000, 'Isi saldo manual via form', '2025-06-15 21:44:16'),
(14, 6, 'kredit', 10000, 'Isi saldo manual via form', '2025-06-15 21:45:42');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` int(11) NOT NULL,
  `nama_produk` varchar(100) DEFAULT NULL,
  `layanan` varchar(100) DEFAULT NULL,
  `gambar` varchar(255) NOT NULL,
  `harga` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `nama_produk`, `layanan`, `gambar`, `harga`) VALUES
(2, 'Mobile Legends', '2 Bintang Epic + (1 Bintang)', 'uploads/1748734325_epik.webp', 7000),
(3, 'Mobile Legends', '8 Bintang Epic + (2 Bintang)', 'uploads/1748734534_epik.webp', 24000),
(4, 'Mobile Legends', '4 Bintang Legends + (1 Bintang)', 'uploads/1748734541_epik.webp', 16000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `ranking_produk`
-- (See below for the actual view)
--
CREATE TABLE `ranking_produk` (
`paket` varchar(100)
,`jumlah_pesanan` bigint(21)
,`peringkat` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `register`
--

CREATE TABLE `register` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure for view `ranking_produk`
--
DROP TABLE IF EXISTS `ranking_produk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ranking_produk`  AS SELECT `data_joki`.`paket` AS `paket`, count(0) AS `jumlah_pesanan`, rank() over ( order by count(0) desc) AS `peringkat` FROM `data_joki` WHERE `data_joki`.`status` = 'Selesai' GROUP BY `data_joki`.`paket` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akses`
--
ALTER TABLE `akses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_joki`
--
ALTER TABLE `data_joki`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hasil_pesanan`
--
ALTER TABLE `hasil_pesanan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mutasi_saldo`
--
ALTER TABLE `mutasi_saldo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `akses`
--
ALTER TABLE `akses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `data_joki`
--
ALTER TABLE `data_joki`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `hasil_pesanan`
--
ALTER TABLE `hasil_pesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mutasi_saldo`
--
ALTER TABLE `mutasi_saldo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `register`
--
ALTER TABLE `register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mutasi_saldo`
--
ALTER TABLE `mutasi_saldo`
  ADD CONSTRAINT `mutasi_saldo_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `akses` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
