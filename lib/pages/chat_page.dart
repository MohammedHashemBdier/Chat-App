import 'package:chat_app/constens.dart';
import 'package:chat_app/helper/custom_chat_bubble.dart';
import 'package:chat_app/helper/custom_chat_bubble_for_frind.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static const String id = "ChatPage";
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference messages = firestore.collection(kMessageCollections);
    TextEditingController controller = TextEditingController();
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              MessageModel.fromjason(
                  snapshot.data!.docs[i].data() as Map<String, dynamic>),
            );
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      kLogo,
                      height: 50,
                      // width: 10,
                    ),
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Pacifico",
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? CustomChatBubble(
                              message: messagesList[index],
                            )
                          : CustomChatBubbleForFrind(
                              message: messagesList[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          "id": email,
                        },
                      );
                      controller.clear();
                      scrollController.animateTo(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn);
                    },
                    decoration: InputDecoration(
                        hintText: "Send Message",
                        suffix: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: kPrimaryColor),
                        )),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text("Loding....");
        }
      },
    );
  }
}
