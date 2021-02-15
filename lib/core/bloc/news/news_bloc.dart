import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trikcuan_app/core/api/news_api.dart';
import 'package:trikcuan_app/core/bloc/news/news_event.dart';
import 'package:trikcuan_app/core/bloc/news/news_state.dart';
import 'package:trikcuan_app/core/model/news_model.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final api = NewsApi();

  NewsBloc() : super(NewsUninitialized());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (event is LoadNews) {
      yield NewsLoading();
      try {
        var pref = prefs.getString("news");
        if(pref != null) yield NewsLoaded(data: newsModelFromMap(pref));
        final response = await api.getData();
        prefs.setString("news", newsModelToMap(response));
        yield NewsLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield NewsFailure(error: error.toString());
      }
    }

  }
}