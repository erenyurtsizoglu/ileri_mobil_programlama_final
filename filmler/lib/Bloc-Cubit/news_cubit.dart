import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

part 'news_state.dart';

class FilmsCubit extends Cubit<FilmsState> {
  FilmsCubit() : super(FilmsInitial());

  final ImagePicker _picker = ImagePicker();

  Future<void> loadFilmss() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/myfilms.json');
      if (file.existsSync()) {
        final content = await file.readAsString();
        final List<dynamic> jsonData = json.decode(content);
        final myfilms = jsonData.map((data) => Films.fromJson(data)).toList();
        emit(FilmsLoaded(myfilms));
      } else {
        emit(FilmsLoaded([]));
      }
    } catch (e) {
      emit(FilmsError(e.toString()));
    }
  }

  Future<void> addFilms() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/myfilms.json');
      final post = Films(
        imageUrl: pickedFile.path,
        stars: '0',
      );
      final currentState = state;
      if (currentState is FilmsLoaded) {
        final updatedFilmss = List<Films>.from(currentState.myfilms)..insert(0, post);
        await file.writeAsString(json.encode(updatedFilmss.map((p) => p.toJson()).toList()));
        emit(FilmsLoaded(updatedFilmss));
      }
    }
  }
}
