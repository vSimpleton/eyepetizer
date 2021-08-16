import 'package:animations/animations.dart';
import 'package:eyepetizer/base/base_list_state.dart';
import 'package:eyepetizer/model/discovery/topic_model.dart';
import 'package:eyepetizer/route/discovery/topic_detail_page.dart';
import 'package:eyepetizer/utils/cache_image.dart';
import 'package:eyepetizer/viewmodel/topic_page_viewmodel.dart';
import 'package:flutter/material.dart';

class TopicPage extends StatefulWidget {
  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState
    extends BaseListState<TopicItemModel, TopicPageViewModel, TopicPage> {
  @override
  Widget getContentChild(TopicPageViewModel model) {
    return ListView.builder(
      itemCount: model.itemList.length,
      itemBuilder: (context, index) {
        return OpenContainer(
          closedBuilder: (context, action) {
            return _closedWidget(model.itemList[index]);
          },
          openBuilder: (context, action) {
            return TopicDetailPage(detailId: model.itemList[index].data.id);
          },
        );
      },
    );
  }

  Widget _closedWidget(item) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        child: cacheImage(
          item.data.image,
          width: MediaQuery.of(context).size.width,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  TopicPageViewModel get viewModel => TopicPageViewModel();
}
