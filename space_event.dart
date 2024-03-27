part of 'space_bloc.dart';

@immutable
abstract class SpaceEvent {}


class ChatGEnerateNewTextMessageEvent extends SpaceEvent{
  final String inputMessage;
  ChatGEnerateNewTextMessageEvent({
    required this.inputMessage,
});
}