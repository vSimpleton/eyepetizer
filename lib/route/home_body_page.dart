import 'package:eyepetizer/viewmodel/home_page_viewmodel.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';
import 'package:eyepetizer/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class HomeBodyPage extends StatefulWidget {
  const HomeBodyPage({Key key}) : super(key: key);

  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState extends State<HomeBodyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<HomePageViewModel>(
      model: HomePageViewModel(),
      onModelInit: (model) => model.refresh(),
      builder: (context, model, child) {
        return LoadingStateWidget(
            retry: model.retry,
            viewState: model.viewState,
            child: Container(
              child: Text('页面加载完成'),
              alignment: Alignment.center,
            ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
