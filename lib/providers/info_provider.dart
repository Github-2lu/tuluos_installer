import 'package:flutter/material.dart';
import 'package:tuluos_installer/models/disk_info.dart';

class InfoProvider extends ChangeNotifier {
  // partition system
  List<DiskInfo> _systemDisks = [];
  int? _currDisk = 0;
  int _currPartition = -1;

  List<DiskInfo> get systemDisks => _systemDisks;

  void changeDisksInfo(List<DiskInfo> disks) {
    _systemDisks = disks;
    notifyListeners();
  }

  void changeMpandFormat(int diskIndex, int partitionIndex,
      {required List<String> mountPoints, required String format}) {
    _systemDisks[diskIndex].parts[partitionIndex].partitionMountpt =
        mountPoints;
    _systemDisks[diskIndex].parts[partitionIndex].partitionFormat = format;
    notifyListeners();
  }

  int? get getCurrDisk => _currDisk;

  int get getCurrPartition => _currPartition;

  // void setCurrDisk(int changedDisk) => _currDisk = changedDisk;
  set setCurrDisk(int? changedDisk) {
    _currDisk = changedDisk;
    notifyListeners();
  }

  set setCurrPartition(int changedPart) {
    _currPartition = changedPart;
    notifyListeners();
  }

  // time and date locale
  Map<String, List<String>> _timezones = {};
  String? _selectedZone="Asia";
  String? _selectedRegion="Kolkata";

  List<String> _locales=[];
  String? _selectedLocale = "en_IN UTF-8";

  List<String> get getZones => _timezones.keys.toList();
  List<String> getRegions(String zone) {
    if (_timezones[zone] == null) {
      return [];
    }
    return _timezones[zone]!;
  }

  set setTimezones(Map<String, List<String>> timezones) {
    _timezones = timezones;
    notifyListeners();
  }

  String? get getSelectedZone => _selectedZone;
  String? get getSelectedRegion => _selectedRegion;

  set setSelectedZone(String? newZone){
    _selectedZone = newZone;
    _selectedRegion = null;
    notifyListeners();
  }
  set setSelectedRegion(String? newRegion){
    _selectedRegion = newRegion;
    notifyListeners();
  }

  List<String> get getLocales => _locales;
  String? get getSelectedLocale => _selectedLocale;

  set setLocales(List<String> locales){
    _locales = locales;
    notifyListeners();
  }

  set setSelectedLocale(String? newLocale){
    _selectedLocale = newLocale;
    notifyListeners();
  }

  // user info
  String? _name;
  String? _hostname="tuluos";
  String? _username;
  String? _password;

  String? get getName => _name;
  String? get getHostname => _hostname;
  String? get getUsername => _username;
  String? get getPassword => _password;

  set setName(String? name){
    _name = name;
    notifyListeners();
  }

  set setHostname(String? hostname){
    _hostname = hostname;
    notifyListeners();
  }

  set setUsername(String? username){
    _username = username;
    notifyListeners();
  }

  set setPassword(String? password){
    _password = password;
    notifyListeners();
  }
}
