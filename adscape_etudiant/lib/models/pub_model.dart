import 'package:cloud_firestore/cloud_firestore.dart';

class PubModel {
  final String? description;
  final String? idMsg;
  final String? urlImg;
  final String? nomImg;

  PubModel({
    this.description,
    this.idMsg,
    this.urlImg,
    this.nomImg,
  });
  PubModel setIdandUrlMsgandNomImg(String IdMsg, urlMsg, nomImg) {
    return PubModel(
      idMsg: IdMsg,
      description: this.description,
      urlImg: urlMsg,
      nomImg: nomImg,
    );
  }

  factory PubModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PubModel(
        description: data["description"],
        idMsg: data["idMsg"],
        urlImg: data["urlImg"],
        nomImg: data["nomImg"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "idMsg": idMsg,
      "urlImg": urlImg,
      "nomImg": nomImg,
    };
  }
}
