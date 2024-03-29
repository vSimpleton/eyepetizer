import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/utils/date_util.dart';
import 'package:eyepetizer/utils/image_loader.dart';
import 'package:flutter/material.dart';

class VideoItemWidget extends StatelessWidget {
  final Data data;
  final VoidCallback callBack;

  // 是否开启hero动画，默认为false
  final bool openHero;
  final Color titleColor;
  final Color categoryColor;

  const VideoItemWidget(
      {Key key,
      this.data,
      this.callBack,
      this.titleColor = Colors.white,
      this.categoryColor = Colors.white,
      this.openHero = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callBack();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Row(
          children: <Widget>[
            _videoImage(),
            _videoText(),
          ],
        ),
      ),
    );
  }

  /// 左边图片显示设置
  Widget _videoImage() {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: _coverWidget(),
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(color: Colors.black54),
              padding: EdgeInsets.all(3),
              child: Text(
                formatDateMsByMS(data.duration * 1000),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _coverWidget() {
    if (openHero) {
      return Hero(
        tag: '${data.id}${data.time}',
        child: _imageWidget(),
      );
    } else {
      return _imageWidget();
    }
  }

  Widget _imageWidget() {
    return cacheImage(
      data.cover.detail,
      width: 135,
      height: 80,
    );
  }

  /// 右边文字显示设置
  Widget _videoText() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data.title,
              style: TextStyle(
                  color: titleColor, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                '#${data.category} / ${data.author?.name}',
                style: TextStyle(color: categoryColor, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
