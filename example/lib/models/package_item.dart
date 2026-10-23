import 'package:flutter/material.dart';

enum PackageCategory {
  all('All Packages', Icons.grid_view_rounded),
  typography('Typography & Text', Icons.text_fields_rounded),
  surfaces('Surfaces & Layout', Icons.layers_rounded),
  motion('Motion & Animations', Icons.animation_rounded),
  pickers('Pickers & Selection', Icons.touch_app_rounded),
  utilities('Utilities & State', Icons.handyman_rounded);

  final String label;
  final IconData icon;
  const PackageCategory(this.label, this.icon);
}

class PackageItem {
  final String id;
  final String name;
  final String version;
  final String summary;
  final PackageCategory category;
  final IconData icon;
  final Widget Function(BuildContext) builder;

  const PackageItem({
    required this.id,
    required this.name,
    required this.version,
    required this.summary,
    required this.category,
    required this.icon,
    required this.builder,
  });
}
