part of 'space_bloc.dart';

@immutable
abstract class SpaceState {}

class SpaceInitial extends SpaceState {}

class ChatSuccessState extends SpaceState{
  final List<ChatModel> message;

  ChatSuccessState({
    required this.message,
});
}