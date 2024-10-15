import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../models/pub_model.dart';

class PubRepo extends GetxController {
  static PubRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  // create Pub
  createPub(PubModel pub, Uint8List selectedImageInBytes) async {
    String imageUrl = '';
    try {
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      firabase_storage.UploadTask uploadTask;
      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('imagesPublicite')
          .child(fileName + ".png");
      /************ */
      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/jpeg');
      uploadTask = ref.putData(selectedImageInBytes, metadata);
      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      /******** */
      final docMsg = _db.collection("Publicite").doc();
      pub = pub.setIdandUrlMsgandNomImg(docMsg.id, imageUrl, fileName + ".png");
      await docMsg.set(pub.toJson());
    } catch (error) {
      print(error);
    }
  }

//get Pub
  Stream<List<PubModel>> getPub() {
    return _db
        .collection("Publicite")
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> docSnapshot) {
      if (docSnapshot.docs.isNotEmpty) {
        return docSnapshot.docs
            .map((doc) => PubModel.fromSnapshot(doc))
            .toList();
      } else {
        return [];
      }
    });
  }

// delete image from Storage
  Future<void> deleteImagePub(String imageName) async {
    final FirebaseStorage _storage = FirebaseStorage.instance;
    final Reference storageRef =
        _storage.ref().child("imagesPublicite").child(imageName);

    try {
      await storageRef.delete();
      print('Image supprimée avec succès.');
    } catch (e) {
      print('Erreur lors de la suppression de l\'image : $e');
    }
  }

//delete msg from firestore
  Future<void> deletePub(String id) async {
    try {
      await _db.collection("Publicite").doc(id).delete();
      print('pub supprimée avec succès.');
    } catch (e) {
      print('Erreur lors de la suppression pub $e');
    }
  }
}
