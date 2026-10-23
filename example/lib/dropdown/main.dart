import 'package:flutter/material.dart';
import 'package:choice_example/layout.dart';
import 'package:choice_example/sample.dart';
import 'inline.dart';

class DropdownChoicePage extends StatelessWidget {
  const DropdownChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Dropdown choice',
      children: <Widget>[
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
        SamplePanel(
          title: 'Single Choice Dropdown',
          source: 'dropdown/single.dart',
          child: DropdownSingle(),
        ),
      ],
    );
  }
}
