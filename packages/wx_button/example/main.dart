import 'package:flutter/material.dart';
import 'package:wx_button/wx_button.dart';

void main() {
  runApp(const WxButtonExampleApp());
}

class WxButtonExampleApp extends StatefulWidget {
  const WxButtonExampleApp({super.key});

  @override
  State<WxButtonExampleApp> createState() => _WxButtonExampleAppState();
}

class _WxButtonExampleAppState extends State<WxButtonExampleApp> {
  int _counter = 0;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WxButton Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WxButton Example'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter: $_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    WxButton(
                      variant: WxButtonVariant.tonal,
                      onPressed: () => setState(() => _counter++),
                      child: const Text('Tonal'),
                    ),
                    WxButton(
                      variant: WxButtonVariant.filled,
                      onPressed: () => setState(() => _counter++),
                      child: const Text('Filled'),
                    ),
                    WxButton(
                      variant: WxButtonVariant.elevated,
                      onPressed: () => setState(() => _counter++),
                      child: const Text('Elevated'),
                    ),
                    WxButton(
                      variant: WxButtonVariant.outlined,
                      onPressed: () => setState(() => _counter++),
                      child: const Text('Outlined'),
                    ),
                    WxButton(
                      variant: WxButtonVariant.text,
                      onPressed: () => setState(() => _counter++),
                      child: const Text('Text'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    WxIconButton(
                      onPressed: () => setState(() => _counter++),
                      child: const Icon(Icons.add_rounded),
                    ),
                    WxIconButton(
                      variant: WxButtonVariant.filled,
                      onPressed: () => setState(() => _counter--),
                      child: const Icon(Icons.remove_rounded),
                    ),
                    WxButton(
                      loading: _loading,
                      onPressed: () async {
                        setState(() => _loading = true);
                        await Future<void>.delayed(const Duration(seconds: 1));
                        if (mounted) setState(() => _loading = false);
                      },
                      child: const Text('Toggle Loading'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
