import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuluos_installer/providers/info_provider.dart';
import 'package:tuluos_installer/ui/screens/install.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  Widget summaryUi() {
    return Consumer<InfoProvider>(
      builder: (context, provider, _) {
        Map<String, Map<String, String>> getbootPartiionInfo() {
          Map<String, Map<String, String>> partitions = {};
          for (final disk in provider.systemDisks) {
            for (final part in disk.parts) {
              if (part.partitionMountpt.contains("/boot/efi")) {
                partitions["efiPartition"] = {
                  "disk": disk.disk,
                  "partition": part.partitionName,
                  "isFormat": part.partitionFormat
                };
              } else if (part.partitionMountpt.contains("/")) {
                partitions["rootPartition"] = {
                  "disk": disk.disk,
                  "partition": part.partitionName,
                  "isFormat": part.partitionFormat
                };
              }
            }
          }
          return partitions;
        }

        void writeSummaryJson(
            Map<String, Map<String, String>> partitions) async {
          Map<String, Map<String, String>> summary = {};
          summary["efiPartition"] = {
            "partition": partitions["efiPartition"]!["partition"]!,
            "isFormat": partitions["efiPartition"]!["isFormat"]!
          };

          summary["rootPartition"] = {
            "partition": partitions["rootPartition"]!["partition"]!,
            "isFormat": partitions["rootPartition"]!["isFormat"]!
          };

          summary["timezoneLocale"] = {
            "zone": provider.getSelectedZone!,
            "region": provider.getSelectedRegion!,
            "locale": provider.getSelectedLocale!
          };

          summary["user"] = {
            "name": provider.getName!,
            "hostname": provider.getHostname!,
            "username": provider.getUsername!,
            "password": provider.getPassword!
          };

          final summaryStr = jsonEncode(summary);
          // print(summaryStr);

          // final result = File("/home/live/installer.json");
          // result.writeAsString(summaryStr);
          await Process.run("bash", [
            "/etc/tuluos_installer/create_config.sh",
            summaryStr,
          ]).then((value) => print(value.stdout.toString()));
        }

        Map<String, Map<String, String>> partitions = getbootPartiionInfo();

        return Scaffold(
          appBar: AppBar(
            title: const Text("Summary Screen"),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Partition Info"),
              Text(
                  "Disk: ${partitions["rootPartition"]!["disk"]}, Partition: ${partitions["rootPartition"]!["partition"]}, isFormat: ${partitions["rootPartition"]!["isFormat"]} will be used as root partition."),
              Text(
                  "Disk: ${partitions["efiPartition"]!["disk"]}, Partition: ${partitions["efiPartition"]!["partition"]}, isFormat: ${partitions["efiPartition"]!["isFormat"]} will be used as efi partition."),
              const SizedBox(
                height: 20,
              ),
              const Text("TimeZone and Locale Info"),
              Text(
                  "Zone: ${provider.getSelectedZone}, Region: ${provider.getSelectedRegion}, Locale: ${provider.getSelectedLocale}"),
              const SizedBox(
                height: 20,
              ),
              const Text("User Info"),
              Text(
                  "Name: ${provider.getName}, Hostname: ${provider.getHostname}, Username: ${provider.getUsername}"),
            ],
          ),
          persistentFooterAlignment: AlignmentDirectional.bottomCenter,
          persistentFooterButtons: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Prev")),
            ElevatedButton(
                onPressed: () {
                  writeSummaryJson(partitions);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const InstallScreen()));
                },
                child: const Text("Next"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return summaryUi();
  }
}
