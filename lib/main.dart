import 'package:flutter/material.dart';
import 'package:pocket_github/components/pocket_git_hub.dart';

void main() {
  runApp(const PocketGitHubApp());
}

class PocketGitHubApp extends StatelessWidget {
  const PocketGitHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const PocketGitHub(),
    );
  }
}
