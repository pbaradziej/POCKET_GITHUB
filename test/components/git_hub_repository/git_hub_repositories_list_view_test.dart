import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pocket_github/components/git_hub_repository/git_hub_repositories_list_view.dart';
import 'package:pocket_github/components/git_hub_repository/git_hub_repository_card.dart';
import 'package:pocket_github/cubits/git_hub/git_hub_cubit.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/repositories/git_hub_repository.dart';
import 'package:pocket_github/widgets/empty_screen.dart';
import 'package:pocket_github/widgets/loading_screen.dart';

class MockGitHubRepository extends Mock implements GitHubRepository {}

void main() {
  late GitHubCubit cubit;
  late GitHubRepository gitHubRepository;
  late MaterialApp app;
  const GitHubRepositoriesListView listView = GitHubRepositoriesListView();

  setUp(() {
    gitHubRepository = MockGitHubRepository();
    cubit = GitHubCubit(
      repository: gitHubRepository,
    );
    app = MaterialApp(
      home: Scaffold(
        body: BlocProvider<GitHubCubit>(
          create: (_) => cubit,
          child: const Column(
            children: <Widget>[
              listView,
            ],
          ),
        ),
      ),
    );
  });

  testWidgets('Loads empty screen correctly', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.byType(GitHubRepositoriesListView), findsOneWidget);
    expect(find.byType(EmptyScreen), findsOneWidget);
  });

  testWidgets('Loads loading screen correctly', (WidgetTester tester) async {
    await tester.pumpWidget(app);
    const GitHubState gitHubState = GitHubState(status: GitHubStatus.loading);
    cubit.emit(gitHubState);
    await tester.pump();

    expect(find.byType(LoadingScreen), findsOneWidget);
  });

  testWidgets('Loads listView screen correctly', (WidgetTester tester) async {
    const GitHubRepositoryItem item = GitHubRepositoryItem(
      url: 'test2',
      fullName: 'repository name 2',
      description: 'example description 2',
      language: 'java',
      starGazers: 1555,
      lastUpdated: '25/02/2022',
    );

    await tester.pumpWidget(app);
    const GitHubState gitHubState = GitHubState(
      status: GitHubStatus.loaded,
      items: <GitHubRepositoryItem>[item],
    );
    cubit.emit(gitHubState);
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(GitHubRepositoryCard), findsOneWidget);
  });
}
