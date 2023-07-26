import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pocket_github/components/git_hub_repository/git_hub_search_text_field.dart';
import 'package:pocket_github/cubits/git_hub/git_hub_cubit.dart';
import 'package:pocket_github/models/git_hub_repository_item.dart';
import 'package:pocket_github/repositories/git_hub_repository.dart';

class MockGitHubRepository extends Mock implements GitHubRepository {}

void main() {
  late GitHubCubit cubit;
  late GitHubRepository gitHubRepository;
  const GitHubSearchTextField searchTextField = GitHubSearchTextField();
  late MaterialApp app;

  setUp(() {
    gitHubRepository = MockGitHubRepository();
    cubit = GitHubCubit(
      repository: gitHubRepository,
    );
    app = MaterialApp(
      home: Scaffold(
        body: BlocProvider<GitHubCubit>(
          create: (_) => cubit,
          child: searchTextField,
        ),
      ),
    );
  });

  testWidgets('Loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.byType(GitHubSearchTextField), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('Should call onSubmit', (WidgetTester tester) async {
    when(() => gitHubRepository.searchForGitHubRepositories(any())).thenAnswer(
      (_) async => <GitHubRepositoryItem>[],
    );
    await tester.pumpWidget(app);
    GitHubState state = cubit.state;
    GitHubStatus status = state.status;
    expect(status, GitHubStatus.initial);

    await tester.enterText(find.byType(TextField), 'text');
    await tester.tap(find.byType(Icon));
    await tester.pumpAndSettle();
    state = cubit.state;
    status = state.status;
    expect(status, GitHubStatus.loaded);
  });
}
