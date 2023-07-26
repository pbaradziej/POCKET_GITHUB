import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pocket_github/components/git_hub_issues/git_hub_repository_details_list_view.dart';
import 'package:pocket_github/components/git_hub_issues/git_hub_repository_issue_card.dart';
import 'package:pocket_github/cubits/git_hub_issues/git_hub_issues_cubit.dart';
import 'package:pocket_github/models/git_hub_repository_issues.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/repositories/git_hub_repository.dart';
import 'package:pocket_github/widgets/card_row.dart';
import 'package:pocket_github/widgets/empty_screen.dart';
import 'package:pocket_github/widgets/loading_screen.dart';

class MockGitHubRepository extends Mock implements GitHubRepository {}

void main() {
  late GitHubIssuesCubit cubit;
  late GitHubRepository gitHubRepository;
  late MaterialApp app;
  const GitHubRepositoryItem item = GitHubRepositoryItem(
    url: 'test2',
    fullName: 'repository name 2',
    description: 'example description 2',
    language: 'java',
    starGazers: 1555,
    lastUpdated: '25/02/2022',
  );
  const GitHubRepositoryDetailsListView listView = GitHubRepositoryDetailsListView(item: item);

  setUp(() {
    gitHubRepository = MockGitHubRepository();
    when(() => gitHubRepository.getIssuesOfRepository(any())).thenAnswer(
      (_) async => <GitHubRepositoryIssue>[],
    );
    cubit = GitHubIssuesCubit(
      repository: gitHubRepository,
    );
    app = MaterialApp(
      home: Scaffold(
        body: BlocProvider<GitHubIssuesCubit>(
          create: (_) => cubit,
          child: listView,
        ),
      ),
    );
  });

  testWidgets('Loads loading screen correctly', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    const GitHubIssuesState gitHubIssuesState = GitHubIssuesState(status: GitHubIssuesStatus.loading);
    cubit.emit(gitHubIssuesState);
    await tester.pump();

    expect(find.byType(LoadingScreen), findsOneWidget);
  });

  testWidgets('Loads empty screen correctly', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    const GitHubIssuesState gitHubIssuesState = GitHubIssuesState(
      status: GitHubIssuesStatus.loaded,
    );
    cubit.emit(gitHubIssuesState);
    await tester.pumpAndSettle();

    expect(find.byType(CardRow), findsNWidgets(2));
    expect(find.byType(GitHubRepositoryDetailsListView), findsOneWidget);
    expect(find.byType(EmptyScreen), findsOneWidget);
  });

  testWidgets('Loads listView screen correctly', (WidgetTester tester) async {
    const GitHubRepositoryIssue issue = GitHubRepositoryIssue(
      title: 'title',
      body: 'body',
      state: 'open',
    );

    await tester.pumpWidget(app);
    const GitHubIssuesState gitHubIssuesState = GitHubIssuesState(
      status: GitHubIssuesStatus.loaded,
      issues: <GitHubRepositoryIssue>[issue],
    );
    cubit.emit(gitHubIssuesState);
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsNWidgets(2));
    expect(find.byType(GitHubRepositoryIssueCard), findsOneWidget);
  });
}
