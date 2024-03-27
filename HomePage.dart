import 'package:app_with_ai/Models/Chat_Model.dart';
import 'package:app_with_ai/Space_Bloc/space_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final SpaceBloc spaceBloc = SpaceBloc();
  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SpaceBloc, SpaceState>(
        bloc: spaceBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatModel> messages = (state as ChatSuccessState).message;
              return Container(
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      opacity: 0.5,
                      image: AssetImage("Space_bg.png"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //This is for Search Btn and Logo
                    Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Space Ai',
                            style: TextStyle(fontSize: 30, fontFamily: 'Kenil'),
                          ),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.image_search)),
                        ],
                      ),
                    ),



                    //This is main Body chating
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 12, top: 15),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.amber.withOpacity(0.1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                      messages[index].role == "user"
                                          ? "User"
                                          : "Space Bot",
                                      style: TextStyle(
                                         height: -1.1,
                                          fontSize: 20,
                                          //fontWeight: FontWeight.bold,
                                          color: messages[index].role == "user"
                                              ? Colors.cyan.shade300
                                              : Colors.green)),
                                  SizedBox(height: 7,),
                                  Text(messages[index].parts.first.text,)
                                ],
                              ),
                            );
                            /*   final message = messages[index];
                            if (message.role.isNotEmpty) {
                              return _buildUserMessage(message.parts.first.text);
                            } else{
                              return _buildModelMessage(message.parts.first.text);
                            }*/
                          },
                        ),

                      ),
                    ),

                    if(spaceBloc.generating)
                      //This is for Loader
                      Row(
                        children: [
                          Container(
                              height: 80,
                              width: 80,
                              child: Lottie.asset('assets/Space_Loder.json')),

                          SizedBox(width: 20,),

                          Text('Loading...'),
                        ],
                      ),

                    //This is for TextFeild
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: controller,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "Ask Anything about Space...",
                                hintStyle: TextStyle(color: Colors.grey.shade800),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fillColor: Colors.grey.shade500,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              if (controller.text.isNotEmpty) {
                                String text = controller.text;
                                controller.clear();
                                spaceBloc.add(ChatGEnerateNewTextMessageEvent(inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.black87,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );

            default:
              return SizedBox(child: Text('Error'),);
          }
        },
      ),
    );
  }

 /* Widget _buildUserMessage(String text) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 12, top: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.cyan.withOpacity(0.2),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildModelMessage(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 20, left: 20, bottom: 12, top: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.amber.withOpacity(0.1),
        ),
        child: Text(text),
      ),
    );
  }*/
}
