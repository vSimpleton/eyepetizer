import 'package:eyepetizer/base/base_list_view_model.dart';
import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/model/issue_model.dart';

class HomeViewModel extends BaseListViewModel<Item, IssueEntity> {
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
    list?.removeWhere((item) {
      return item.type == 'banner2';
    });
  }

  @override
  void doExtraAfterRefresh() async {
    await loadMore();
  }
}
