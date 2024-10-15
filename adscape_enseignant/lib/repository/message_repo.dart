import 'dart:io';

import 'package:adscape_enseignant/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class MessageRepo extends GetxController {
  static MessageRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createMsg(MessageModel msg, String specialite, String urlImg) async {
    String msgUrl;
    try {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('imagesMessage');
      Reference referenceImageUpload =
          referenceDirImages.child(fileName + ".png");
      await referenceImageUpload.putFile(File(urlImg));
      msgUrl = await referenceImageUpload.getDownloadURL();
      final docMsg = _db.collection(specialite).doc();
      msg = msg.setIdandUrlMsgandNameImg(docMsg.id, msgUrl, fileName + ".png");
      await docMsg.set(msg.toJson());
    } catch (error) {
      print(error);
    }
  }

  Stream<List<MessageModel>> getMessage(String specialite, String idUser) {
    return _db
        .collection(specialite)
        //.orderBy("time", descending: true)
        .where("idProf", isEqualTo: idUser)
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
