import 'package:eyepetizer/base/base_change_notifier.dart';
import 'package:eyepetizer/http/http_manager.dart';
import 'package:eyepetizer/http/url.dart';
import 'package:eyepetizer/model/category_model.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';

class CategoryViewModel extends BaseChangeNotifier {
  List<CategoryModel> list = [];

  void refresh() async {
    HttpManager.getData(
      Url.categoryUrl,
      success: (result) {
        list = (result as List)
            .map((model) => CategoryModel.fromJson(model))
            .toList();
        viewState = ViewState.done;
      },
      error: (e) {
        Toast.showToast(e.toString());
        viewState = ViewState.error;
      },
      complete: () => notifyListeners(),
    );
  }

  void retry() {
    viewState = ViewState.loading;
    notifyListeners();
    refresh();
  }

}
