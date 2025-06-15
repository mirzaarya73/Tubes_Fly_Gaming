<?php
include 'koneksi.php';
session_start();

// Aktifkan error reporting untuk debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Validasi input penting
if (
    !isset($_POST['id_pengguna']) ||
    !isset($_POST['platform']) ||
    !isset($_POST['harga']) ||
    !isset($_POST['layanan']) ||
    !isset($_POST['metode_pembayaran']) ||
    !isset($_POST['nomor_whatsapp'])
) {
    echo "<script>alert('Data tidak lengkap.'); window.history.back();</script>";
    exit;
}

// Ambil dan amankan input
$id_pengguna      = mysqli_real_escape_string($koneksi, $_POST['id_pengguna']);
$nickname         = mysqli_real_escape_string($koneksi, $_POST['nickname']);
$platform         = mysqli_real_escape_string($koneksi, $_POST['platform']);
$catatan          = mysqli_real_escape_string($koneksi, $_POST['catatan']);
$harga            = (int) $_POST['harga'];
$paket            = mysqli_real_escape_string($koneksi, $_POST['layanan']);
$metode           = strtoupper(mysqli_real_escape_string($koneksi, $_POST['metode_pembayaran']));
$nomor_whatsapp   = mysqli_real_escape_string($koneksi, $_POST['nomor_whatsapp']);
$status           = "pending";

// Buat invoice baru
$query_invoice = "SELECT invoice FROM data_joki ORDER BY id DESC LIMIT 1";
$result_invoice = mysqli_query($koneksi, $query_invoice);
$lastinvoice = "INV00";
if ($row = mysqli_fetch_assoc($result_invoice)) {
    $lastinvoice = $row['invoice'];
}
$number = (int) substr($lastinvoice, 3);
$number++;
$newinvoice = "INV" . str_pad($number, 2, '0', STR_PAD_LEFT);

try {
    // Jika metode SALDO, lakukan pengecekan saldo terlebih dahulu
    if ($metode === 'SALDO') {
        $cek_saldo = mysqli_query($koneksi, "SELECT saldo FROM akses WHERE username = '$id_pengguna'");
        $data_saldo = mysqli_fetch_assoc($cek_saldo);

        if (!$data_saldo) {
            echo "<script>alert('Pengguna tidak ditemukan.'); window.history.back();</script>";
            exit;
        }

        if ($data_saldo['saldo'] < $harga) {
            echo "<script>alert('Saldo tidak mencukupi. Silakan isi ulang terlebih dahulu.'); window.location.href='form-pemesanan.php';</script>";
            exit;
        }
    }

    // Simpan data pemesanan
    $query = "INSERT INTO data_joki (
        id_pengguna, nickname, platform, catatan, paket, harga, metode_pembayaran, nomor_whatsapp, status, invoice
    ) VALUES (
        '$id_pengguna', '$nickname', '$platform', '$catatan', '$paket', $harga, '$metode', '$nomor_whatsapp', '$status', '$newinvoice'
    )";

    mysqli_query($koneksi, $query);

    // Jika bukan saldo, maka arahkan ke halaman instruksi transfer bank
    if ($metode !== 'SALDO') {
        echo "<script>alert('Silakan transfer ke rekening: 1847147 a.n Admin FlyGaming'); window.location.href='invoice.php?kode=$newinvoice';</script>";
    } else {
        echo "<script>alert('Pembayaran berhasil menggunakan saldo!'); window.location.href='invoice.php?kode=$newinvoice';</script>";
    }

} catch (mysqli_sql_exception $e) {
    $pesan = $e->getMessage();
    echo "<script>alert('Terjadi kesalahan saat memproses pesanan: " . addslashes($pesan) . "'); window.history.back();</script>";
}
?>
