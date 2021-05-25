import 'package:flutter/material.dart';

import '../constants.dart';

class CategoryItemWidget extends StatefulWidget {
  final String categoryName;
  final String imageUrl;
  final int itemIndex;
  final int selectedIndex;
  final Function clearOtherItemsSelection;

  CategoryItemWidget(
      {required this.categoryName,
        required this.itemIndex,
        required this.selectedIndex,
        required this.clearOtherItemsSelection,
        required this.imageUrl});

  @override
  _CategoryItemWidgetState createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    if (widget.itemIndex != widget.selectedIndex) isSelected = false;
    return MaterialButton(
      onPressed: () {
        widget.clearOtherItemsSelection(
            widget.itemIndex);
        setState(() {
          isSelected = true;

        });
      },
      child: Container(
        color: isSelected ? selectedCategoryItemColor : transparentColor,
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: 105,
        child: Column(
          children: [
            Image.network(widget.imageUrl),
            Text(widget.categoryName, overflow: TextOverflow.fade, maxLines: 2,)
          ],
        ),
      ),
    );
  }
}