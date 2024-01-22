List<String> partitionLabels = [
  "Partiton",
  "Type",
  "Mount Point",
  "Size",
  "Format"
];

List<String> mountPoints = ["", "/", "/boot/efi"];

class DiskInfo {
  const DiskInfo({required this.disk, required this.parts});
  final String disk;
  final List<PartitionInfo> parts;

  DiskInfo.fromJson(Map<String, dynamic> diskJson)
      : disk = diskJson["name"],
        parts = [
          if(diskJson["children"]!=null)
            for (final i in diskJson["children"]) PartitionInfo.fromJson(i)
          else
            PartitionInfo(partitionName: "", partitionType: "", partitionMountpt: [""], partitionSize: "", partitionFormat: "")
        ];
        // parts = [];
}

class PartitionInfo {
  PartitionInfo(
      {required this.partitionName,
      required this.partitionType,
      required this.partitionMountpt,
      required this.partitionSize,
      required this.partitionFormat});
  String partitionName;
  String partitionType;
  List<String> partitionMountpt;
  String partitionSize;
  String partitionFormat;

  PartitionInfo.fromJson(Map<String, dynamic> partitionInfo)
      : partitionName = partitionInfo["name"]??"",
        partitionType = partitionInfo["fstype"]??"",
        partitionMountpt = [for(final mp in partitionInfo["mountpoints"]) mp??""],
        partitionSize = partitionInfo["size"]??"",
        partitionFormat = "no";
}
