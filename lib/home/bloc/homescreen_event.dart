import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeScreenEvent{}

class FetchMainCategoryEvent extends HomeScreenEvent{}

class AddMainCategoryEvent extends HomeScreenEvent{
  final String categoryName;
  final String secondaryCategoryName;
  final BuildContext context;

  AddMainCategoryEvent({required this.secondaryCategoryName, required this.context, required this.categoryName});
}

class FetchSecondCategoryEvent extends HomeScreenEvent{}

class AddSecondCategoryEvent extends HomeScreenEvent{
  final String categoryName;
  final BuildContext context;
  final mainCategoryDocId;

  AddSecondCategoryEvent({required this.context,
    required this.categoryName,
    required this.mainCategoryDocId});
}

class FetchThirdCategoryEvent extends HomeScreenEvent{}

class AddThirdCategoryEvent extends HomeScreenEvent{
  final String categoryName;
  final BuildContext context;
  final String secondCategoryDocId;

  AddThirdCategoryEvent({required this.context,
    required this.categoryName,
    required this.secondCategoryDocId});
}

class FetchImagesByCategoryEvent extends HomeScreenEvent{}

class AddImageByCategoryEvent extends HomeScreenEvent{
  final Uint8List binaryImage;
  final BuildContext context;
  final String thirdCategoryDocId;

  AddImageByCategoryEvent({required this.context,
    required this.binaryImage,
    required this.thirdCategoryDocId});
}