import 'package:azlistview/azlistview.dart';

class MyBean implements ISuspensionBean {
  final String name;

  MyBean({required this.name}) : isShowSuspension = false;

  @override
  String getSuspensionTag() => name[0];

  @override
  bool isShowSuspension;
}
