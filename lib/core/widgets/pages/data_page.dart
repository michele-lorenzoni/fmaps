import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dati'),
      ),
      body: const Center(
        child: Text(
          'Sezione Dati - In costruzione',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}