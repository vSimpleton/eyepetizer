import 'package:eyepetizer/base/base_change_notifier.dart';
import 'package:eyepetizer/http/http_manager.dart';
import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';

class VideoDetailViewModel extends BaseChangeNotifier {
  List<Item> itemList = [];
  int _videoId;

  void loadVideoData(int id) {
    _videoId = id;
    // https://baobab.kaiyanapp.com/api/v4/video/related?id=266986
    HttpManager.requestData('${Url.videoRelatedUrl}$id').then((res) {
      Issue issue = Issue.fromJson(res);
      itemList = issue.itemList;
      viewState = ViewState.done;
    }).catchError((e) {
      Toast.showToast(e.toString());
      viewState = ViewState.error;
    }).whenComplete(() => notifyListeners());
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    loadVideoData(_videoId);
  }
}
