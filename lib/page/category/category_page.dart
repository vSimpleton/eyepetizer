import 'package:animations/animations.dart';
import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/page/category/category_detail_page.dart';
import 'package:eyepetizer/utils/image_loader.dart';
import 'package:eyepetizer/viewmodel/category_view_model.dart';
import 'package:eyepetizer/widget/app_bar.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';
import 'package:eyepetizer/widget/provider_widget.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<CategoryViewModel>(
        viewModel: CategoryViewModel(),
        onModelInit: (viewModel) => viewModel.refresh(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: appBar(category_title),
            body: LoadingStateWidget(
                viewState: viewModel.viewState,
                retry: viewModel.retry,
                child: _gridView(viewModel)
            ),
          );
        });
  }

  Widget _gridView(CategoryViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Color(0xfff2f2f2)),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 5),
        itemCount: viewModel.list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return OpenContainer(
            closedBuilder: (context, action) {
              return _categoryImage(viewModel, index);
            },
            openBuilder: (context, action) {
              return CategoryDetailPage(categoryModel: viewModel.list[index]);
            },
          );
        },
      ),
    );
  }

  Widget _categoryImage(model, index) {
    return Stack(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: cacheImage(model.list[index].bgPicture)),
        Center(
          child: Text(
            '#${model.list[index].name}',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
