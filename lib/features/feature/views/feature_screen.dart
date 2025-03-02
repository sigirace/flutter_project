import 'package:flutter/material.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Screen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Feature Screen'),
      ),
    );
  }
}
