import 'package:flutter/material.dart';
import 'package:tuluos_installer/models/disk_info.dart';
import 'package:tuluos_installer/providers/info_provider.dart';
import 'package:provider/provider.dart';

class EditPartitionForm extends StatefulWidget {
  const EditPartitionForm({super.key, required this.partition});

  final PartitionInfo partition;
  // final void Function(String selectedMountPoint, String selectedFormat)
  // onSubmitChanges;
  @override
  State<EditPartitionForm> createState() {
    return _EditPartitionFormState();
  }
}

class _EditPartitionFormState extends State<EditPartitionForm> {
  String? selectedMountPoint = mountPoints[0];
  late bool isFormat;

  void _submitChanges(InfoProvider infoProvider) {
    String selectedFormatInString = isFormat ? "Yes" : "No";
    if (selectedMountPoint != null) {
      // widget.onSubmitChanges(selectedMountPoint!, selectedFormatInString);
      infoProvider.changeMpandFormat(
          infoProvider.getCurrDisk!, infoProvider.getCurrPartition,
          mountPoints: [selectedMountPoint!], format: selectedFormatInString);
    }
  }

  @override
  void initState() {
    isFormat = widget.partition.partitionFormat == "Yes" ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);

    return AlertDialog(
      title: Text(infoProvider.systemDisks[infoProvider.getCurrDisk!]
          .parts[infoProvider.getCurrPartition].partitionName),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Text("Mount Point: "),
                DropdownButton(
                    value: selectedMountPoint,
                    items: mountPoints
                        .map((mp) =>
                            DropdownMenuItem(value: mp, child: Text(mp)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedMountPoint = value;
                        });
                      }
                    })
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text("Format the partition: "),
                Checkbox(
                    value: isFormat,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          isFormat = value;
                        });
                      }
                    })
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                    onPressed: () {
                      _submitChanges(infoProvider);
                      Navigator.pop(context);
                    },
                    child: const Text("Save"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
