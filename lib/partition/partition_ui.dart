import 'package:flutter/material.dart';
import 'package:tuluos_installer/partition/model/disk_info.dart';

class PartitionUi extends StatelessWidget {
  PartitionUi({super.key});
  final disks = [
    DiskInfo(disk: 'sda', parts: ['sda1', 'sda2']),
    DiskInfo(disk: 'vda', parts: ['vda1', 'vda2', 'vda3'])
  ];
  final parts = ['vda1', 'vda2'];
  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: disks.map(showdisk).toList());
    // return ExpansionTile(title: Text('hello'), children: disks[0].parts.map(showparts).toList(),);
    // return ListView(
    //   children: [
    //     ExpansionTile(
    //       title: Text('hello'),
    //       children: [
    //         ListTile(
    //           title: Text('sudip'),
    //         )
    //       ],
    //     )
    //   ],
    // );
    return ListView.builder(
      itemCount: disks.length,
      itemBuilder: (context, index) => ExpansionTile(
        title: Text(disks[index].disk),
        // children: disks[index].parts.map(showparts).toList(),
        children: _disk_parts_show(disks[index], index),
      ),
    );
  }
}

Widget showdisk(DiskInfo disk) {
  return ExpansionTile(
      title: Text(disk.disk), children: disk.parts.map(showparts).toList());
}

Widget showparts(String part) {
  return ListTile(
    title: Text(part),
  );
}

List<Widget> _disk_parts_show(DiskInfo disk, int index) {
  return List.generate(disk.parts.length, (index) {
    return ListTile(
      title: Text(disk.parts[index]),
      onTap: () {
        print('$index');
      },
    );
  });
}
