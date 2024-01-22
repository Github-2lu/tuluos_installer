// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuluos_installer/providers/info_provider.dart';
import 'package:tuluos_installer/ui/screens/user_info.dart';

class TimeZoneLocaleScreen extends StatefulWidget {
  const TimeZoneLocaleScreen({super.key});

  @override
  State<TimeZoneLocaleScreen> createState() {
    return _TimeZoneLocale();
  }
}

class _TimeZoneLocale extends State<TimeZoneLocaleScreen> {
  Widget _showTimezoneUi() {
    return Consumer<InfoProvider>(
      builder: (context, provider, _) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  const Text("Region"),
                  Expanded(
                    child: DropdownButton(
                        value: provider.getSelectedZone,
                        items: provider.getZones
                            .map((zone) => DropdownMenuItem(
                                value: zone, child: Text(zone)))
                            .toList(),
                        onChanged: (newZone) {
                          // setState(() {
                          provider.setSelectedZone = newZone;
                          // });
                        }),
                  ),
                  const Spacer()
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  const Text("Zone"),
                  Expanded(
                    child: DropdownButton(
                        value: provider.getSelectedRegion,
                        items: provider
                            .getRegions(provider.getSelectedZone!)
                            .map((zone) => DropdownMenuItem(
                                value: zone, child: Text(zone)))
                            .toList(),
                        onChanged: (newZone) {
                          // setState(() {
                          provider.setSelectedRegion = newZone;
                          // });
                        }),
                  ),
                  const Spacer()
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  const Text("Locale: "),
                  Expanded(
                    child: DropdownButton(
                        value: provider.getSelectedLocale,
                        items: provider.getLocales
                            .map((locale) => DropdownMenuItem(
                                value: locale, child: Text(locale)))
                            .toList(),
                        onChanged: (newLocale) {
                          provider.setSelectedLocale = newLocale;
                        }),
                  ),
                  const Spacer()
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TimeZone and Locale Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _showTimezoneUi(),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Prev")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const UserInfoScreen()));
            },
            child: const Text("Next"))
      ],
    );
  }
}
