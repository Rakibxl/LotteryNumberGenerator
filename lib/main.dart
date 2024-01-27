import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated Numbers App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GeneratedNumbersPage(),
    );
  }
}

class GeneratedNumbersPage extends StatefulWidget {
  const GeneratedNumbersPage({super.key});

  @override
  State<GeneratedNumbersPage> createState() => _GeneratedNumbersPageState();
}

class _GeneratedNumbersPageState extends State<GeneratedNumbersPage> {
  final _random = Random();
  int _numbersCount = 5;
  int _maxNumber = 45;
  int _numberOfSets = 3;
  List<List<int>> _generatedSets = [];

  String _generatedNumbersLabel = '';

  final _numbersCountController = TextEditingController();
  final _maxNumberController = TextEditingController();
  final _numberOfSetsController = TextEditingController();

  void _generateNumbers() {
  // Validating input values before generating output
  final parsedNumbersCount = int.tryParse(_numbersCountController.text);
  if (parsedNumbersCount == null || parsedNumbersCount < 1 || parsedNumbersCount > 6) {
    _showErrorDialog('Numbers count must be between 1 and 6');
    return;
  }

  final parsedMaxNumber = int.tryParse(_maxNumberController.text);
  if (parsedMaxNumber == null || parsedMaxNumber < 1 || parsedMaxNumber > 100) {
    _showErrorDialog('Max number must be between 1 and 100');
    return;
  }

  final parsedNumberOfSets = int.tryParse(_numberOfSetsController.text);
  if (parsedNumberOfSets == null || parsedNumberOfSets < 1 || parsedNumberOfSets > 5) {
    _showErrorDialog('Number of sets must be between 1 and 5');
    return;
  }

  setState(() {
    _numbersCount = parsedNumbersCount;
    _maxNumber = parsedMaxNumber;
    _numberOfSets = parsedNumberOfSets;

    _generatedSets = List.generate(_numberOfSets, (_) {
      final numbersSet = <int>{};
      while (numbersSet.length < _numbersCount) {
        final randomNumber = _random.nextInt(_maxNumber) + 1;
        numbersSet.add(randomNumber);
      }
      return numbersSet.toList()..sort();
    });
    _generatedNumbersLabel = 'Generated Numbers ($_numbersCount out of $_maxNumber)';
  });
}

 void _showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Invalid Input'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text('Okay'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}


@override
  void dispose() {
    _numbersCountController.dispose();
    _maxNumberController.dispose();
    _numberOfSetsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottery Number Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Numbers Count (1...6)',
                border: const OutlineInputBorder(),
                hintText: '5',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _numbersCount = int.tryParse(value) ?? 5,
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Max number (1...100)',
                border: const OutlineInputBorder(),
                hintText: '45',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _maxNumber = int.tryParse(value) ?? 45,
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Number of sets (1...5)',
                border: const OutlineInputBorder(),
                hintText: '3',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _numberOfSets = int.tryParse(value) ?? 3,
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _generateNumbers,
              child: const Text('Generate'),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _generatedSets.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.yellowAccent,
                    child: ListTile(
                      title: Text('Set ${index + 1}: ${_generatedSets[index].join(', ')}'),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: Colors.lightGreenAccent,
              child: ListTile(
                title: const Text('Rakib Ahmed\n301343511'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
  