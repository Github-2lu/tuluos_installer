import 'dart:io';

import 'package:flutter/material.dart';

class InstallScreen extends StatefulWidget {
  const InstallScreen({super.key});
  @override
  State<InstallScreen> createState() {
    return _InstallScreenState();
  }
}

class _InstallScreenState extends State<InstallScreen> {
  bool isComplete = false;

  Future<String> _installSystem() async {
    String res = "";
    await Process.run("bash", ["/etc/tuluos_installer/install.sh"], runInShell: true,)
        .then((value) => res = value.stdout.toString());
    print(res);
    return res;
  }

  @override
  void initState() {
    super.initState();
    _installSystem().then((value) {
      // print(value);
      if (value.contains("ok")) {
        // print(value);
        setState(() {
          isComplete = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = isComplete == false
        ? Scaffold(
            appBar: AppBar(
              title: Text("Install Screen"),
            ),
            body: Text("Installing"),
          )
        : Scaffold(
            appBar: AppBar(title: Text("Install Screen")),
            body: Text("Finished"),
            persistentFooterButtons: [
              ElevatedButton(onPressed: () {}, child: Text("Finish"))
            ],
          );
    return content;
  }
}
