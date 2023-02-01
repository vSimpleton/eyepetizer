import 'package:eyepetizer/base/base_list_state.dart';
import 'package:eyepetizer/config/color.dart';
import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/viewmodel/home_view_model.dart';
import 'package:eyepetizer/widget/banner_widget.dart';
import 'package:eyepetizer/widget/list_item_widget.dart';
import 'package:flutter/material.dart';

class HomeBodyPage extends StatefulWidget {
  @override
  _HomeBodyPageState createState() => _HomeBodyPageState();
}

class _HomeBodyPageState
    extends BaseListState<Item, HomeViewModel, HomeBodyPage> {
  @override
  HomeViewModel get viewModel => HomeViewModel();

  @override
  Widget getContentChild(HomeViewModel model) {
    return ListView.separated(
      itemCount: model.itemList.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _banner(model);
        } else {
          if (model.itemList[index].type == 'textHeader') {
            return _titleItem(model.itemList[index]);
          }
          return ListItemWidget(item: model.itemList[index]);
        }
      },
      // 分割线设置
      separatorBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          // Divider:分割线
          child: Divider(
            height: model.itemList[index].type == 'textHeader' || index == 0
                ? 0
                : 0.5,
            color: model.itemList[index].type == 'textHeader' || index == 0
                ? Colors.transparent
                : lineColor,
          ),
        );
      },
    );
  }

  Widget _titleItem(Item item) {
    return Container(
      decoration: BoxDecoration(color: Colors.white24),
      padding: EdgeInsets.only(top: 15, bottom: 5),
      child: Center(
        child: Text(
          item.data.text,
          style: TextStyle(
              fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _banner(model) {
    return Container(
      height: 200,
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BannerWidget(
          model: model,
        ),
      ),
    );
  }

}
