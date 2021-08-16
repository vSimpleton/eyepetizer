import 'package:eyepetizer/base/base_list_viewmodel.dart';
import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/model/discovery/topic_model.dart';

class TopicPageViewModel extends BaseListViewModel<TopicItemModel, TopicModel> {
  @override
  String getUrl() {
    return Url.topicsUrl;
  }

  @override
  TopicModel getModel(Map<String, dynamic> json) {
    return TopicModel.fromJson(json);
  }
}
