import 'package:chat_app/constens.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id);

  factory MessageModel.fromjason(jasondata) {
    return MessageModel(jasondata[kMessage], jasondata["id"]);
  }
}
