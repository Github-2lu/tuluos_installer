import 'package:tuluos_installer/models/disk_info.dart';

List<DiskInfo> dummydisks = [
  // DiskInfo(
  //   disk: 'sda',
  //   parts: [
  //     PartitionInfo(
  //         partitionName: 'sda1',
  //         partitionType: 'vfat',
  //         partitionMountpt: ["/boot/efi"],
  //         partitionSize: "256MB",
  //         partitionFormat: "No"),
  //     PartitionInfo(
  //         partitionName: 'sda2',
  //         partitionType: "ext4",
  //         partitionMountpt: ["/root"],
  //         partitionSize: "512GB",
  //         partitionFormat: "No"),
  //   ],
  // ),
  // DiskInfo(disk: 'vda', parts: [
  //   PartitionInfo(
  //       partitionName: 'vda1',
  //       partitionType: "ext3",
  //       partitionMountpt: [""],
  //       partitionSize: "100MB",
  //       partitionFormat: "No"),
  //   PartitionInfo(
  //       partitionName: "vda2",
  //       partitionType: "NTFS",
  //       partitionMountpt: [""],
  //       partitionSize: "2TB",
  //       partitionFormat: "No")
  // ]),
  DiskInfo(disk: "nvme0n1", parts: [
    PartitionInfo(
        partitionName: "nvme0n1p1",
        partitionType: "vfat",
        partitionMountpt: ["/boot/efi"],
        partitionSize: "100M",
        partitionFormat: "no")
  ])
];
