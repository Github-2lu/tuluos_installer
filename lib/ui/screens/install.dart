import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

class InstallScreen extends StatefulWidget {
  const InstallScreen({super.key});
  @override
  State<InstallScreen> createState() {
    return _InstallScreenState();
  }
}

class _InstallScreenState extends State<InstallScreen> {
  final txtController = TextEditingController();
  String installInfo = "";

  void _installSystem() async {
    final process = await Process.start("bash", ["/etc/tuluos_installer/install.sh"]);

    await process.stdout.transform(utf8.decoder).forEach(_changeStr);
  }

  void _changeStr(String newInfo) {
    setState(() {
      installInfo += newInfo;
    });
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _installSystem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    txtController.text = installInfo;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: TextField(
                maxLength: null,
                maxLines: null,
                decoration: const InputDecoration(enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
                readOnly: true,
            controller: txtController,
          ))
        ],
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ElevatedButton(onPressed: (){
          exit(0);
        }, child: const Text("Finish"))
      ],
    );
  }
}
