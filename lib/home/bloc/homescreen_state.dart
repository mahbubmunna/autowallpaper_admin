import 'package:flutter/cupertino.dart';

@immutable
abstract class HomeScreenState{}

class InitialHomeScreenState extends HomeScreenState{}

class LoadingState extends HomeScreenState{}

class LoadedState extends HomeScreenState{}

class ErrorState extends HomeScreenState{}