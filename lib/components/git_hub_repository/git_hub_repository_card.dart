import 'package:flutter/material.dart';
import 'package:pocket_github/components/git_hub_issues/git_hub_repository_details.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/widgets/card_row.dart';

class GitHubRepositoryCard extends StatelessWidget {
  final GitHubRepositoryItem item;

  const GitHubRepositoryCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => showDetailsScreen(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CardRow(name: 'Title:', text: item.fullName),
              CardRow(name: 'Language:', text: item.language),
              CardRow(name: 'Description:', text: item.description),
              showDetailsButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showDetailsButton() {
    return const Text(
      'Show Details',
      style: TextStyle(
        color: Colors.blue,
      ),
    );
  }

  void showDetailsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (_) => GitHubRepositoryDetails(item: item),
      ),
    );
  }
}
