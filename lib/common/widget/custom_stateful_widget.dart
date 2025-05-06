import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CustomStatefulWidget<B extends StateStreamableSource<Object?>>
    extends StatefulWidget {
  const CustomStatefulWidget({super.key});

  /// Create the BLoC to be used in this screen
  B? createBloc(BuildContext context) => null;

  void initState() {}

  void dispose() {}

  void didChangeDependencies() {}

  void setState(VoidCallback fn) {}

  void deactivate() {}

  void activate() {}

  void reassemble() {}

  /// Customize the app bar
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// Customize the body
  Widget buildBody(BuildContext context);

  /// Customize the bottom navigation bar
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  /// Customize the floating action button
  Widget? buildFloatingActionButton(BuildContext context) => null;

  /// Customize the drawer
  Widget? buildDrawer(BuildContext context) => null;

  /// Background color
  Color? backgroundColor(BuildContext context) => Colors.white;

  /// Keyboard inset handling
  bool resizeToAvoidBottomInset() => true;

  /// Whether to wrap the body in a SafeArea
  bool wrapWithSafeArea() => true;

  @override
  _CustomStatefulWidgetState<B> createState() =>
      _CustomStatefulWidgetState<B>();
}

class _CustomStatefulWidgetState<B extends StateStreamableSource<Object?>>
    extends State<CustomStatefulWidget<B>> {
  late B? _bloc;

  @override
  void initState() {
    super.initState();
    widget.initState();
    _bloc = widget.createBloc(context);
  }

  @override
  void dispose() {
    widget.dispose();
    _bloc?.close(); // Close the BLoC when the widget is disposed
    super.dispose();
  }

  @override
  void activate() {
    widget.activate();
    super.activate();
  }

  @override
  void didChangeDependencies() {
    widget.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void setState(VoidCallback fn) {
    widget.setState(fn);
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final bodyContent =
        widget.wrapWithSafeArea()
            ? SafeArea(child: widget.buildBody(context))
            : widget.buildBody(context);

    final child = Scaffold(
      appBar: widget.buildAppBar(context),
      body: bodyContent,
      bottomNavigationBar: widget.buildBottomNavigationBar(context),
      floatingActionButton: widget.buildFloatingActionButton(context),
      drawer: widget.buildDrawer(context),
      backgroundColor: widget.backgroundColor(context),
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset(),
    );

    if (_bloc == null) {
      return child;
    } else {
      return BlocProvider<B>(
        create: (context) => _bloc!,
        child: Builder(builder: (context) => child),
      );
    }
  }
}
