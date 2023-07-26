import 'package:flutter/material.dart';
import 'package:pocket_github/models/git_hub_repository_issues.dart';
import 'package:pocket_github/widgets/card_row.dart';

class GitHubRepositoryIssueCard extends StatelessWidget {
  final GitHubRepositoryIssue issue;

  const GitHubRepositoryIssueCard({
    required this.issue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            CardRow(name: 'Title:', text: issue.title),
            CardRow(name: 'Issue state:', text: issue.state),
            CardRow(name: 'Body:', text: issue.body),
          ],
        ),
      ),
    );
  }
}
