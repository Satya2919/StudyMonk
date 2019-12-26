
import '../screens/main_page.dart';
import '../screens/settings_page.dart';
import '../screens/profile_page.dart';
import '../screens/clubs_page.dart';
import '../screens/team_page.dart';
import '../screens/status_page.dart';
import '../screens/todo_page.dart';
import '../todoScreen/screens/note_list.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<MainPage>(() => MainPage());
    register<SettingsPage>(() => SettingsPage());
    register<ProfilePage>(() => ProfilePage());
    register<ClubPage>(() => ClubPage());
    register<TeamPage>(() => TeamPage());
    register<StatusPage>(() => StatusPage());
    register<TodoPage>(() => TodoPage());
    register<NoteList>(() => NoteList());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}
