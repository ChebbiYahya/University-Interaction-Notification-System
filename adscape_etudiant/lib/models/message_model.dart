import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? title;
  final String? description;
  final String? idMsg;
  final String? idProf;
  final String? nomProf;
  final String? time;
  final String? urlImg;
  final bool? checkImportant;

  MessageModel({
    this.title,
    this.description,
    this.idMsg,
    this.idProf,
    this.nomProf,
    this.time,
    this.urlImg,
    this.checkImportant,
  });
  MessageModel setIdandUrlMsg(String IdMsg, urlMsg) {
    return MessageModel(
      idMsg: IdMsg,
      title: this.title,
      description: this.description,
      idProf: this.idProf,
      nomProf: this.nomProf,
      time: this.time,
      urlImg: urlMsg,
      checkImportant: this.checkImportant,
    );
  }

  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return MessageModel(
      title: data["title"],
      description: data["description"],
      idMsg: data["idMsg"],
      idProf: data["idProf"],
      nomProf: data["nomProf"],
      time: data["time"],
      urlImg: data["urlImg"],
      checkImportant: data["checkImportant"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "idMsg": idMsg,
      "idProf": idProf,
      "nomProf": nomProf,
      "time": time,
      "urlImg": urlImg,
      "checkImportant": checkImportant,
    };
  }
}
