import 'package:eyepetizer/viewmodel/base_change_notifier.dart';

class TabNavigationViewModel extends BaseChangeNotifier {

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  changeBottomTabIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

}