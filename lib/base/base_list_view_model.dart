import 'package:eyepetizer/base/base_change_notifier.dart';
import 'package:eyepetizer/http/http_manager.dart';
import 'package:eyepetizer/model/paging_model.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListViewModel<T, M extends PagingModel<T>>
    extends BaseChangeNotifier {
  List<T> itemList = [];
  String nextPageUrl = ''; //下一页请求链接

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  M getModel(Map<String, dynamic> json);

  String getUrl();

  void getData(List<T> list) {
    this.itemList = list;
  }

  //下拉刷新后的额外操作，目前仅HomePage会使用
  void doExtraAfterRefresh() {}

  // 移除无用数据，目前仅HomePage会使用
  void removeUselessData(List<T> list) {}

  //上拉加载更多请求地址
  String getNextUrl(M model) {
    return model.nextPageUrl;
  }

  void refresh() {
    HttpManager.getData(getUrl(),
        success: (json) {
          M model = getModel(json);
          removeUselessData(model.itemList);
          getData(model.itemList);
          viewState = ViewState.done;

          // 下一页数据的处理
          nextPageUrl = getNextUrl(model);
          refreshController.refreshCompleted();
          refreshController.footerMode?.value = LoadStatus.canLoading;

          // 做额外的操作：例如加载home的列表数据
          doExtraAfterRefresh();
        },
        error: (e) {
          Toast.showToast(e.toString());
          refreshController.refreshFailed();
          viewState = ViewState.error;
        },
        complete: () => notifyListeners());
  }

  //加载更多
  Future<void> loadMore() async {
    if (nextPageUrl == '') {
      refreshController.loadNoData();
      return;
    }
    HttpManager.getData(nextPageUrl,
        success: (json) {
          M model = getModel(json);
          removeUselessData(model.itemList);
          // 将model.itemList数据，接到 itemList 数组后面
          itemList.addAll(model.itemList);
          nextPageUrl = getNextUrl(model);
          refreshController.loadComplete();
          notifyListeners();
        },
        error: (e) {
          Toast.showToast(e.toString());
          refreshController.loadFailed();
        },
        complete: () => notifyListeners());
  }

  retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }
}
