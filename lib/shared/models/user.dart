import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id);

  final int id;

  @override
  List<Object> get props => [id];

  static const empty = User(null);
}