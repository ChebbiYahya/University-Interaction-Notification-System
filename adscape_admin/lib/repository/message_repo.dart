import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../models/message_model.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

class MessageRepo extends GetxController {
  static MessageRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

// create msg
  createMsg(MessageModel msg, String specialite,
      Uint8List selectedImageInBytes) async {
    String imageUrl = '';
    try {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      firabase_storage.UploadTask uploadTask;
      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('imagesMessage')
          .child(fileName + ".png");
      /************ */
      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/jpeg');
      uploadTask = ref.putData(selectedImageInBytes, metadata);
      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      /******** */
      final docMsg = _db.collection(specialite).doc();
      msg =
          msg.setIdandUrlMsgandNameImg(docMsg.id, imageUrl, fileName + ".png");
      await docMsg.set(msg.toJson());
    } catch (e) {}
  }

//get message
  Stream<List<MessageModel>> getMessage(String specialite) {
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

  // delete image from Storage
  Future<void> deleteImageMsg(String imageName) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    final Reference storageRef =
        _storage.ref().child("imagesMessage").child(imageName);

    try {
      await storageRef.delete();
      print('Image supprimée avec succès.');
    } catch (e) {
      print('Erreur lors de la suppression de l\'image : $e');
    }
  }

//delete msg from firestore
  Future<void> deleteMsg(String id, String specialite) async {
    try {
      await _db.collection(specialite).doc(id).delete();
      print('msg supprimée avec succès.');
    } catch (e) {
      print('Erreur lors de la suppression msg $e');
    }
  }
}
