import 'package:eyepetizer/base/base_change_notifier.dart';
import 'package:eyepetizer/http/http_manager.dart';
import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryDetailViewModel extends BaseChangeNotifier {

  int category;
  List<Item> itemList = [];
  String _nextPageUrl;
  bool loading = true;
  bool error = false;
  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  bool expend = true;

  CategoryDetailViewModel(this.category);

  void loadMore({loadMore = true}) async {
    String url;
    if (loadMore) {
      if (_nextPageUrl == null) {
        refreshController.loadNoData();
        return;
      }
      // 测试数据
      url = _nextPageUrl +
          "&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url, loadMore);
    } else {
      url = Url.categoryVideoUrl +
          "id=$category&udid=d2807c895f0348a180148c9dfa6f2feeac0781b5&deviceModel=Android";
      getData(url, loadMore);
    }
  }

  void getData(String url, bool loadMore) {
    HttpManager.getData(url,
        success: (result) {
          Issue issue = Issue.fromJson(result);
          viewState = ViewState.done;
          if (!loadMore) error = false;
          itemList.addAll(issue.itemList);
          _nextPageUrl = issue.nextPageUrl;
          refreshController.loadComplete();
        },
        error: (e) {
          viewState = ViewState.error;
          if (!loadMore) error = true;
          Toast.showToast(e.toString());
          refreshController.loadFailed();
        },
        complete: () => notifyListeners());
  }

  retry() {
    loading = true;
    notifyListeners();
    loadMore(loadMore: false);
  }

  void changeExpendStatusByOffset(int statusBarHeight, int offset) {
    if (offset > statusBarHeight && offset < 250) {
      if (!expend) {
        expend = true;
      }
    } else {
      if (expend) {
        expend = false;
      }
    }
  }
}
