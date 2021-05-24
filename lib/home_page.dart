
import 'package:autowallpaper_admin/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;
  HomePage({required this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentMainCategorySelectedIndex = 0;
  int currentSecondCategorySelectedIndex = 0;
  int currentThirdCategorySelectedIndex = 0;

  String selectedCategoryValue = 'Nature';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title, style: appBarTitleTextStyle,),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          CategoryTitleWidget(
              categoryTitle: 'Main Category',
              onPressed: addMainCategory),
          SizedBox(
            height: categoryItemHeight,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: fiftyItems,
              itemBuilder: (context, index) {
                return CategoryItemWidget(
                    categoryName: 'Category Name ${index+1}',
                    selectedIndex: currentMainCategorySelectedIndex,
                    itemIndex: index,
                    clearOtherItemsSelection: (i) {
                      setState(() {
                        currentMainCategorySelectedIndex = i;
                      });
                      },
                    imageUrl: placeHolderImageUrl);
              },
            ),
          ),
          SizedBox(height: 10,),
          CategoryTitleWidget(
              categoryTitle: 'Second Category',
              onPressed: addSecondCategory),
          SizedBox(
            height: categoryItemHeight,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: fiftyItems,
              itemBuilder: (context, index) {
                return CategoryItemWidget(
                    categoryName: 'Category Name ${index+1}',
                    selectedIndex: currentSecondCategorySelectedIndex,
                    itemIndex: index,
                    clearOtherItemsSelection: (i) {
                      setState(() {
                        currentSecondCategorySelectedIndex = i;
                      });
                    },
                    imageUrl: placeHolderImageUrl);
              },
            ),
          ),
          SizedBox(height: 10,),
          CategoryTitleWidget(
              categoryTitle: 'Third Category',
              onPressed: addThirdCategory),
          SizedBox(
            height: categoryItemHeight,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: fiftyItems,
              itemBuilder: (context, index) {
                return CategoryItemWidget(
                    categoryName: 'Category Name ${index+1}',
                    selectedIndex: currentThirdCategorySelectedIndex,
                    itemIndex: index,
                    clearOtherItemsSelection: (i) {
                      setState(() {
                        currentThirdCategorySelectedIndex = i;
                      });
                    },
                    imageUrl: placeHolderImageUrl);
              },
            ),
          ),
          SizedBox(height: 20,),
          CategoryTitleWidget(categoryTitle: 'Images', onPressed: addNewImageToCategory),
          GridView.count(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            crossAxisCount: 6,
            children:
              List.generate(10, (index) => Image.network(placeHolderImageUrl))
            ,
          )
        ],
      ),
    );
  }

  void addMainCategory() {
    showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Container(
            height: 250,
            width: 500,
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Main Category', style: categoryTextStyle,),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter a new main category name'
                  ),
                ),
                SizedBox(height: 10,),
                MaterialButton(
                  color: addButtonColor,
                  onPressed: () {  },
                  child: Text('Add', style: addButtonTextStyle,),
                )
              ],
            )
          ),
        ));
  }
  void addSecondCategory() {
    showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Container(
              height: 300,
              width: 500,
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Second Category', style: categoryTextStyle,),
                  SizedBox(height: 20,),
                  DropdownButton(
                    value: selectedCategoryValue,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategoryValue = newValue.toString();
                      });
                    },
                    items:
                      ['Nature', 'Ice cream'].map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e))).toList()
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter a new second category name'
                    ),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    color: addButtonColor,
                    onPressed: () {  },
                    child: Text('Add', style: addButtonTextStyle,),
                  )
                ],
              )
          ),
        ));
  }
  void addThirdCategory() {
    showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Container(
              height: 400,
              width: 500,
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Third Category', style: categoryTextStyle,),
                  SizedBox(height: 20,),
                  DropdownButton(
                      value: selectedCategoryValue,
                      isExpanded: true,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategoryValue = newValue.toString();
                        });
                      },
                      items:
                      ['Nature', 'Ice cream'].map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e))).toList()
                  ),
                  SizedBox(height: 10,),
                  DropdownButton(
                      isExpanded: true,
                      value: selectedCategoryValue,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategoryValue = newValue.toString();
                        });
                      },
                      items:
                      ['Nature', 'Ice cream'].map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e))).toList()
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter a new third category name'
                    ),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    color: addButtonColor,
                    onPressed: () {  },
                    child: Text('Add', style: addButtonTextStyle,),
                  )
                ],
              )
          ),
        ));
  }
  void addNewImageToCategory() {
    showDialog(
        context: context,
        builder: (_) => Dialog(
          child: Container(
              height: 250,
              width: 400,
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add an image to the category', style: categoryTextStyle,),
                  SizedBox(height: 20,),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter the image url'
                    ),
                  ),
                  SizedBox(height: 10,),
                  MaterialButton(
                    color: addButtonColor,
                    onPressed: () {  },
                    child: Text('Add', style: addButtonTextStyle,),
                  )
                ],
              )
          ),
        ));
  }

}

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
        widget.clearOtherItemsSelection(widget.itemIndex);
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


