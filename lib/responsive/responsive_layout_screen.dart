import 'package:flutter/cupertino.dart';
import 'package:instagram/providers/user_providers.dart';
import 'package:instagram/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }


  addData() async{
    UserProvider userProvider = Provider.of(context,listen: false);
    await userProvider.refreshUser();
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth > webScreenSize) {
        return widget.webScreenLayout;

        //web Screen
      } else {
        // mobile screen
        return widget.mobileScreenLayout;
      }
    });
  }
}
