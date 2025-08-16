
part of 'home_tab.dart';

mixin _HomeListenersMixin<T extends StatefulWidget> on State<T>{

  void _profileListener(BuildContext ctx, ProfileManageState profileState) {
    if (profileState.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(profileState.error!)),
      );
    }
  }


}