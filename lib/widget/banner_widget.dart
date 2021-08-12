import 'package:eyepetizer/route/home/video/video_detail_page.dart';
import 'package:eyepetizer/utils/cache_image.dart';
import 'package:eyepetizer/utils/navigator_util.dart';
import 'package:eyepetizer/viewmodel/home_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidget extends StatelessWidget {
  final HomePageViewModel model;

  const BannerWidget({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: model.bannerLists?.length ?? 0,
      autoplay: true,
      onTap: (index) {
        toNamed("/detail", model.bannerLists[index].data);
      },
      itemBuilder: (context, index) {
        return Stack(
          children: <Widget>[
            Container(
              // decoration:装饰,设置子控件的背景颜色、形状等
              decoration: BoxDecoration(
                image: DecorationImage(
                  // 网络获取图片
                  image: cachedNetworkImageProvider(
                      model.bannerLists[index].data.cover.feed),
                  // 图片显示样式,类似Android缩放设置
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // banner底部透明黑条
            Positioned(
              // 默认显示内容宽度
              width: MediaQuery.of(context).size.width - 20,
              // 放于底部
              bottom: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                // decoration:装饰,设置子控件的背景颜色、形状等
                decoration: BoxDecoration(color: Colors.black12),
                child: Text(
                  model.bannerLists[index].data.title,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )
          ],
        );
      },
      // banner 指示器
      pagination: SwiperPagination(
        // 位置：右下角
        alignment: Alignment.bottomRight,
        // 指示器的样式
        builder: DotSwiperPaginationBuilder(
            size: 5,
            activeSize: 5,
            activeColor: Colors.white,
            color: Colors.white24),
      ),
    );

  }
}
