/*
 * TODO: Internationalization implementation
 * - https://docs.flutter.dev/development/accessibility-and-localization/internationalization
 */
class StringConstant {
  // Application
  static const String appName = "Our Emoji Chatting";

  // Routes
  static const String routeLogin = '/';
  static const String routeMain = '/main';
  static const String routeSearchPerson = '/search';
  static const String routeSelectPhoto = '/select_photo';

  static BottomNavigationBarItemNames bottomNavigationBarItemNames =
      BottomNavigationBarItemNames();
  static Messages messages = Messages();
  static ChatScreen chatScreen = ChatScreen();
  static ProfileScreen profileScreen = ProfileScreen();
  static SettingsScreen settingsScreen = SettingsScreen();
}

class BottomNavigationBarItemNames {
  String get chatting => 'Chatting';
  String get profile => 'Profile';
  String get settings => 'settings';
}

class Messages {
  String get widgetNotFound => 'Widget not found';
  String get loggedOut => 'Logged out';
}

class ChatScreen {
  String get sendMessageHint => 'Type a message...';
}

class ProfileScreen {
  String get chatName => 'Chatting name';
  String get personalIdentifier => 'Personal identifier';
  String get oppositeIdentifier => 'Opposite identifier';
}

class SettingsScreen {
  String get catLockApplication => 'Lock application';
  String get setUsingPattern => 'Use pattern';
  String get changePattern => 'Change pattern';
  String get setUsingFingerprint => 'Use fingerprint';

  String get catAccount => 'Account';
  String get logout => 'Logout';
}
