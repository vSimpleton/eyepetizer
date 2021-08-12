import 'package:eyepetizer/http/http_manager.dart';
import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/model/issue_model.dart';
import 'package:eyepetizer/model/paging_model.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/viewmodel/base_list_viewmodel.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';

class HomePageViewModel extends BaseListViewModel<Item, IssueEntity> {
  List<Item> bannerLists;

  @override
  IssueEntity getModel(Map<String, dynamic> json) => IssueEntity.fromJson(json);

  @override
  String getUrl() => Url.feedUrl;

  @override
  void getData(List<Item> list) {
    bannerLists = list;
    itemList.clear();
    //为Banner占位，后面要接list列表
    itemList.add(Item());
  }

  @override
  void removeUselessData(List<Item> list) {
    // 移除类型为 'banner2' 的数据
    list.removeWhere((item) {
      return item.type == 'banner2';
    });
  }

  @override
  void doExtraAfterRefresh() async {
    // 此处调用加载更多，是为了获取首次列表数据，因为第一个列表数据用来做banner数据了。
    await loadMore();
  }
}
