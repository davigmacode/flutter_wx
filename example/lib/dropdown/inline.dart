import 'package:flutter/material.dart';
import 'package:choice/dropdown.dart';

class DropdownSingle extends StatefulWidget {
  const DropdownSingle({super.key});

  @override
  State<DropdownSingle> createState() => _DropdownSingleState();
}

class _DropdownSingleState extends State<DropdownSingle> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> selectedValue = [];

  void setSelectedValue(List<String>? value) {
    setState(() => selectedValue = value ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return const ChoiceDropdown();
  }
}
