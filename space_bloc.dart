import 'dart:async';

import 'package:app_with_ai/Models/Chat_Model.dart';
import 'package:app_with_ai/Repos/Space_Chat_Repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'space_event.dart';
part 'space_state.dart';

class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  SpaceBloc() : super(ChatSuccessState(message: [])) {
  on<ChatGEnerateNewTextMessageEvent>(chatGEnerateNewTextMessageEvent);


  }

  List<ChatModel> messages = [];

  bool generating = false;

  FutureOr<void> chatGEnerateNewTextMessageEvent(
      ChatGEnerateNewTextMessageEvent event,Emitter<SpaceState> emit)async{
    messages.add(ChatModel(parts: [ChatPartModel(text: event.inputMessage)], role:"user" ,));

    emit(ChatSuccessState(message: messages));

    generating = true;

    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    
    if(generatedText.length>0){
      messages.add(ChatModel(
          parts: [ChatPartModel(text: generatedText)],
          role:'model'));
      emit(ChatSuccessState(message: messages));
    }
    generating = false;
  }
  }
