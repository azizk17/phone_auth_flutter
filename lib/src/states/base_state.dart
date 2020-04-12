import 'package:app3/src/app/enums/enums.dart';
import 'package:flutter/foundation.dart';

class BaseState extends ChangeNotifier {
  ViewState _actionState = null;
  void setState(ViewState state) {
    _actionState = state;
    notifyListeners();
  }
  void reset(){
    _actionState = null;
  }
}