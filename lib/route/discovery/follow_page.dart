import 'package:eyepetizer/base/base_list_state.dart';
import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/viewmodel/follow_viewmodel.dart';
import 'package:eyepetizer/widget/follow_item_widget.dart';
import 'package:flutter/material.dart';

class FollowPage extends StatefulWidget {
  const FollowPage({Key key}) : super(key: key);

  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState
    extends BaseListState<Item, FollowViewModel, FollowPage> {

  @override
  Widget getContentChild(FollowViewModel model) => ListView.separated(
        separatorBuilder: (context, index) => Divider(height: 0.5),
        itemCount: model.itemList.length,
        itemBuilder: (context, index) {
          return FollowItemWidget(item: model.itemList[index]);
        },
      );

  @override
  get viewModel => FollowViewModel();
}
