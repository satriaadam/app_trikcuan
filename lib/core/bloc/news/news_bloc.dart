import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:trikcuan_app/core/api/news_api.dart';
import 'package:trikcuan_app/core/bloc/news/news_event.dart';
import 'package:trikcuan_app/core/bloc/news/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final api = NewsApi();

  NewsBloc() : super(NewsUninitialized());

  @override
  Stream<NewsState> mapEventToState(
      NewsEvent event,
      ) async* {

    if (event is LoadNews) {
      yield NewsLoading();
      try {
        final response = await api.getData();
        yield NewsLoaded(data: response);
      } catch (error) {
        print("ERROR: $error");
        yield NewsFailure(error: error.toString());
      }
    }

  }
}