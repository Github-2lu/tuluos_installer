import 'package:flutter/material.dart';
import 'package:tuluos_installer/models/disk_info.dart';
import 'package:tuluos_installer/providers/info_provider.dart';
import 'package:provider/provider.dart';

class PartitionDatatable extends StatefulWidget {
  const PartitionDatatable({super.key, required this.partitions});

  final List<PartitionInfo> partitions;
  // final void Function(int partitionIndex) onSelectPartition;
  // final int selectedIndex;
  @override
  State<PartitionDatatable> createState() {
    return _PartitionDatatable();
  }
}

class _PartitionDatatable extends State<PartitionDatatable> {
  // int selectedIndex = -1;
  String? selectedMountPoint;

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    return SingleChildScrollView(
      child: DataTable(
          onSelectAll: (val) {
            infoProvider.setCurrPartition = -1;
            // widget.onSelectPartition(infoProvider.getCurrPartition);
          },
          columns: partitionLabels
              .map((label) => DataColumn(label: Text(label)))
              .toList(),
          rows: [
            for (int i = 0; i < widget.partitions.length; i++)
              DataRow(
                selected: infoProvider.getCurrPartition == i,
                onSelectChanged: (val) {
                  setState(() {
                    if (val == true) {
                      infoProvider.setCurrPartition = i;
                    } else {
                      infoProvider.setCurrPartition = -1;
                    }
                  });
                  // widget.onSelectPartition(infoProvider.getCurrPartition);
                },
                cells: [
                  DataCell(Text(widget.partitions[i].partitionName)),
                  DataCell(Text(widget.partitions[i].partitionType)),
                  DataCell(Text(widget.partitions[i].partitionMountpt.toString())),
                  DataCell(Text(widget.partitions[i].partitionSize)),
                  DataCell(Text(widget.partitions[i].partitionFormat))
                ],
              )
          ]),
    );
  }
}
