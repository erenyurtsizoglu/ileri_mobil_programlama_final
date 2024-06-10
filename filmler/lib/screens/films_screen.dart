import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../drawer.dart';
import '../filmjson.dart';
import '../language_notifier.dart';
import 'theme_notifier.dart';

class FilmsScreen extends StatefulWidget {
  @override
  _FilmsScreenState createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsScreen> {
  List<Film> films = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFilms();
  }

  Future<void> _loadFilms() async {
    final languageNotifier = Provider.of<LanguageNotifier>(context, listen: false);
    final String jsonPath = languageNotifier.isEnglish ? 'assets/filmsEnglish.json' : 'assets/films.json';

    final String response = await rootBundle.loadString(jsonPath);
    final List<dynamic> data = json.decode(response);

    setState(() {
      films = data.map((json) => Film.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(languageNotifier.isEnglish ? 'Shared Movies' : 'Paylaşılan Filmler'),
      ),
      drawer: AppDrawer(),
      body: films.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              languageNotifier.isEnglish ? 'Below is a list of all movies' : 'Aşağıda Tüm Filmler Listelenmektedir',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: films.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(films[index].imageUrl),
                        SizedBox(height: 10),
                        Text(
                          films[index].film,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            SizedBox(width: 4),
                            Text(films[index].star.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
