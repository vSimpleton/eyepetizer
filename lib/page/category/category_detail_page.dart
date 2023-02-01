import 'package:eyepetizer/config/color.dart';
import 'package:eyepetizer/model/category_model.dart';
import 'package:eyepetizer/utils/image_loader.dart';
import 'package:eyepetizer/utils/route_util.dart';
import 'package:eyepetizer/viewmodel/category_detail_view_model.dart';
import 'package:eyepetizer/widget/list_item_widget.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';
import 'package:eyepetizer/widget/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryModel categoryModel;

  const CategoryDetailPage({Key key, this.categoryModel}) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ProviderWidget<CategoryDetailViewModel>(
          viewModel: CategoryDetailViewModel(widget.categoryModel.id),
          onModelInit: (model) {
            model.loadMore(loadMore: false);
          },
          builder: (context, model, child) {
            return NestedScrollView(
              //支持嵌套滚动
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    leading: GestureDetector(
                        onTap: () => back(),
                        child: Icon(Icons.arrow_back, color: Colors.black)),
                    elevation: 0,
                    brightness: Brightness.light,
                    backgroundColor: Colors.white,
                    expandedHeight: 200.0,
                    pinned: true,
                    // 展开和折叠区域
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        model.changeExpendStatusByOffset(
                            (MediaQuery.of(context).padding.top).toInt() + 56,
                            constraints.biggest.height.toInt());
                        return FlexibleSpaceBar(
                          //可折叠状态栏
                          title: Text(
                            widget.categoryModel.name,
                            style: TextStyle(
                                color:
                                    model.expend ? Colors.white : Colors.black),
                          ),
                          centerTitle: false,
                          background:
                              cacheImage(widget.categoryModel.headerImage),
                        );
                      },
                    ),
                  ),
                ];
              },
              body: LoadingStateWidget(
                viewState: model.viewState,
                retry: model.retry,
                child: SmartRefresher(
                  enablePullDown: false,
                  enablePullUp: true,
                  onLoading: model.loadMore,
                  controller: model.refreshController,
                  child: ListView.separated(
                    itemCount: model.itemList.length,
                    itemBuilder: (context, index) {
                      return ListItemWidget(
                        item: model.itemList[index],
                        showCategory: false,
                      );
                    },
                    // 分割线设置
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Divider(
                          height: 0.5,
                          color: lineColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}
