-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 19, 2020 at 02:44 PM
-- Server version: 5.7.29-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sigupi`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id_booking` char(10) NOT NULL,
  `penanggung_jawab` varchar(100) NOT NULL,
  `id_user` char(7) NOT NULL,
  `id_ruangan` char(7) NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_berakhir` time NOT NULL,
  `tgl_booking` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tgl_penggunaan` date NOT NULL,
  `scan_ktm` blob NOT NULL,
  `scan_surat` blob NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `status_booking` enum('acc','belum','tidak') NOT NULL DEFAULT 'belum',
  `id_dosen` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `booking`
--
DELIMITER $$
CREATE TRIGGER `tg_booking_insert` BEFORE INSERT ON `booking` FOR EACH ROW BEGIN
  INSERT INTO booking_seq VALUES (NULL);
  SET NEW.id_booking = CONCAT('b', LPAD(LAST_INSERT_ID(), 9, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `direksi`
--

CREATE TABLE `direksi` (
  `id_direksi` char(5) NOT NULL,
  `nama_direksi` varchar(100) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `no_telp` char(15) NOT NULL,
  `jabatan` varchar(75) NOT NULL,
  `id_instansi` char(4) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `type` enum('admin','staff') NOT NULL DEFAULT 'admin',
  `des_direksi` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `direksi`
--
DELIMITER $$
CREATE TRIGGER `tg_direksi_insert` BEFORE INSERT ON `direksi` FOR EACH ROW BEGIN
  INSERT INTO direksi_seq VALUES (NULL);
  SET NEW.id_direksi = CONCAT('a', LPAD(LAST_INSERT_ID(), 4, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` varchar(5) NOT NULL,
  `nama_dosen` varchar(100) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_jurusan` char(5) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `des_dosen` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `dosen`
--
DELIMITER $$
CREATE TRIGGER `tg_dosen_insert` BEFORE INSERT ON `dosen` FOR EACH ROW BEGIN
  INSERT INTO dosen_seq VALUES (NULL);
  SET NEW.id_dosen = CONCAT('d', LPAD(LAST_INSERT_ID(), 4, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `fasilitas_ruangan`
--

CREATE TABLE `fasilitas_ruangan` (
  `id_fasilitas` char(9) NOT NULL,
  `nama_fasilitas` varchar(75) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `id_ruangan` char(7) NOT NULL,
  `des_fasilitas` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `fasilitas_ruangan`
--
DELIMITER $$
CREATE TRIGGER `tg_fasilitas_insert` BEFORE INSERT ON `fasilitas_ruangan` FOR EACH ROW BEGIN
  INSERT INTO fasilitas_ruangan_seq VALUES (NULL);
  SET NEW.id_fasilitas = CONCAT('f', LPAD(LAST_INSERT_ID(), 8, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `gedung`
--

CREATE TABLE `gedung` (
  `id_gedung` char(6) NOT NULL,
  `nama_gedung` varchar(75) NOT NULL,
  `id_instansi` varchar(4) NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `gambar_gedung` blob NOT NULL,
  `des_gedung` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `gedung`
--
DELIMITER $$
CREATE TRIGGER `tg_gedung_insert` BEFORE INSERT ON `gedung` FOR EACH ROW BEGIN
  INSERT INTO gedung_seq VALUES (NULL);
  SET NEW.id_gedung = CONCAT('g', LPAD(LAST_INSERT_ID(), 5, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `instansi`
--

CREATE TABLE `instansi` (
  `id_instansi` char(4) NOT NULL,
  `nama_instansi` varchar(150) NOT NULL,
  `alamat_instansi` varchar(175) NOT NULL,
  `no_telp` char(15) NOT NULL,
  `visi` varchar(255) NOT NULL,
  `misi` text NOT NULL,
  `sejarah` text NOT NULL,
  `logo_instansi` blob NOT NULL,
  `status_instansi` enum('aktif','tidak_aktif') NOT NULL DEFAULT 'tidak_aktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `instansi`
--
DELIMITER $$
CREATE TRIGGER `tg_instansi_insert` BEFORE INSERT ON `instansi` FOR EACH ROW BEGIN
  INSERT INTO instansi_seq VALUES (NULL);
  SET NEW.id_instansi = CONCAT('i', LPAD(LAST_INSERT_ID(), 3, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `jadwal`
--

CREATE TABLE `jadwal` (
  `id_jadwal` char(11) NOT NULL,
  `jam_mulai` time NOT NULL,
  `jam_selesai` time NOT NULL,
  `id_ruangan` char(7) NOT NULL,
  `hari` enum('senin','selasa','rabu','kamis','jumat') NOT NULL,
  `id_matkul` char(6) NOT NULL,
  `id_kelas` char(7) NOT NULL,
  `des_jadwal` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `jadwal`
--
DELIMITER $$
CREATE TRIGGER `tg_jadwal_insert` BEFORE INSERT ON `jadwal` FOR EACH ROW BEGIN
  INSERT INTO jadwal_seq VALUES (NULL);
  SET NEW.id_jadwal = CONCAT('j', LPAD(LAST_INSERT_ID(), 10, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE `jurusan` (
  `id_jurusan` char(5) NOT NULL,
  `type` enum('jurusan','ormawa','ukm') NOT NULL,
  `nama_jurusan` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `jurusan`
--
DELIMITER $$
CREATE TRIGGER `tg_jurusan_insert` BEFORE INSERT ON `jurusan` FOR EACH ROW BEGIN
  INSERT INTO jurusan_seq VALUES (NULL);
  SET NEW.id_jurusan = CONCAT('p', LPAD(LAST_INSERT_ID(), 4, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` char(7) NOT NULL,
  `nama_kelas` varchar(255) NOT NULL,
  `angkatan` year(4) NOT NULL,
  `id_jurusan` char(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `kelas`
--
DELIMITER $$
CREATE TRIGGER `tg_kelas_insert` BEFORE INSERT ON `kelas` FOR EACH ROW BEGIN
  INSERT INTO kelas_seq VALUES (NULL);
  SET NEW.id_kelas = CONCAT('k', LPAD(LAST_INSERT_ID(), 6, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `masukan`
--

CREATE TABLE `masukan` (
  `id_masukan` char(8) NOT NULL,
  `id_user` char(7) NOT NULL,
  `id_instansi` char(4) NOT NULL,
  `masukan` varchar(100) NOT NULL,
  `bukti_foto` blob NOT NULL,
  `des_masukan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `masukan`
--
DELIMITER $$
CREATE TRIGGER `tg_masukan_insert` BEFORE INSERT ON `masukan` FOR EACH ROW BEGIN
  INSERT INTO masukan_seq VALUES (NULL);
  SET NEW.id_masukan = CONCAT('m', LPAD(LAST_INSERT_ID(), 7, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `id_matkul` char(6) NOT NULL,
  `nama_matkul` varchar(75) NOT NULL,
  `id_dosen` char(5) NOT NULL,
  `id_jurusan` char(5) NOT NULL,
  `jumlah_sks` int(2) NOT NULL,
  `des_matkul` varchar(175) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `mata_kuliah`
--
DELIMITER $$
CREATE TRIGGER `tg_matkul_insert` BEFORE INSERT ON `mata_kuliah` FOR EACH ROW BEGIN
  INSERT INTO mata_kuliah_seq VALUES (NULL);
  SET NEW.id_matkul = CONCAT('c', LPAD(LAST_INSERT_ID(), 5, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `id_ruangan` char(7) NOT NULL,
  `nama_ruangan` varchar(75) NOT NULL,
  `kapasitas` int(5) NOT NULL,
  `gambar_ruangan` blob NOT NULL,
  `id_gedung` char(6) NOT NULL,
  `des_ruangan` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `ruangan`
--
DELIMITER $$
CREATE TRIGGER `tg_ruangan_insert` BEFORE INSERT ON `ruangan` FOR EACH ROW BEGIN
  INSERT INTO ruangan_seq VALUES (NULL);
  SET NEW.id_ruangan = CONCAT('r', LPAD(LAST_INSERT_ID(), 6, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` char(7) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_kelas` char(7) NOT NULL,
  `status_user` enum('aktif','tidak') NOT NULL DEFAULT 'aktif',
  `des_user` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `tg_user_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
  INSERT INTO user_seq VALUES (NULL);
  SET NEW.id_user = CONCAT('u', LPAD(LAST_INSERT_ID(), 6, '0'));
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_ruangan` (`id_ruangan`),
  ADD KEY `id_dosen` (`id_dosen`);

--
-- Indexes for table `direksi`
--
ALTER TABLE `direksi`
  ADD PRIMARY KEY (`id_direksi`),
  ADD KEY `id_instansi` (`id_instansi`);

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`),
  ADD KEY `id_jurusan` (`id_jurusan`);

--
-- Indexes for table `fasilitas_ruangan`
--
ALTER TABLE `fasilitas_ruangan`
  ADD PRIMARY KEY (`id_fasilitas`),
  ADD KEY `id_ruangan` (`id_ruangan`);

--
-- Indexes for table `gedung`
--
ALTER TABLE `gedung`
  ADD PRIMARY KEY (`id_gedung`),
  ADD KEY `id_instansi` (`id_instansi`);

--
-- Indexes for table `instansi`
--
ALTER TABLE `instansi`
  ADD PRIMARY KEY (`id_instansi`);

--
-- Indexes for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD PRIMARY KEY (`id_jadwal`),
  ADD KEY `id_kelas` (`id_kelas`),
  ADD KEY `id_matkul` (`id_matkul`),
  ADD KEY `id_ruangan` (`id_ruangan`);

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id_jurusan`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `id_jurusan` (`id_jurusan`);

--
-- Indexes for table `masukan`
--
ALTER TABLE `masukan`
  ADD PRIMARY KEY (`id_masukan`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_instansi` (`id_instansi`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`id_matkul`),
  ADD KEY `id_dosen` (`id_dosen`),
  ADD KEY `id_jurusan` (`id_jurusan`);

--
-- Indexes for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`id_ruangan`),
  ADD KEY `id_gedung` (`id_gedung`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_kelas` (`id_kelas`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`),
  ADD CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`);

--
-- Constraints for table `direksi`
--
ALTER TABLE `direksi`
  ADD CONSTRAINT `direksi_ibfk_1` FOREIGN KEY (`id_instansi`) REFERENCES `instansi` (`id_instansi`);

--
-- Constraints for table `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan` (`id_jurusan`);

--
-- Constraints for table `fasilitas_ruangan`
--
ALTER TABLE `fasilitas_ruangan`
  ADD CONSTRAINT `fasilitas_ruangan_ibfk_1` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`);

--
-- Constraints for table `gedung`
--
ALTER TABLE `gedung`
  ADD CONSTRAINT `gedung_ibfk_1` FOREIGN KEY (`id_instansi`) REFERENCES `instansi` (`id_instansi`);

--
-- Constraints for table `jadwal`
--
ALTER TABLE `jadwal`
  ADD CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`),
  ADD CONSTRAINT `jadwal_ibfk_2` FOREIGN KEY (`id_matkul`) REFERENCES `mata_kuliah` (`id_matkul`),
  ADD CONSTRAINT `jadwal_ibfk_3` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`);

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_ibfk_1` FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan` (`id_jurusan`);

--
-- Constraints for table `masukan`
--
ALTER TABLE `masukan`
  ADD CONSTRAINT `masukan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  ADD CONSTRAINT `masukan_ibfk_2` FOREIGN KEY (`id_instansi`) REFERENCES `instansi` (`id_instansi`);

--
-- Constraints for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD CONSTRAINT `mata_kuliah_ibfk_1` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`),
  ADD CONSTRAINT `mata_kuliah_ibfk_2` FOREIGN KEY (`id_jurusan`) REFERENCES `jurusan` (`id_jurusan`);

--
-- Constraints for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD CONSTRAINT `ruangan_ibfk_1` FOREIGN KEY (`id_gedung`) REFERENCES `gedung` (`id_gedung`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
