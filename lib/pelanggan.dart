class Pelanggan {
  String kodePelanggan;
  String namaPelanggan;
  String jenisPelanggan;

  Pelanggan({
    required this.kodePelanggan,
    required this.namaPelanggan,
    required this.jenisPelanggan,
  });
}

class Warnet {
  Pelanggan pelanggan;
  DateTime tglMasuk;
  DateTime jamMasuk;
  DateTime jamKeluar;
  double tarif;

  Warnet({
    required this.pelanggan,
    required this.tglMasuk,
    required this.jamMasuk,
    required this.jamKeluar,
    this.tarif = 10000,
  });

  int getLamaWaktu() {
    final masuk = DateTime(tglMasuk.year, tglMasuk.month, tglMasuk.day,
        jamMasuk.hour, jamMasuk.minute);
    final keluar = DateTime(tglMasuk.year, tglMasuk.month, tglMasuk.day,
        jamKeluar.hour, jamKeluar.minute);

    if (keluar.isBefore(masuk)) {
      return keluar.add(Duration(days: 1)).difference(masuk).inHours;
    }
    return keluar.difference(masuk).inHours;
  }

  double getDiskonPercentage() {
    final lama = getLamaWaktu();
    if (pelanggan.jenisPelanggan == "VIP" && lama > 2) {
      return 0.02; // 2% discount
    } else if (pelanggan.jenisPelanggan == "GOLD" && lama > 2) {
      return 0.05; // 5% discount
    }
    return 0;
  }

  double getJumlahDiskon() {
    final lama = getLamaWaktu();
    final totalTarif = lama * tarif;
    return totalTarif * getDiskonPercentage();
  }

  double calculateTotalBayar() {
    final lama = getLamaWaktu();
    final totalTarif = lama * tarif;
    final diskon = getJumlahDiskon();
    return totalTarif - diskon;
  }
}
