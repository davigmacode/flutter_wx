import 'package:flutter/material.dart';

import '../../template.dart';
import 'basic.dart';
import 'checkmark.dart';
import 'avatar.dart';
import 'delete.dart';
import 'severity.dart';

class ChipPage extends StatelessWidget {
  const ChipPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: title,
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: const [
          ChipBasicUsage(),
          ChipCheckmarkUsage(),
          ChipAvatarUsage(),
          ChipDeleteUsage(),
          ChipSeverityUsage(),
        ],
      ),
    );
  }
}
