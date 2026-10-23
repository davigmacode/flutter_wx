import 'package:flutter/material.dart';
import 'package:choice/choice.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choice Showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChoiceShowcasePage(),
    );
  }
}

class ChoiceShowcasePage extends StatefulWidget {
  const ChoiceShowcasePage({super.key});

  @override
  State<ChoiceShowcasePage> createState() => _ChoiceShowcasePageState();
}

class _ChoiceShowcasePageState extends State<ChoiceShowcasePage> {
  final List<String> categories = const [
    'Tech',
    'Flutter',
    'Design',
    'Science',
    'Mobile',
    'AI',
    'Gaming',
    'Open Source',
  ];

  String? selectedSingle = 'Flutter';
  List<String> selectedMultiple = ['Tech', 'Flutter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choice Showcase')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Inline Single Choice',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          InlineChoice<String>.single(
            clearable: true,
            value: selectedSingle,
            onChanged: (val) => setState(() => selectedSingle = val),
            itemCount: categories.length,
            itemBuilder: (selection, i) {
              final item = categories[i];
              return ChoiceChip(
                selected: selection.selected(item),
                onSelected: selection.onSelected(item),
                label: Text(item),
              );
            },
            listBuilder: ChoiceList.createWrapped(
              spacing: 8,
              runSpacing: 8,
            ),
          ),
          const Divider(height: 48),
          const Text(
            'Inline Multiple Choice',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          InlineChoice<String>.multiple(
            clearable: true,
            value: selectedMultiple,
            onChanged: (val) => setState(() => selectedMultiple = val),
            itemCount: categories.length,
            itemBuilder: (selection, i) {
              final item = categories[i];
              return FilterChip(
                selected: selection.selected(item),
                onSelected: selection.onSelected(item),
                label: Text(item),
              );
            },
            listBuilder: ChoiceList.createWrapped(
              spacing: 8,
              runSpacing: 8,
            ),
          ),
          const Divider(height: 48),
          const Text(
            'Prompted Choice (Modal Bottom Sheet)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Card.outlined(
            child: PromptedChoice<String>.single(
              title: 'Select Topic',
              value: selectedSingle,
              onChanged: (val) => setState(() => selectedSingle = val),
              itemCount: categories.length,
              itemBuilder: (state, i) {
                final item = categories[i];
                return ListTile(
                  title: Text(item),
                  trailing: state.selected(item)
                      ? const Icon(Icons.check, color: Colors.deepPurple)
                      : null,
                  onTap: () => state.select(item),
                );
              },
              promptDelegate: ChoicePrompt.delegateBottomSheet(),
              anchorBuilder: ChoiceAnchor.create(inline: true),
            ),
          ),
        ],
      ),
    );
  }
}
