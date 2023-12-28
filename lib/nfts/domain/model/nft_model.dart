// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'nft_model.g.dart';

@collection
class NFTModel {
  Id? id = Isar.autoIncrement;
  int? myId;
  String? name;
  double? price;
  String? desc;
  String? image;
  bool? isFavorite;
  NFTModel({
    this.id,
    this.name,
    this.price,
    this.myId,
    this.desc,
    this.image,
    this.isFavorite,
  });

  NFTModel copyWith({
    Id? id,
    int? myId,
    String? name,
    double? price,
    String? desc,
    String? image,
    bool? isFavorite,
  }) {
    return NFTModel(
      id: id ?? this.id,
      myId: myId ?? this.myId,
      name: name ?? this.name,
      price: price ?? this.price,
      desc: desc ?? this.desc,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @ignore
  Future<FileImage?> get productImage async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localPath = (prefs).getString('$myId');
      if (localPath == null) {
        return null;
      }
      final path = await getApplicationDocumentsDirectory();
      return FileImage(File(path.path + localPath));
    } catch (e) {
      return null;
    }
  }

  factory NFTModel.fromMap(Map<String, dynamic> map) {
    return NFTModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      desc: map['desc'] != null ? map['desc'] as String : null,
      isFavorite: map['isFavorite'] != null ? map['isFavorite'] as bool : null,
    );
  }
}
