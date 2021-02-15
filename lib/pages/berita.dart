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

class NewsPage extends StatefulWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

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
            centerTitle: true,
            backgroundColor: Color(0xFF009eeb),
            leading: Icon(Icons.arrow_back_ios, color: Color(0xFF009eeb)),
            title: Text('BERITA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(data[index].linkImage, width: 80, height: 60, fit: BoxFit.cover)
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextCustom(
                          data[index].title, 
                          maxLines: 3,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                    ],
                  ),
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