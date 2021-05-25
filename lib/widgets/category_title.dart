import 'package:flutter/material.dart';
import '../constants.dart';

class CategoryTitleWidget extends StatelessWidget {
  final String categoryTitle;
  final VoidCallback onPressed;

  CategoryTitleWidget({required this.categoryTitle,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(categoryTitle, style: categoryTextStyle,),
          Row(
            children: [
              IconButton(onPressed: onPressed, icon: Icon(Icons.add), ),
            ],
          )
        ],
      ),
    );
  }
}