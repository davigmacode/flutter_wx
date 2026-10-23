import 'package:flutter/material.dart';
import 'package:lerp/lerp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lerp Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _t = 0.5;

  @override
  Widget build(BuildContext context) {
    final interpolatedInt = lerpInt(10, 100, _t);
    final interpolatedDouble = lerpDouble(0.0, 1.0, _t);
    final interpolatedBool = lerpBool(false, true, _t);
    final interpolatedAlign = lerpEnum(
      TextAlign.left,
      TextAlign.right,
      _t,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lerp Demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Factor t: ${_t.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineSmall),
              Slider(
                value: _t,
                min: 0.0,
                max: 1.0,
                onChanged: (val) => setState(() => _t = val),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('lerpInt(10, 100, t): $interpolatedInt'),
                      Text('lerpDouble(0.0, 1.0, t): ${interpolatedDouble?.toStringAsFixed(2)}'),
                      Text('lerpBool(false, true, t): $interpolatedBool'),
                      Text('lerpEnum(TextAlign.left, TextAlign.right, t): $interpolatedAlign'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
