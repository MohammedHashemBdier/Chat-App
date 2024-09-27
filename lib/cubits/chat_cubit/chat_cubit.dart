import 'package:chat_app/constens.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<MessageModel> messagesList = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollections);

  void sendMassage({
    required String massage,
    required String email,
  }) {
    messages.add(
      {
        kMessage: massage,
        kCreatedAt: DateTime.now(),
        "id": email,
      },
    );
  }

  void getMassages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen(
      (event) {
        messagesList.clear();
        for (var doc in event.docs) {
          debugPrint('Received message event: ${doc.data()}');
          messagesList.add(
            MessageModel.fromjason(
              doc.data(),
            ),
          );
        }
        emit(
          ChatSuccess(
            messagesList: messagesList,
          ),
        );
      },
    );
  }
}
