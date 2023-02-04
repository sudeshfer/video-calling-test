import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class NotificationController {
  //firebase auth instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //creates the token collection refference
  CollectionReference tokens = FirebaseFirestore.instance.collection('tokens');

  //-----save user deivce token in the user data
  Future<void> saveNotificationToken(String token) async {
    await tokens
        .add(
          {
            "token": token,
          },
        )
        .then((value) => Logger().i("device token  updated"))
        .catchError((error) => Logger().e("Failed to update: $error"));
  }
}
