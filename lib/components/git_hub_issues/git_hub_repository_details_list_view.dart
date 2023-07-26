import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_github/components/git_hub_issues/git_hub_repository_issue_card.dart';
import 'package:pocket_github/cubits/git_hub_issues/git_hub_issues_cubit.dart';
import 'package:pocket_github/models/git_hub_repository_issues.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/widgets/card_row.dart';
import 'package:pocket_github/widgets/empty_screen.dart';
import 'package:pocket_github/widgets/loading_screen.dart';

class GitHubRepositoryDetailsListView extends StatefulWidget {
  final GitHubRepositoryItem item;

  const GitHubRepositoryDetailsListView({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<GitHubRepositoryDetailsListView> createState() => _GitHubRepositoryDetailsListViewState();
}

class _GitHubRepositoryDetailsListViewState extends State<GitHubRepositoryDetailsListView> {
  late GitHubIssuesCubit gitHubIssuesCubit;
  late GitHubRepositoryItem item;

  @override
  void initState() {
    super.initState();
    gitHubIssuesCubit = context.read();
    item = widget.item;
    gitHubIssuesCubit.initializeIssuesOfRepository(item.url);
  }

  @override
  Widget build(BuildContext context) {
    final GitHubIssuesState state = context.select<GitHubIssuesCubit, GitHubIssuesState>(getGitHubIssuesState);

    final GitHubIssuesStatus status = state.status;
    final List<GitHubRepositoryIssue> issues = state.issues;
    if (status == GitHubIssuesStatus.loading) {
      return const LoadingScreen();
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        CardRow(name: 'Description:', text: item.description),
        CardRow(name: 'Language:', text: item.language),
        const SizedBox(height: 15),
        detailsRow(),
        issuesTitle(),
        getDetailsListView(issues),
      ],
    );
  }

  Widget detailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        starGazersRow(),
        lastUpdatedDateRow(),
      ],
    );
  }

  Widget starGazersRow() {
    return Row(
      children: <Widget>[
        const Icon(Icons.star),
        const SizedBox(width: 5),
        Text(item.starGazers.toString()),
      ],
    );
  }

  Widget lastUpdatedDateRow() {
    return Row(
      children: <Widget>[
        const Text('Last updated:'),
        const SizedBox(width: 5),
        Text(item.lastUpdated),
      ],
    );
  }

  Text issuesTitle() {
    return const Text(
      'Issues:',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget getDetailsListView(List<GitHubRepositoryIssue> issues) {
    if (issues.isEmpty) {
      return const EmptyScreen(message: 'No issues Found');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: issues.length,
      itemBuilder: (BuildContext context, int index) => issueDetail(issues, index),
    );
  }

  GitHubIssuesState getGitHubIssuesState(GitHubIssuesCubit cubit) {
    return cubit.state;
  }

  Widget issueDetail(List<GitHubRepositoryIssue> issues, int index) {
    final GitHubRepositoryIssue issue = issues[index];
    return GitHubRepositoryIssueCard(issue: issue);
  }
}
