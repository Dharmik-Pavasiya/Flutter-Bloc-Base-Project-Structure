import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CustomStatelessScreen<B extends StateStreamableSource<Object?>>
    extends StatelessWidget {
  const CustomStatelessScreen({super.key});

  /// Create the BLoC to be used in this screen
  B? createBloc(BuildContext context) => null;

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
  Widget build(BuildContext context) {
    final bloc = createBloc(context); // call once and store it

    final bodyContent =
        wrapWithSafeArea()
            ? SafeArea(child: buildBody(context))
            : buildBody(context);

    final child = Scaffold(
      appBar: buildAppBar(context),
      body: bodyContent,
      bottomNavigationBar: buildBottomNavigationBar(context),
      floatingActionButton: buildFloatingActionButton(context),
      drawer: buildDrawer(context),
      backgroundColor: backgroundColor(context),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
    );

    if (bloc == null) {
      return child;
    } else {
      return BlocProvider<B>(create: (context) => bloc, child: child);
    }
  }
}
