import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}

class User {
  final String id;
  final String name;
  final String title;

  User(this.id, this.name, this.title);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tittle': title,
    };
  }
}

class ApiScreen extends StatefulWidget {
  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<User> userList = [];
  List<User> savedUserList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    loadSavedUserList();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://64642e77043c103502b42776.mockapi.io/user'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userList = List<User>.from(
            data.map((user) => User(user['id'], user['name'], user['tittle'])));
      });
    }
  }

  Future<void> loadSavedUserList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedUserListJson = prefs.getStringList('savedUserList');
    if (savedUserListJson != null) {
      setState(() {
        savedUserList = savedUserListJson.map((userJson) {
          final userMap = json.decode(userJson);
          return User(userMap['id'], userMap['name'], userMap['tittle']);
        }).toList();
      });
    }
  }

  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedUserList.add(user);
    List<String> savedUserListJson =
        savedUserList.map((user) => json.encode(user.toJson())).toList();
    prefs.setStringList('savedUserList', savedUserListJson);
  }

  Future<void> removeUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedUserList.remove(user);
    List<String> savedUserListJson =
        savedUserList.map((user) => json.encode(user.toJson())).toList();
    prefs.setStringList('savedUserList', savedUserListJson);
  }

  bool isUserSaved(User user) {
    return savedUserList.any((savedUser) => savedUser.id == user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Data'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SavedUserListScreen(savedUserList: savedUserList),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {
              NotificationService()
                  .showNotification(title: 'Sample title', body: 'It works!');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.title),
            trailing: IconButton(
              icon: Icon(
                isUserSaved(user) ? Icons.favorite : Icons.favorite_border,
                color: isUserSaved(user) ? Colors.red : null,
              ),
              onPressed: () async {
                if (isUserSaved(user)) {
                  removeUser(user);
                } else {
                  saveUser(user);
                }
                setState(() {});
              },
            ),
          );
        },
      ),
    );
  }
}

class SavedUserListScreen extends StatelessWidget {
  final List<User> savedUserList;

  SavedUserListScreen({required this.savedUserList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Users'),
      ),
      body: ListView.builder(
        itemCount: savedUserList.length,
        itemBuilder: (context, index) {
          final user = savedUserList[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(user: user),
                ),
              );
            },
            title: Text(user.name),
            subtitle: Text(user.title),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final User user;

  DetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User ID: ${user.id}'),
          Text('User Name: ${user.name}'),
          Text('User Title: ${user.title}'),
        ],
      ),
    );
  }
}
