import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuluos_installer/providers/info_provider.dart';
import 'package:tuluos_installer/ui/screens/custom_partition.dart';
import 'package:tuluos_installer/models/disk_info.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() {
    return _WelcomeScreenState();
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // late String disksInfoJson = "";
  List<DiskInfo> currentDisksInfo = [];
  Map<String, List<String>> allTimeZones = {};
  List<String> allLocales = [];

  // Future<String> _runCommand(String exec, List<String> arguments) async {
  //   var res = await Process.run(exec, arguments);
  //   // print(res.stdout.toString());
  //   return res.stdout.toString();
  // }

  Future<List<DiskInfo>> _getDiskInfo() async {
    List<DiskInfo> disksInfo = [];
    // String disks = await Process.run(
    //     "lsblk", ["-o", "name,fstype,size,mountpoints", "-J"]).then((value) => null)
    String disks = "";
    await Process.run("lsblk", ["-o", "name,fstype,size,mountpoints", "-J"])
        .then((value) => disks = value.stdout.toString());
    var disksJson = json.decode(disks);
    for (final disk in disksJson["blockdevices"]) {
      disksInfo.add(DiskInfo.fromJson(disk));
      // print("${tempDisk.parts[0].partitionName} ${tempDisk.parts[0].partitionType}");
      // print(disk["children"][0]["name"]);
    }

    return disksInfo;
  }

  Future<Map<String, List<String>>> _getTimeZones() async {
    String res = "";
    await Process.run("bash", ["/etc/tuluos_installer/get_zones.sh"])
        .then((value) => res = value.stdout.toString());
    List<String> rawZonesArray = res.split(" ");
    rawZonesArray = rawZonesArray.map((rawZone) {
      List<String> rawZoneArray = rawZone.split("/");
      return rawZoneArray[rawZoneArray.length - 2];
    }).toList();

    Map<String, List<String>> timeZones = {};
    for (final zone in rawZonesArray) {
      String zoneFolder = "/usr/share/zoneinfo/";
      List<String> allRegions = [];
      zoneFolder = zoneFolder + zone + "/";
      await Process.run("ls", ["-1", zoneFolder])
          .then((value) => res = value.stdout.toString());
      allRegions = res.split('\n');
      // print();
      timeZones[zone] = allRegions;
    }

    return timeZones;
  }

  Future<List<String>> _getLocales() async {
    List<String> supportedLocals = [];
    var res = "";
    await Process.run("cat", ["/usr/share/i18n/SUPPORTED"])
        .then((value) => res = value.stdout.toString());
    supportedLocals = res.split('\n');
    return supportedLocals;
  }

  @override
  void initState() {
    _getDiskInfo().then((value) => currentDisksInfo = value);
    _getTimeZones().then((value) => allTimeZones = value);
    _getLocales().then((value) => allLocales = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Screen"),
        centerTitle: true,
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ElevatedButton(onPressed: () {}, child: const Text("Prev")),
        ElevatedButton(
            onPressed: () {
              infoProvider.changeDisksInfo(currentDisksInfo);
              infoProvider.setTimezones = allTimeZones;
              infoProvider.setLocales = allLocales;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const CustomPartitionScreen(),
                ),
              );
            },
            child: const Text("Next"))
      ],
    );
  }
}
