import 'package:flutter/material.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

List<Item> users = <Item>[
  const Item(
    'Male',
    Icon(
      Icons.person,
      color: const Color(0xFF167F67),
    ),
  ),
  const Item(
    'Female',
    Icon(
      Icons.person_pin_circle,
      color: const Color(0xFF167F67),
    ),
  ),
];
