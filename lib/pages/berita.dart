import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/news/news_bloc.dart';
import 'package:trikcuan_app/core/bloc/news/news_event.dart';
import 'package:trikcuan_app/core/bloc/news/news_state.dart';
import 'package:trikcuan_app/core/model/news_model.dart';
import 'package:trikcuan_app/pages/webview_page.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/text.dart';

class Berita extends StatefulWidget {
  const Berita({Key key}) : super(key: key);

  @override
  _BeritaState createState() => _BeritaState();
}

class _BeritaState extends State<Berita> {

  List<NewsModel> data = <NewsModel>[];
  final bloc = NewsBloc();
  bool isLoading = true;
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    bloc.add(LoadNews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener(
              cubit: bloc,
              listener: (context, state) {
                if(state is NewsLoaded) {
                  setState(() {
                    refreshController.refreshCompleted();
                    isLoading = false;
                    data = state.data;
                  });
                } else if(state is NewsFailure) {
                  Toast.show(state.error, context);
                  setState(() {
                    isLoading = false;
                    refreshController.refreshCompleted();
                  });
                }
              }
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amberAccent,
            title: Text('BERITA', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),),
          ),
          body: SmartRefresher(
            controller: refreshController,
            onRefresh: () => onRefresh(),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: isLoading ? 3 : data.length,
              itemBuilder: (context, index) {
                return isLoading ? shimmerData(context) : Box(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => WebViewPage(news: data[index])
                  )),
                  padding: 16,
                  color: Colors.white,
                  child: TitleText(data[index].title, maxLines: 3),
                );
              },
            ),
          ),
        )
    );
  }

  Shimmer shimmerData(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Box(
                width: MediaQuery.of(context).size.width,
                height: 8,
                borderRadius: 8
            ),
          ],
        ),
      ),
    );
  }

  onRefresh() {
    bloc.add(LoadNews());
    setState(() {
      isLoading = true;
    });
  }
}