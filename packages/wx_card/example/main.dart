import 'package:flutter/material.dart';
import 'package:wx_card/wx_card.dart';

void main() {
  runApp(const WxCardExampleApp());
}

class WxCardExampleApp extends StatelessWidget {
  const WxCardExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WxCard Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WxCard Example'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WxCard(
                    variant: WxCardVariant.elevated,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Elevated Card',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'A surface card with dynamic elevation and rounded corner geometry.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  WxCard(
                    variant: WxCardVariant.tonal,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tonal Card',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Filled with secondary container tint for softer visual presence.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  WxCard(
                    variant: WxCardVariant.outlined,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Outlined Card',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Bordered outline card suitable for structured tile layouts.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  WxCardTile(
                    variant: WxCardVariant.tonal,
                    leading: const Icon(Icons.credit_card_rounded),
                    title: const Text('Interactive Card Tile'),
                    subtitle: const Text('Tap to trigger event callback'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
