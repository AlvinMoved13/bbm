import 'package:flutter/material.dart';

const List<String> listBahanBakar = <String>[
  'Pertalite : Rp.7000/liter ',
  'Pertamax : Rp.14,000/liter',
  'Solar : Rp.10,000/liter'
];

const List<String> listKendaraan = <String>[
  'Avanza 1:5',
  'Xenia 1:6',
  'Sigra 1:5',
  'Brio 1:6'
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Pertamina',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Penghitung Konsumsi BBM'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String selectedFuel = listBahanBakar[0];
  String selectedVehicle = listKendaraan[0];
  double distance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Kalkulator BBM',
            ),
            ListTile(
              title: TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Kota Tujuan'),
              ),
            ),
            Row(
              children: [
                ListTile(
                  title: TextField(
                    controller: contentController,
                    decoration: const InputDecoration(
                        labelText: 'Jarak (dalam kilometer)'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedFuel,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFuel = newValue!;
                    });
                  },
                  items: listBahanBakar.map((String fuel) {
                    return DropdownMenuItem<String>(
                      value: fuel,
                      child: Text(fuel),
                    );
                  }).toList(),
                ),
              ],
            ),
            DropdownButton<String>(
              value: selectedVehicle,
              onChanged: (String? newValue) {
                setState(() {
                  selectedVehicle = newValue!;
                });
              },
              items: listKendaraan.map((String vehicle) {
                return DropdownMenuItem<String>(
                  value: vehicle,
                  child: Text(vehicle),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                double fuelRatio =
                    double.parse(selectedVehicle.split(' ')[1].split(':')[1]);
                double fuelPrice = double.parse(selectedFuel
                    .split('Rp.')[1]
                    .split('/')[0]
                    .replaceAll(',', ''));
                double totalFuelCost = (distance / fuelRatio) * fuelPrice;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Hasil Perhitungan'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kota Tujuan: ${titleController.text}'),
                          Text('Jarak: ${contentController.text} Kilometer'),
                          Text('Kendaraan: $selectedVehicle'),
                          Text('Bahan Bakar: $selectedFuel'),
                          Text(
                              'Total Biaya BBM: Rp.${totalFuelCost.toStringAsFixed(2)}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Hitung'),
            ),
          ],
        ),
      ),
    );
  }
}
