import 'package:eyepetizer/utils/image_loader.dart';
import 'package:eyepetizer/utils/route_util.dart';
import 'package:eyepetizer/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerWidget extends StatelessWidget {
  final HomeViewModel model;

  const BannerWidget({Key key, @required this.model}) : super(key: key);

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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: cachedNetworkImageProvider(
                      model.bannerLists[index].data.cover.feed),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              width: MediaQuery.of(context).size.width - 20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
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

      pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        builder: DotSwiperPaginationBuilder(
            size: 5,
            activeSize: 5,
            activeColor: Colors.white,
            color: Colors.white24),
      ),
    );
  }

}
