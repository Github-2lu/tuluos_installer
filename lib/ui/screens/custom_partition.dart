import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:tuluos_installer/models/disk_info.dart';
import 'package:tuluos_installer/providers/info_provider.dart';
import 'package:tuluos_installer/ui/widgets/edit_partition_form.dart';
import 'package:tuluos_installer/ui/widgets/partition_datatable.dart';
import 'package:tuluos_installer/ui/screens/timezone_locale.dart';

class CustomPartitionScreen extends StatefulWidget {
  const CustomPartitionScreen({super.key});
  @override
  State<CustomPartitionScreen> createState() {
    return _CustomPartitionScreenState();
  }
}

class _CustomPartitionScreenState extends State<CustomPartitionScreen> {
  Future<List<DiskInfo>> _getDiskInfo() async {
    List<DiskInfo> disksInfo = [];
    String disks = "";
    await Process.run("lsblk", ["-o", "name,fstype,size,mountpoints", "-J"])
        .then((value) => disks = value.stdout.toString());
    var disksJson = json.decode(disks);
    for (final disk in disksJson["blockdevices"]) {
      disksInfo.add(DiskInfo.fromJson(disk));
    }

    return disksInfo;
  }

  void _openPartitionManager() async {
    await Process.run("partitionmanager", []);
  }

  void _showEditPartition(InfoProvider provider) async {
    if (provider.getCurrPartition != -1) {
      await showDialog(
          context: context,
          builder: (ctx) => EditPartitionForm(
                partition: provider.systemDisks[provider.getCurrDisk!]
                    .parts[provider.getCurrPartition],
              ));
    }
  }

  Widget _showDiskUi() {
    return Consumer<InfoProvider>(
      builder: (context, provider, _) {
        return Column(
          children: [
            Row(
              children: [
                const Text('efi'),
                const Spacer(),
                const Text("Seleceted Disk: "),
                const SizedBox(
                  width: 15,
                ),
                DropdownButton(
                    value: provider.getCurrDisk,
                    items: [
                      for (int i = 0; i < provider.systemDisks.length; i++)
                        DropdownMenuItem(
                            value: i, child: Text(provider.systemDisks[i].disk))
                    ],
                    onChanged: (selectedDisk) {
                      setState(() {
                        provider.setCurrDisk = selectedDisk;
                      });
                    }),
                const Spacer(),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.black, width: 2)),
              child: PartitionDatatable(
                partitions: provider.systemDisks[provider.getCurrDisk!].parts,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _showEditPartition(provider);
                    },
                    child: const Text("Edit")),
                ElevatedButton(
                    onPressed: _openPartitionManager,
                    child: const Text("Open Partition Manager")),
                ElevatedButton(
                    onPressed: () {
                      _getDiskInfo().then((value) {
                        provider.changeDisksInfo(value);
                        provider.setCurrPartition = -1;
                      });
                    },
                    child: const Text("Refresh"))
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partition Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _showDiskUi(),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Prev")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => const TimeZoneLocaleScreen()));
            },
            child: const Text("Next"))
      ],
    );
  }
}
