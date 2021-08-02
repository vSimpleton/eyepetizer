import 'package:eyepetizer/http/http_manager.dart';
import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/viewmodel/base_change_notifier.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';

class HomePageViewModel extends BaseChangeNotifier {
  // List<Item> bannerLists = [];

  void refresh() {
    HttpManager.getData(Url.feedUrl,
        headers: Url.httpHeader,
        success: (result) {
          // IssueEntity model = IssueEntity.fromJson(result);
          // bannerLists = model.itemList;
          // bannerLists.removeWhere((element) => element.type == 'banner2');
          viewState = ViewState.done;
        },
        fail: (e) {
          ToastUtil.showToastError(e.toString());
          print(e.toString());
        },
        complete: () => notifyListeners());
  }

  retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
