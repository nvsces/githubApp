import 'package:github/github.dart';

abstract class BlocState {}

class BlocEmptyState extends BlocState {}

class RepositoryLoadedState extends BlocState {
  List<Repository> repos;
  RepositoryLoadedState(this.repos);
}

class RepositoryLoadingState extends BlocState {}
