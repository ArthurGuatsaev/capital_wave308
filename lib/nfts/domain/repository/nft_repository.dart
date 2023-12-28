import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../import.dart';

class NFTRepository with MyPickerImage {
  final Isar isar;
  final StreamController<String> errorController;
  NFTRepository({required this.isar, required this.errorController});
  List<NFTModel>? nft;

  Future<List<NFTModel>> getSaveNFT(
      {StreamController<VLoading>? controller}) async {
    nft = await isar.nFTModels.where().findAll();
    if (nft == null) return [];
    controller?.add(VLoading.nft);
    return nft!;
  }

  Future<void> saveNFT({required NFTModel note}) async {
    await isar.writeTxn(() async {
      await isar.nFTModels.put(note);
    });
  }

  Future<void> deleteNFT(NFTModel nft) async {
    await isar.writeTxn(() async {
      await isar.nFTModels.delete(nft.id!); // delete
    });
  }

  Future<void> reseteNFT() async {
    await isar.writeTxn(() async {
      await isar.nFTModels.clear(); // resete
    });
  }
}

mixin MyPickerImage {
  FileImage? myImage;
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  Future<XFile?> getNewImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (_) {
      return null;
    }
  }

  Future<void> saveImage({required XFile? image, required String key}) async {
    if (image == null) return;
    (await prefs).remove(key);
    final path = await getApplicationDocumentsDirectory();
    final String imgpath = path.path;
    final date = DateTime.now();
    await image.saveTo('$imgpath/${date.millisecond}.jpeg');
    (await prefs).setString(key, '/${date.millisecond}.jpeg');
    final newImage = await getImage(key: key);
    myImage = newImage;
  }

  Future<FileImage?> getImage({required String key}) async {
    try {
      final localPath = (await prefs).getString(key);
      if (localPath == null) {
        return null;
      }
      final path = await getApplicationDocumentsDirectory();
      return FileImage(File(path.path + localPath));
    } catch (_) {
      return null;
    }
  }

  Future<void> resetImage({required List<String> productsImage}) async {
    try {
      final path = await getApplicationDocumentsDirectory();
      for (var i in productsImage) {
        final localPath = (await prefs).getString(i);
        if (localPath == null) return;
        (await prefs).remove(i);
        await File(path.path + localPath).delete(recursive: true);
      }
    } catch (_) {}
  }
}
