import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';

class MessageRepo extends GetxController {
  static MessageRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessageStream(String specialite) {
    return _db
        .collection(specialite)
        .orderBy('time', descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> docSnapshot) {
      if (docSnapshot.docs.isNotEmpty) {
        return docSnapshot.docs
            .map((doc) => MessageModel.fromSnapshot(doc))
            .toList();
      } else {
        return [];
      }
    });
  }
}
