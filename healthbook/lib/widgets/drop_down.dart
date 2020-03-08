import 'package:flutter/material.dart';

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

List<Item> users = <Item>[
  const Item(
    'Male (പുരുഷൻ)',
    Icon(
      Icons.person,
      color: const Color(0xFF167F67),
    ),
  ),
  const Item(
    'Female (സ്ത്രീ)',
    Icon(
      Icons.ac_unit,
      color: const Color(0xFF167F67),
    ),
  ),

  const Item(
    'Other (മറ്റുള്ളവ)',
    Icon(
      Icons.exit_to_app,
      color: const Color(0xFF167F67),
    ),
  ),

  const Item(
    'Prefer not to say',
    Icon(
      Icons.help_outline,
      color: const Color(0xFF167F67),
    ),
  ),
];
