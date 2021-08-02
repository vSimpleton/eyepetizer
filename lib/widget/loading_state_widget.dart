import 'package:eyepetizer/config/color.dart';
import 'package:eyepetizer/config/string.dart';
import 'package:flutter/material.dart';

enum ViewState { loading, done, error }

class LoadingStateWidget extends StatelessWidget {
  final ViewState viewState;
  final VoidCallback retry;
  final Widget child;

  const LoadingStateWidget(
      {Key? key, this.viewState = ViewState.loading, required this.retry, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (viewState == ViewState.loading) {
      return _loadView;
    } else if (viewState == ViewState.error) {
      return _errorView;
    } else {
      return child;
    }
  }

  Widget get _loadView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget get _errorView {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/ic_error.png',
            width: 100,
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              StringConfig.net_request_fail,
              style: TextStyle(color: ColorConfig.hitTextColor, fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: retry,
              child: Text(
                StringConfig.reload_again,
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                overlayColor: MaterialStateProperty.all(Colors.black12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
