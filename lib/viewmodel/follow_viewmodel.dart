import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/base/base_list_viewmodel.dart';

class FollowViewModel extends BaseListViewModel<Item, Issue> {

  @override
  Issue getModel(Map<String, dynamic> json) {
    return Issue.fromJson(json);
  }

  @override
  String getUrl() {
    return Url.followUrl;
  }

}