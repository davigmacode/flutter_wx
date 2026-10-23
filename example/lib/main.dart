import 'package:flutter/material.dart';
import 'package:marquee_transition/marquee_transition.dart';

/* spell-checker: disable */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const MarqueeTransition(
                mirror: true,
                duration: Duration(milliseconds: 5000),
                reverseCurve: Curves.fastEaseInToSlowEaseOut,
                children: [
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                  )
                ],
              ),
              const SizedBox(height: 20),
              MarqueeTransition(
                mirror: true,
                duration: const Duration(milliseconds: 5000),
                reverseCurve: Curves.fastEaseInToSlowEaseOut,
                children: List<Widget>.generate(5, (i) {
                  final url = 'https://picsum.photos/seed/$i/150/200';
                  return Card.outlined(
                    clipBehavior: Clip.antiAlias,
                    child: Image(image: NetworkImage(url)),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
