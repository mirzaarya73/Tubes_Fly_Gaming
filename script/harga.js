function updatePaymentAmount(harga, paket) {
    const hargaInput = document.getElementById("harga_terpilih");
    const paketInput = document.getElementById("paket_terpilih");
    const totalBayar = document.getElementById("total-bayar");

    if (hargaInput) hargaInput.value = harga;
    if (paketInput) paketInput.value = paket;

    // Format harga sebagai Rupiah
    const formattedHarga = new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0
    }).format(harga);

    if (totalBayar) {
        totalBayar.textContent = 'Total Bayar : ' + formattedHarga;
    }

    // Highlight tombol harga yang diklik
    const allButtons = document.querySelectorAll('.price');
    allButtons.forEach(btn => btn.classList.remove('active'));

    event.target.classList.add('active');
}
