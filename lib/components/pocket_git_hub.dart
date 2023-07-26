import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_github/components/git_hub_repository/git_hub_repositories_page.dart';
import 'package:pocket_github/cubits/git_hub/git_hub_cubit.dart';

class PocketGitHub extends StatelessWidget {
  const PocketGitHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pocket GitHub'),
      ),
      body: BlocProvider<GitHubCubit>(
        create: (_) => GitHubCubit(),
        child: const GitHubRepositoriesPage(),
      ),
    );
  }
}
