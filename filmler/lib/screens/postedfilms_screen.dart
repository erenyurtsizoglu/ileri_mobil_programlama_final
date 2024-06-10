import 'package:filmler/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc-Cubit/news_cubit.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../language_notifier.dart';

class PostedFilmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilmsCubit()..loadFilmss(),
      child: PostedFilmsView(),
    );
  }
}

class PostedFilmsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageNotifier = Provider.of<LanguageNotifier>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(languageNotifier.isEnglish ? 'My shared movies' :'Paylaştığım Filmler'),
      ),
      body: BlocBuilder<FilmsCubit, FilmsState>(
        builder: (context, state) {
          if (state is FilmsInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FilmsLoaded) {
            if (state.myfilms.isEmpty) {
              return Center(child: Text(languageNotifier.isEnglish ? 'You havent shared any movie posters yet. \nYou can share by tapping the button at the bottom right. \nYour shares are kept within the application.' :'Hiç film afişi paylaşmadınız.\nSağ alttaki butona basarak paylaşım yapabilirsiniz.\nPaylaşımlarınız uygulama içinde tutulur.'));
            }
            return ListView.builder(
              itemCount: state.myfilms.length,
              itemBuilder: (context, index) {
                final post = state.myfilms[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                      Image.file(File(post.imageUrl)),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            SizedBox(width: 4),
                            Text('${post.stars}'),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is FilmsError) {
            return Center(child: Text('Hata: ${state.message}'));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<FilmsCubit>().addFilms(),
        child: Text(languageNotifier.isEnglish ? 'Add' :'Ekle'),
      ),
    );
  }
}
