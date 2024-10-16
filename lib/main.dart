import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String selectedConversion = 'F to C';
  final TextEditingController _temperatureController = TextEditingController();
  String result = '';
  List<String> history = [];

  void convertTemperature() {
    double inputTemp = double.tryParse(_temperatureController.text) ?? 0.0;
    double convertedTemp;

    if (selectedConversion == 'F to C') {
      convertedTemp = (inputTemp - 32) * 5 / 9;
      result =
          '${inputTemp.toStringAsFixed(1)} °F => ${convertedTemp.toStringAsFixed(2)} °C';
    } else {
      convertedTemp = (inputTemp * 9 / 5) + 32;
      result =
          '${inputTemp.toStringAsFixed(1)} °C => ${convertedTemp.toStringAsFixed(2)} °F';
    }

    setState(() {
      history.add(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'F to C',
                  groupValue: selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      selectedConversion = value!;
                      result = ''; // Reset result when changing conversion type
                    });
                  },
                ),
                const Text('Fahrenheit to Celsius'),
                Radio<String>(
                  value: 'C to F',
                  groupValue: selectedConversion,
                  onChanged: (value) {
                    setState(() {
                      selectedConversion = value!;
                      result = ''; // Reset result when changing conversion type
                    });
                  },
                ),
                const Text('Celsius to Fahrenheit'),
              ],
            ),
            TextField(
              controller: _temperatureController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter Temperature'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertTemperature,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const Text(
              'History:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
