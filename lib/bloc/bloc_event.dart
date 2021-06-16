import 'package:github/github.dart';

abstract class BlocEvent {}

class EventEditVisibylity extends BlocEvent {
  final Repository repository;
  final bool private;
  EventEditVisibylity({required this.private, required this.repository});
}

class EventEditName extends BlocEvent {
  final Repository repository;
  final String name;
  EventEditName({required this.name, required this.repository});
}

class EventEditDescription extends BlocEvent {
  final Repository repository;
  final String description;
  EventEditDescription({required this.description, required this.repository});
}

class EventSearchRepository extends BlocEvent {
  final String query;
  EventSearchRepository(this.query);
}

class EventUpdate extends BlocEvent {}

class EventCreateRepository extends BlocEvent {
  CreateRepository createRepository;
  EventCreateRepository(this.createRepository);
}
