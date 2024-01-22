import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuluos_installer/providers/info_provider.dart';
import 'package:tuluos_installer/ui/screens/summary.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});
  @override
  State<UserInfoScreen> createState() {
    return _UserInfoScreenState();
  }
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _nameController = TextEditingController();
  final _hostNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();

  void _submitChanges(InfoProvider provider) {
    if (_nameController.text != "" &&
        _hostNameController.text != "" &&
        _userNameController.text != "" &&
        _passwordController.text != "" &&
        _passwordController.text == _retypePasswordController.text) {
      provider.setName = _nameController.text;
      provider.setHostname = _hostNameController.text;
      provider.setUsername = _userNameController.text;
      provider.setPassword = _passwordController.text;
    } else {
      print("fail");
    }
  }

  Widget userInfoUi() {
    return Consumer<InfoProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                const Text("Your Name: "),
                Expanded(
                    child: TextField(
                  controller: _nameController
                    ..text = provider.getName == null ? "" : provider.getName!,
                )),
                const Spacer()
              ],
            ),
            Row(
              children: [
                const Spacer(),
                const Text("Host Name: "),
                Expanded(
                  child: TextField(
                    controller: _hostNameController
                      ..text = provider.getHostname == null
                          ? ""
                          : provider.getHostname!,
                  ),
                ),
                const Spacer()
              ],
            ),
            Row(
              children: [
                const Spacer(),
                const Text("User Name: "),
                Expanded(
                  child: TextField(
                    controller: _userNameController
                      ..text = provider.getUsername == null
                          ? ""
                          : provider.getUsername!,
                  ),
                ),
                const Spacer()
              ],
            ),
            Row(
              children: [
                const Spacer(),
                const Text("Password : "),
                Expanded(
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController
                      ..text = provider.getPassword == null
                          ? ""
                          : provider.getPassword!,
                  ),
                ),
                const Spacer()
              ],
            ),
            Row(
              children: [
                const Spacer(),
                const Text("Retype Password : "),
                Expanded(
                  child: TextField(
                    obscureText: true,
                    controller: _retypePasswordController
                      ..text = provider.getPassword == null
                          ? ""
                          : provider.getPassword!,
                  ),
                ),
                const Spacer()
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _hostNameController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: userInfoUi(),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Prev"),
        ),
        ElevatedButton(
          onPressed: () {
            _submitChanges(infoProvider);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const SummaryScreen()));
          },
          child: const Text("Next"),
        )
      ],
    );
  }
}
