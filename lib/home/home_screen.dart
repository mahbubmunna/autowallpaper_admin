
import 'package:autowallpaper_admin/constants.dart';
import 'package:autowallpaper_admin/home/bloc/bloc.dart';
import 'package:autowallpaper_admin/model/category.dart';
import 'package:autowallpaper_admin/model/image_category.dart';
import 'package:autowallpaper_admin/widgets/category_item.dart';
import 'package:autowallpaper_admin/widgets/category_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progressive_image/progressive_image.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({required this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentMainCategorySelectedIndex = 0;
  int currentSecondCategorySelectedIndex = 0;
  int currentThirdCategorySelectedIndex = 0;

  String currentMainCategoryId = 'Default';
  String currentSecondCategoryId = 'Default';
  String currentThirdCategoryId = 'Default';

  String selectedCategoryValue = 'Nature';

  TextEditingController mainCategoryNameController = TextEditingController();
  TextEditingController mainSecondaryNameController = TextEditingController();

  TextEditingController secondCategoryNameController = TextEditingController();
  TextEditingController thirdCategoryNameController = TextEditingController();
  TextEditingController imageURLController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is InitialHomeScreenState) {
          BlocProvider.of<HomeScreenBloc>(context)
              .add(FetchMainCategoryEvent());
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(widget.title, style: appBarTitleTextStyle,),
          ),
          body: _buildHomePageBody(context)
        );
      },
    );
  }

  void addMainCategory() {

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
                Text('Add Main Category', style: categoryTextStyle,),
                SizedBox(height: 20,),
                TextField(
                  controller: mainCategoryNameController,
                  decoration: InputDecoration(
                      hintText: 'Enter a new main category name'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: mainSecondaryNameController,
                  decoration: InputDecoration(
                      hintText: 'Add a starting secondary category also'
                  ),
                ),
                SizedBox(height: 10,),
                MaterialButton(
                  color: addButtonColor,
                  onPressed: () {
                    BlocProvider.of<HomeScreenBloc>(context)
                        .add(AddMainCategoryEvent(
                        context: context,
                        secondaryCategoryName: mainSecondaryNameController.text,
                        categoryName: mainCategoryNameController.text));
                    clearTextOfControllers();
                  },
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
                  TextField(
                    controller: secondCategoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Enter a new second category name'
                    ),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    color: addButtonColor,
                    onPressed: () {
                      BlocProvider.of<HomeScreenBloc>(context)
                          .add(AddSecondCategoryEvent(
                          context: context,
                          categoryName: secondCategoryNameController.text,
                          mainCategoryDocId: currentMainCategoryId));
                      clearTextOfControllers();
                    },
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
              height: 250,
              width: 500,
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Third Category', style: categoryTextStyle,),
                  SizedBox(height: 10,),
                  TextField(
                    controller: thirdCategoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Enter a new third category name',
                    ),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    color: addButtonColor,
                    onPressed: () {
                      BlocProvider.of<HomeScreenBloc>(context)
                          .add(AddThirdCategoryEvent(
                          context: context,
                          categoryName: thirdCategoryNameController.text,
                          secondCategoryDocId: currentSecondCategoryId));
                      clearTextOfControllers();
                    },
                    child: Text('Add', style: addButtonTextStyle,),
                  )
                ],
              )
          ),
        ));
  }
  void addNewImageToCategory() {
    PickedFile? image;
    showDialog(
        context: context,
        builder: (context) => Dialog(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                  height: 350,
                  width: 400,
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Text('Add an image to the category', style: categoryTextStyle,),
                      SizedBox(height: 20,),
                      (image !=null)?
                      Container(
                          height: 100,
                          child: Image.network(image!.path))
                          : Container(height: 100,),
                      SizedBox(height: 20,),
                      (image == null)?
                      MaterialButton(
                        height: 40,
                        color: addButtonColor,
                        onPressed: () async{
                          image = await ImagePicker().getImage(source: ImageSource.gallery);
                          if(image != null) print(image!.path);
                          setState((){});
                        },
                        child: Text('Browse', style: addButtonTextStyle,),
                      )
                          : MaterialButton(
                            height: 40,
                            color: addButtonColor,
                            child: Text('Upload'),
                            onPressed: () async{
                              var binary = await image!.readAsBytes();
                              BlocProvider.of<HomeScreenBloc>(context)
                                  .add(AddImageByCategoryEvent(
                                  context: context,
                                  binaryImage: binary,
                                  thirdCategoryDocId: currentThirdCategoryId));
                        })
                    ],
                  )
              );
            },
          ),
        ));
  }

  Widget _buildHomePageBody(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ErrorState) {
          return Center(
            child: Text('Error loading data', style: errorTextStyle, ),
          );
        }

        if (state is LoadedState) {
          var mainCategories = BlocProvider.of<HomeScreenBloc>(context).mainCategory;

          var secondCategories =
              BlocProvider.of<HomeScreenBloc>(context)
                  .mainCategory[currentMainCategorySelectedIndex].subCategories;

          var selectedSecondCategoryName;
          int length =
          BlocProvider.of<HomeScreenBloc>(context)
              .mainCategory[currentMainCategorySelectedIndex].subCategories.length;
          if(length > 0)
            selectedSecondCategoryName =
                BlocProvider.of<HomeScreenBloc>(context)
                .mainCategory[currentMainCategorySelectedIndex].subCategories[currentSecondCategorySelectedIndex].toString();


          var currentThirdCategory =
              BlocProvider.of<HomeScreenBloc>(context)
                  .secondCategory.firstWhere((element) {
                if(element.name == selectedSecondCategoryName) {
                  currentSecondCategoryId = element.documentId;
                  return true;
                } else return false;

              }, orElse: () => Category(name: "Not found", documentId: '', subCategories: []));

          var thirdCategories =
              BlocProvider.of<HomeScreenBloc>(context)
                  .secondCategory.firstWhere((element) {
                if(element.name == selectedSecondCategoryName) {
                  currentSecondCategoryId = element.documentId;
                  return true;
                } else return false;

              }, orElse: () => Category(name: "Not found", documentId: '', subCategories: [])).subCategories;




          int rightSecondCategoryItemPosition =
          BlocProvider.of<HomeScreenBloc>(context)
              .secondCategory.indexWhere(
                  (element) => element.name ==
                  mainCategories[currentMainCategorySelectedIndex].subCategories[currentSecondCategorySelectedIndex]);

          var selectedThirdCategoryName;
          if (rightSecondCategoryItemPosition != -1){
            int length =BlocProvider.of<HomeScreenBloc>(context)
                .secondCategory[rightSecondCategoryItemPosition]
                .subCategories.length;
            if(length > 0)
              selectedThirdCategoryName =
                  BlocProvider.of<HomeScreenBloc>(context)
                      .secondCategory[rightSecondCategoryItemPosition]
                      .subCategories[currentThirdCategorySelectedIndex].toString();
          }


          print(selectedThirdCategoryName);

          var currentImageCategory =
              BlocProvider.of<HomeScreenBloc>(context)
                  .thirdCategory.firstWhere((element) => element.name == selectedThirdCategoryName,
                  orElse: () => ImageCategory(name: "Not found", documentId: '', images: []));

          var imageCategory =
              BlocProvider.of<HomeScreenBloc>(context)
                  .thirdCategory.firstWhere((element) => element.name == selectedThirdCategoryName,
                  orElse: () => ImageCategory(name: "Not found", documentId: '', images: [])).images;


          return ListView(
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
                  itemCount: mainCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryItemWidget(
                        categoryName: mainCategories[index].name,
                        selectedIndex: currentMainCategorySelectedIndex,
                        itemIndex: index,
                        clearOtherItemsSelection: (i) {
                          setState(() {
                            currentMainCategoryId = mainCategories[index].documentId;
                            currentMainCategorySelectedIndex = i;
                            currentSecondCategorySelectedIndex = 0;
                            currentThirdCategorySelectedIndex = 0;
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
                  itemCount: secondCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryItemWidget(
                        categoryName: secondCategories[index],
                        selectedIndex: currentSecondCategorySelectedIndex,
                        itemIndex: index,
                        clearOtherItemsSelection: (i) {
                          setState(() {
                            currentSecondCategoryId = currentThirdCategory.documentId;
                            currentSecondCategorySelectedIndex = i;
                            currentThirdCategorySelectedIndex = 0;
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
                  itemCount: thirdCategories.length,
                  itemBuilder: (context, index) {
                    return CategoryItemWidget(
                        categoryName: thirdCategories[index],
                        selectedIndex: currentThirdCategorySelectedIndex,
                        itemIndex: index,
                        clearOtherItemsSelection: (i) {
                          setState(() {
                            currentThirdCategoryId = currentImageCategory.documentId;
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
                crossAxisCount: 5,
                children:
                List.generate(imageCategory.length, (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()
                  ),
                  child: ProgressiveImage(
                    height: 155,
                    width: 190,
                    placeholder: NetworkImage(placeHolderImageUrl),
                    thumbnail: NetworkImage(placeHolderImageUrl),
                    image: NetworkImage(imageCategory[index]),
                  ),
                ))
                ,
              )
            ],
          );
        }

        return Container();
      },
    );
  }

  void clearTextOfControllers() {
    mainCategoryNameController.clear();
    secondCategoryNameController.clear();
    mainCategoryNameController.clear();
    thirdCategoryNameController.clear();
    imageURLController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mainCategoryNameController.dispose();
    secondCategoryNameController.dispose();
    mainCategoryNameController.dispose();
    thirdCategoryNameController.dispose();
    imageURLController.dispose();
  }


}





