import 'package:flutter/material.dart';

class AllData extends StatefulWidget {
  const AllData({super.key});

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetching Data from Internet'),
      ),
      body: const Center(
        child: Listview(
          chi
        ),
      ),
    );
  }
}