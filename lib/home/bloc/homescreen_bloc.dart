
import 'package:autowallpaper_admin/home/bloc/bloc.dart';
import 'package:autowallpaper_admin/model/category.dart';
import 'package:autowallpaper_admin/model/image_category.dart';
import 'package:autowallpaper_admin/repository/homescreen_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState>{

  HomeScreenBloc(HomeScreenState initialState) : super(initialState);

  List<Category> mainCategory = [];
  List<Category> secondCategory = [];
  List<ImageCategory> thirdCategory = [];

  @override
  Stream<HomeScreenState> mapEventToState(
      HomeScreenEvent event
      ) async* {

    if(event is FetchMainCategoryEvent) {
      yield LoadingState();

      try {
        mainCategory = await HomePageDataRepository.getMainCategories();
        secondCategory = await HomePageDataRepository.getSecondaryCategories();
        thirdCategory = await HomePageDataRepository.getThirdCategory();

        yield LoadedState();
      } catch (e, s) {
        Logger().e('Fetch Main Category', e, s);
        yield ErrorState();
      }
    };

    if (event is AddMainCategoryEvent) {
      Navigator.of(event.context).pop();
      yield LoadingState();
      try {
        Category item = await HomePageDataRepository.addAMainCategory(
            {'secondcategories': [event.secondaryCategoryName],
              'name': event.categoryName});

        mainCategory.add(item);
        yield LoadedState();
      } catch (e, s) {
        Logger().e('Add Main Category', e, s);
        yield ErrorState();
      }
    }

    if (event is AddSecondCategoryEvent) {
      Navigator.of(event.context).pop();
      yield LoadingState();
      try {
        await HomePageDataRepository.addSecondCategory(
            event.categoryName,
            event.mainCategoryDocId);

        mainCategory = await HomePageDataRepository.getMainCategories();
        secondCategory = await HomePageDataRepository.getSecondaryCategories();

        yield LoadedState();
      } catch (e, s) {
        Logger().e('Add Second Category', e, s);
        yield ErrorState();
      }
    }

    if (event is AddThirdCategoryEvent) {
      Navigator.of(event.context).pop();
      yield LoadingState();
      try {
        await HomePageDataRepository.addThirdCategory(
            event.categoryName,
            event.secondCategoryDocId);

        mainCategory = await HomePageDataRepository.getMainCategories();
        secondCategory = await HomePageDataRepository.getSecondaryCategories();
        thirdCategory = await HomePageDataRepository.getThirdCategory();

        yield LoadedState();
      } catch (e, s) {
        Logger().e('Add Third Category', e, s);
        yield ErrorState();
      }
    }

    if (event is AddImageByCategoryEvent) {
      Navigator.of(event.context).pop();
      yield LoadingState();
      try {

        await HomePageDataRepository.addImageToCategory(
            event.imageURL,
            event.thirdCategoryDocId);

        mainCategory = await HomePageDataRepository.getMainCategories();
        secondCategory = await HomePageDataRepository.getSecondaryCategories();
        thirdCategory = await HomePageDataRepository.getThirdCategory();

        yield LoadedState();
      } catch (e, s) {
        Logger().e('Add Third Category', e, s);
        yield ErrorState();
      }
    }
  }
}