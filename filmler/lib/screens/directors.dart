import 'dart:convert';
import 'package:filmler/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../director.dart';
import '../language_notifier.dart';

class DirectorsScreen extends StatefulWidget {
  @override
  _DirectorsScreenState createState() => _DirectorsScreenState();
}

class _DirectorsScreenState extends State<DirectorsScreen> {
  List<Director> directors = [];

  @override
  void initState() {
    super.initState();
    _fetchDirectors();
  }

  Future<void> _fetchDirectors() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];

      setState(() {
        directors = data.map((json) => Director.fromJson(json)).toList().reversed.toList();
      });
    } else {
      throw Exception('Failed to load directors');
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(languageNotifier.isEnglish ? 'Directors' : 'Yönetmenler'),
      ),
      body: directors.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: directors.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    directors[index].avatar,
                    width: 130,
                    height: 130,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Text(
                            '${directors[index].firstName} ${directors[index].lastName}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(directors[index].email),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
