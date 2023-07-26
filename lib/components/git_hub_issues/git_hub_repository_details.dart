import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_github/components/git_hub_issues/git_hub_repository_details_list_view.dart';
import 'package:pocket_github/cubits/git_hub_issues/git_hub_issues_cubit.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';

class GitHubRepositoryDetails extends StatelessWidget {
  final GitHubRepositoryItem item;

  const GitHubRepositoryDetails({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(item.fullName),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider<GitHubIssuesCubit>(
          create: (_) => GitHubIssuesCubit(),
          child: GitHubRepositoryDetailsListView(item: item),
        ),
      ),
    );
  }
}
