import 'package:flutter/material.dart';
import 'package:flutter_warnet/entry_form.dart';
import 'package:flutter_warnet/pelanggan.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warnet Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: EntryForm(),
    );
  }
}

class ResultsDisplay extends StatelessWidget {
  final Warnet warnet;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final DateFormat _timeFormat = DateFormat('HH:mm');
  final NumberFormat _currencyFormat =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  ResultsDisplay({required this.warnet});

  @override
  Widget build(BuildContext context) {
    final lamaWaktu = warnet.getLamaWaktu();
    final diskonPercentage = warnet.getDiskonPercentage();
    final jumlahDiskon = warnet.getJumlahDiskon();
    final totalBayar = warnet.calculateTotalBayar();

    return Scaffold(
      appBar: AppBar(title: Text('Hasil Perhitungan')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode Pelanggan: ${warnet.pelanggan.kodePelanggan}'),
            Text('Nama Pelanggan: ${warnet.pelanggan.namaPelanggan}'),
            Text('Jenis Pelanggan: ${warnet.pelanggan.jenisPelanggan}'),
            Text('Tanggal Masuk: ${_dateFormat.format(warnet.tglMasuk)}'),
            Text('Jam Masuk: ${_timeFormat.format(warnet.jamMasuk)}'),
            Text('Jam Keluar: ${_timeFormat.format(warnet.jamKeluar)}'),
            SizedBox(height: 20),
            Text('Rincian Biaya:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Tarif per Jam: ${_currencyFormat.format(warnet.tarif)}'),
            Text('Lama Waktu: $lamaWaktu jam'),
            Text('Diskon: ${(diskonPercentage * 100).toStringAsFixed(0)}%'),
            Text('Jumlah Diskon: ${_currencyFormat.format(jumlahDiskon)}'),
            SizedBox(height: 10),
            Text('Total Bayar: ${_currencyFormat.format(totalBayar)}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
