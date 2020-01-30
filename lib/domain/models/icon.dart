import 'package:flutter/material.dart';

class Icon {
  final int id;
  final IconData iconData;

  const Icon({this.iconData, this.id});

  factory Icon.fromId(int id) {
    return icons.firstWhere((element) => element.id == id);
  }
}

const List<Icon> icons = [
  Icon(id: 1, iconData: Icons.attach_money),
  Icon(id: 2, iconData: Icons.account_balance),
  Icon(id: 3, iconData: Icons.access_alarms),
  Icon(id: 4, iconData: Icons.audiotrack),
  Icon(id: 5, iconData: Icons.cloud),
  Icon(id: 6, iconData: Icons.desktop_windows),
  Icon(id: 7, iconData: Icons.directions_bike),
  Icon(id: 8, iconData: Icons.drive_eta),
  Icon(id: 9, iconData: Icons.favorite),
  Icon(id: 10, iconData: Icons.flight),
  Icon(id: 11, iconData: Icons.local_bar),
  Icon(id: 12, iconData: Icons.local_cafe),
  Icon(id: 13, iconData: Icons.local_hotel),
  Icon(id: 14, iconData: Icons.palette),
  Icon(id: 15, iconData: Icons.work),
];
