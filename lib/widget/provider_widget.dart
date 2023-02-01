import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {

  final T viewModel;
  final Widget child;
  final Function(T) onModelInit;
  final Widget Function(BuildContext context, T viewModel, Widget child) builder;

  ProviderWidget({Key key, @required this.viewModel, this.child, this.onModelInit, @required this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProviderWidgetState<T>();

}

class _ProviderWidgetState<T extends ChangeNotifier> extends State<ProviderWidget<T>> {

  T viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel;
    if (widget.onModelInit != null) {
      widget.onModelInit(viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }

}