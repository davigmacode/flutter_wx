import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:theme_patrol/theme_patrol.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemePatrol(
      // initialTheme: 'amber',
      // initialMode: ThemeMode.system,
      onAvailableChanged: (_) => log('available themes changed'),
      onThemeChanged: (theme) => log('theme changed to ${theme.selected}'),
      onModeChanged: (theme) => log('theme mode changed to ${theme.mode.name}'),
      onColorChanged: (theme) =>
          log('theme color changed to ${theme.color.toString()}'),
      onChanged: (theme) => log('value changed'),
      themes: {
        'basic': ThemeConfig.fromColor(Colors.purple),
        'pro': ThemeConfig.fromColor(Colors.red),
        'premium': ThemeConfig.fromColor(Colors.amber),
      },
      light: ThemeData.light(),
      dark: ThemeData.dark(),
      builder: (context, theme, _) {
        return MaterialApp(
          title: 'ThemePatrol Example',
          theme: theme.data,
          darkTheme: theme.darkData,
          themeMode: theme.mode,
          home: const MyHomePage(title: 'ThemePatrol Example'),
          builder: theme.bootstrap(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 45, 0, 25),
                child: Center(
                  child: Text(
                    'ThemePatrol',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
              ThemeConsumer(
                builder: (context, theme, _) {
                  return Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => theme.toggleMode(),
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            theme.modeIcon,
                            key: ValueKey(theme.mode),
                          ),
                        ),
                        label: Text('${theme.mode.name.toUpperCase()} MODE'),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () => theme.resetMode(),
                        child: const Text('Reset to Initial Mode'),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              ThemeConsumer(
                builder: (context, theme, _) {
                  return Wrap(
                    spacing: 5,
                    children: theme.availableEntries
                        .map((e) => FilterChip(
                              label: Text(e.key),
                              onSelected: (_) => theme.select(e.key),
                              selected: theme.selected == e.key,
                              checkmarkColor: Colors.white,
                              avatar: CircleAvatar(
                                backgroundColor:
                                    e.value.colorSchemeOf(context).primary,
                              ),
                            ))
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 5,
                children: [
                  TextButton(
                    onPressed: () => ThemePatrol.of(context).selectPrev(),
                    child: const Text('Prev Theme'),
                  ),
                  ElevatedButton(
                    onPressed: () => ThemeProvider.of(context).resetTheme(),
                    child: const Text('Reset to Initial Theme'),
                  ),
                  TextButton(
                    onPressed: () => ThemeProvider.of(context).selectNext(),
                    child: const Text('Next Theme'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => ThemePatrol.of(context).selectRandom(),
                child: const Text('Random Theme'),
              ),
              const SizedBox(height: 30),
              const Text(
                'Override Theme Color',
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              ThemeConsumer(builder: (context, theme, _) {
                return Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: Colors.primaries.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      crossAxisCount: 6,
                    ),
                    itemBuilder: (_, i) {
                      final color = Colors.primaries[i];
                      return Card(
                        color: color,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () => theme.toColor(color),
                          child: Icon(
                            color == theme.color ? Icons.check : null,
                            color: Colors.white70,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => ThemePatrol.of(context).resetColor(),
                child: const Text('Reset Color to Theme Color'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => ThemePatrol.of(context).reset(),
                child: const Text('Reset All to Initial Values'),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
