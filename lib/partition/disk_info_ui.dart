import 'package:flutter/material.dart';

class DiskInfoUi extends StatelessWidget{
  const DiskInfoUi(this.disk, {super.key});

  final Map disk;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: disk['partitions']!.length, itemBuilder: (context, index) => const Text('hello'));
  }
}