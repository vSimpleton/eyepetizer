import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/utils/date_util.dart';
import 'package:eyepetizer/utils/image_loader.dart';
import 'package:eyepetizer/utils/route_util.dart';
import 'package:eyepetizer/utils/share_util.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {

  final Item item;
  final bool showCategory; // 是否显示左上角分类文字：默认显示

  const ListItemWidget({Key key, @required this.item, this.showCategory = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            toNamed('/detail', item.data);
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Stack(
              children: <Widget>[
                _clipRRectImage(context),
                _categoryText(),
                _videoTime(),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
          child: Row(
            children: <Widget>[
              _authorHeaderImage(item),
              _videoDescription(),
              _shareButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _clipRRectImage(context) {
    return ClipRRect(
      child: Hero(
        tag: '${item.data.id}${item.data.time}',
        child: cacheImage(
          item.data.cover.feed,
          width: MediaQuery.of(context).size.width,
          height: 200,
        ),
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }

  /// 图片左上角显示图标，视频所属分类
  Widget _categoryText() {
    return Positioned(
      left: 15,
      top: 10,
      child: Visibility(
        visible: showCategory ? true : false,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          height: 44,
          width: 44,
          alignment: AlignmentDirectional.center,
          child: Text(
            item.data.category,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }

  /// 图片右下角显示视频总时长
  Widget _videoTime() {
    return Positioned(
      right: 15,
      bottom: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(color: Colors.black54),
          padding: EdgeInsets.all(5),
          child: Text(
            formatDateMsByMS(item.data.duration * 1000),
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// 作者的头像
  Widget _authorHeaderImage(Item item) {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: cacheImage(
        item.data.author == null
            ? item.data.provider.icon
            : item.data.author.icon,
        width: 40,
        height: 40,
      ),
    );
  }

  /// 视频内容简介
  Widget _videoDescription() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(item.data.title,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis),
            Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                    item.data.author == null
                        ? item.data.description
                        : item.data.author.name,
                    style: TextStyle(color: Color(0xff9a9a9a), fontSize: 12)))
          ],
        ),
      ),
    );
  }

  /// 分享按钮
  Widget _shareButton() {
    return IconButton(
      icon: Icon(Icons.share, color: Colors.black38),
      onPressed: () => share(item.data.title, item.data.playUrl),
    );
  }
}
