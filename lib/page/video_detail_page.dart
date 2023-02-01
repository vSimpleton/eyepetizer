import 'package:eyepetizer/config/string.dart';
import 'package:eyepetizer/model/issue.dart';
import 'package:eyepetizer/utils/date_util.dart';
import 'package:eyepetizer/utils/image_loader.dart';
import 'package:eyepetizer/utils/route_util.dart';
import 'package:eyepetizer/utils/toast_util.dart';
import 'package:eyepetizer/viewmodel/video_detail_view_model.dart';
import 'package:eyepetizer/widget/loading_state_widget.dart';
import 'package:eyepetizer/widget/provider_widget.dart';
import 'package:eyepetizer/widget/video/video_item_widget.dart';
import 'package:eyepetizer/widget/video/video_play_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

class VideoDetailPage extends StatefulWidget {
  final Data videoDta;

  const VideoDetailPage({Key key, this.videoDta}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver {
  final GlobalKey<VideoPlayWidgetState> videoKey = GlobalKey();
  Data data;

  @override
  void initState() {
    super.initState();
    data = widget.videoDta == null ? getArguments() : widget.videoDta;
    //监听页面可见与不可见状态
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // AppLifecycleState当前页面的状态(是否可见)
    if (state == AppLifecycleState.paused) {
      // 页面不可见时,暂停视频
      // videoKey.currentState：树中当前具有此全局密钥的小部件的State对象
      videoKey.currentState.pause();
    } else if (state == AppLifecycleState.resumed) {
      videoKey.currentState.play();
    }
  }

  @override
  void dispose() {
    //移除监听页面可见与不可见状态
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoDetailViewModel>(
      viewModel: VideoDetailViewModel(),
      onModelInit: (model) => model.loadVideoData(data.id),
      builder: (context, model, child) {
        return _scaffold(model);
      },
    );
  }

  Widget _scaffold(model) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AnnotatedRegion(
            child: _statusBar(),
            value: SystemUiOverlayStyle.light,
          ),
          Hero(
            tag: '${data.id}${data.time}',
            child: VideoPlayWidget(
              key: videoKey,
              url: data.playUrl,
            ),
          ),
          Expanded(
            flex: 1,
            child: LoadingStateWidget(
              viewState: model.viewState,
              retry: model.retry,
              child: Container(
                decoration: _decoration(),
                child: CustomScrollView(
                  slivers: <Widget>[
                    _sliverToBoxAdapter(),
                    _sliverList(model),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 设置状态栏的背景色为黑色
  _statusBar() {
    return Container(
      height: MediaQuery.of(context).padding.top,
      color: Colors.black,
    );
  }

  /// 设置背景色
  Decoration _decoration() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: cachedNetworkImageProvider(
            '${data.cover.blurred}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}'),
      ),
    );
  }

  /// SliverToBoxAdapter：与CustomScrollView配合使用，包含普通组件（CustomScrollView只能包含sliver系列组件）
  Widget _sliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _videoTitle(),
          _videoTime(),
          _videoDescription(),
          _videoState(),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: _videoAuthor(),
          ),
        ],
      ),
    );
  }

  /// 视频标题
  Widget _videoTitle() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Text(
        data.title,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// 视频分类及上架时间
  Widget _videoTime() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Text(
        '#${data.category} / ${formatDateMsByYMDHM(data.author.latestReleaseTime)}',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  /// 视频描述
  Widget _videoDescription() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Text(
        data.description,
        style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
      ),
    );
  }

  /// 视频的状态：点赞，转发，评论
  Widget _videoState() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: <Widget>[
          _row('images/ic_like.png', '${data.consumption.collectionCount}'),
          SizedBox(
            width: 30,
          ),
          _row('images/ic_share_white.png', '${data.consumption.shareCount}'),
          SizedBox(
            width: 30,
          ),
          _row('images/icon_comment.png', '${data.consumption.replyCount}'),
        ],
      ),
    );
  }

  Widget _row(String image, String text) {
    return Row(
      children: <Widget>[
        Image.asset(
          image,
          height: 22,
          width: 22,
        ),
        InkWell(
          onTap: () {
            Toast.showToast(tips);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 3),
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  /// 视频作者等介绍
  Widget _videoAuthor() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: ClipOval(
            child: cacheImage(data.author.icon, height: 40, width: 40),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(data.author.name,
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(
                  data.author.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Toast.showToast(tips);
          },
          child: Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
              child: Text(
                '+ 关注',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ),
        )
      ],
    );
  }

  /// 推荐其他视频
  Widget _sliverList(model) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (model.itemList[index].type == VIDEO_SMALL_CARD_TYPE) {
            return VideoItemWidget(
              data: model.itemList[index].data,
              callBack: () {
                Navigator.pop(context);
                toPage(VideoDetailPage(videoDta: model.itemList[index].data));
              },
            );
          }
          return Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Text(
              model.itemList[index].data.text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          );
        },
        childCount: model.itemList.length,
      ),
    );
  }
}
