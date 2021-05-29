
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:autowallpaper_admin/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:autowallpaper_admin/model/category.dart';
import 'package:autowallpaper_admin/model/image_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class HomePageDataRepository {
  static const MainCategory = 'maincategories';
  static const SecondaryCategory = 'secondcategories';
  static const LastCategory = 'lastcategories';
  static const Name = 'name';
  static const Images = 'images';

  static const MainCategoryPath = 'maincategories';
  static const SecondaryCategoryPath = 'secondarycategories';
  static const LastCategoryPath = 'lastcategories';


  static getMainCategories() async =>
      await FirebaseFirestore.instance
          .collection(MainCategoryPath)
          .get().then((collection) {
        var categoryList = <Category>[];
        collection.docs.forEach((element) {
          categoryList.add(
              Category(
                  documentId: element.id,
                  name: element.data()[Name],
                  subCategories: element.data()[SecondaryCategory]
              ));
        });
        return categoryList;
      });

  static getSecondaryCategories() async =>
      await FirebaseFirestore.instance
          .collection(SecondaryCategoryPath)
          .get().then((collection) {
        var categoryList = <Category>[];
        collection.docs.forEach((element) {
          categoryList.add(
              Category(
                  documentId: element.id,
                  name: element.data()[Name],
                  subCategories: element.data()[LastCategory]
              ));
        });
        return categoryList;
      });

  static getThirdCategory() async =>
      await FirebaseFirestore.instance
          .collection(LastCategoryPath)
          .get().then((collection) {
        var categoryList = <ImageCategory>[];
        collection.docs.forEach((element) {
          categoryList.add(
              ImageCategory(
                  documentId: element.id,
                  name: element.data()[Name],
                  images: element.data()[Images]
              ));
        });
        return categoryList;
      });

  static addAMainCategory(Map<String, dynamic> data) async {
    var value = await FirebaseFirestore.instance
        .collection(MainCategoryPath)
        .add(data).then((value) => value);

    var category = await value.get().then((value) =>
        Category(documentId: value.id,
            name: value.data()![Name],
            subCategories: value.data()![SecondaryCategory]));

    return category;
  }


  static addSecondCategory(String categoryName,
      String documentId) async {
    await FirebaseFirestore.instance
        .collection(MainCategoryPath)
        .doc(documentId)
        .update({SecondaryCategory: FieldValue.arrayUnion([categoryName])});

    await FirebaseFirestore.instance
        .collection(SecondaryCategoryPath)
        .add({"name": categoryName, "lastcategories": []});
  }

  static addThirdCategory(String categoryName,
      String documentId) async {
    await FirebaseFirestore.instance
        .collection(SecondaryCategoryPath)
        .doc(documentId)
        .update({LastCategory: FieldValue.arrayUnion([categoryName])});

    await FirebaseFirestore.instance
        .collection(LastCategoryPath)
        .add({"name": categoryName, "images": []});
  }

  addImageToCategory(Uint8List binaryImage,
      String documentId) async {
    var response = _getImageUrl(binaryImage);

    // await FirebaseFirestore.instance
    //     .collection(LastCategoryPath)
    //     .doc(documentId)
    //     .update({Images: FieldValue.arrayUnion([imageURL])});

  }

  _getImageUrl(Uint8List binaryImage) async {
    var base64Encoder = Base64Encoder();
    var imageBase64 = base64Encoder.convert(binaryImage);

    var endPoint = "https://freeimage.host/api/1/upload";
    var imageBody = {
      'key': imageTokenOne,
      'action': 'upload',
      'source': imageBase64,
    };
  }


}
