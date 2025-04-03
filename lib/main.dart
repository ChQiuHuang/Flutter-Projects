import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyProjectsFlutter());
}

class MyProjectsFlutter extends StatelessWidget {
  const MyProjectsFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的作品清單',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyProjectsPage(),
    );
  }
}

class MyProjectsPage extends StatefulWidget {
  const MyProjectsPage({super.key});

  @override
  _MyProjectsPageState createState() => _MyProjectsPageState();
}

class _MyProjectsPageState extends State<MyProjectsPage> {
  late Future<Map<String, dynamic>> _projects;

  @override
  void initState() {
    super.initState();
    _projects = fetchProjects();
  }

  Future<Map<String, dynamic>> fetchProjects() async {
    final response = await http.get(Uri.parse(
        'https://getpantry.cloud/apiv1/pantry/dd9b1690-a702-4a1f-908a-9fb8d77614aa/basket/patha'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('列表載入失敗');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('作品清單'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _projects,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No projects found'));
                }

                final projects = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: projects.entries.map((entry) {
                    final projectName = entry.key;
                    final project = entry.value;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text(
                          projectName,
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            '程式語言: ${project['Language'] ?? '未知'}'),
                        isThreeLine: true,
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('進度: ${project['Progress'] ?? '未知'}'),
                            const SizedBox(height: 8.0),
                            project['Git Address'] != null
                                ? TextButton(
                                    onPressed: () =>
                                        _launchURL(project['Git Address']),
                                    child: const Text('在 Github 開啟',
                                        style: TextStyle(color: Colors.blue)),
                                  )
                                : const Text('No Git Address'),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info, color: Theme.of(context).colorScheme.onPrimaryContainer),
                const SizedBox(width: 8.0),
                Text(
                  'This Project is made possible by Vercel and Pantry',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
