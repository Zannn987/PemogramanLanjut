import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'pelanggan.dart';
import 'main.dart';

class EntryForm extends StatefulWidget {
  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();
  late Pelanggan _pelanggan;
  late Warnet _warnet;

  final _dateFormat = DateFormat('dd/MM/yyyy');
  final _timeFormat = DateFormat('HH:mm');

  TextEditingController _kodePelangganController = TextEditingController();
  TextEditingController _namaPelangganController = TextEditingController();
  TextEditingController _tglMasukController = TextEditingController();
  TextEditingController _jamMasukController = TextEditingController();
  TextEditingController _jamKeluarController = TextEditingController();

  String _jenisPelanggan = 'Regular';

  @override
  void initState() {
    super.initState();
    _pelanggan = Pelanggan(
      kodePelanggan: '',
      namaPelanggan: '',
      jenisPelanggan: _jenisPelanggan,
    );
    _warnet = Warnet(
      pelanggan: _pelanggan,
      tglMasuk: DateTime.now(),
      jamMasuk: DateTime.now(),
      jamKeluar: DateTime.now().add(Duration(hours: 1)),
    );
    _tglMasukController.text = _dateFormat.format(_warnet.tglMasuk);
    _jamMasukController.text = _timeFormat.format(_warnet.jamMasuk);
    _jamKeluarController.text = _timeFormat.format(_warnet.jamKeluar);
  }

  void _updateWarnetData() {
    try {
      _warnet.tglMasuk = _dateFormat.parse(_tglMasukController.text);
      _warnet.jamMasuk = _timeFormat.parse(_jamMasukController.text);
      _warnet.jamKeluar = _timeFormat.parse(_jamKeluarController.text);
    } catch (e) {
      print('Error parsing date or time: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entry Form')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _kodePelangganController,
                decoration: InputDecoration(labelText: 'Kode Pelanggan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a code';
                  }
                  return null;
                },
                onSaved: (value) => _pelanggan.kodePelanggan = value!,
              ),
              TextFormField(
                controller: _namaPelangganController,
                decoration: InputDecoration(labelText: 'Nama Pelanggan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => _pelanggan.namaPelanggan = value!,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Jenis Pelanggan'),
                value: _jenisPelanggan,
                items: ['Regular', 'VIP', 'GOLD'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _jenisPelanggan = value!;
                    _pelanggan.jenisPelanggan = value;
                  });
                },
              ),
              TextFormField(
                controller: _tglMasukController,
                decoration:
                    InputDecoration(labelText: 'Tanggal Masuk (dd/MM/yyyy)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  try {
                    _dateFormat.parse(value);
                  } catch (e) {
                    return 'Invalid date format';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jamMasukController,
                decoration: InputDecoration(labelText: 'Jam Masuk (HH:mm)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time';
                  }
                  try {
                    _timeFormat.parse(value);
                  } catch (e) {
                    return 'Invalid time format';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jamKeluarController,
                decoration: InputDecoration(labelText: 'Jam Keluar (HH:mm)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time';
                  }
                  try {
                    _timeFormat.parse(value);
                  } catch (e) {
                    return 'Invalid time format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _updateWarnetData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ResultsDisplay(warnet: _warnet)),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
