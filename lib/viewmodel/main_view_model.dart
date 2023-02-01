import 'package:eyepetizer/base/base_change_notifier.dart';

class MainViewModel extends BaseChangeNotifier {

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  changeBottomTabIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

}