import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_bloc.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_state.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/core/model/recomendation_price_model.dart';
import 'package:trikcuan_app/pages/recomendation_detail.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/text.dart';

class Dividen extends StatefulWidget {
  const Dividen({Key key}) : super(key: key);

  @override
  _DividenState createState() => _DividenState();
}

class _DividenState extends State<Dividen> {

  List<RecomendationModel> data = <RecomendationModel>[];
  final bloc = RecomendationBloc();
  bool isLoading = true;
  bool showRecomendation = true;
  RecomendationPriceModel price;
  final RefreshController refreshController = RefreshController();
  
  @override
  void initState() {
    bloc.add(LoadRecomendation(type: "dividen"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: bloc,
          listener: (context, state) {
            if(state is RecomendationTradingLoaded) {
              setState(() {
                refreshController.refreshCompleted();
                isLoading = false;
                data = state.data;
              });
            } else if(state is RecomendationFailure) {
              Toast.show(state.error, context);
              setState(() {
                isLoading = false;
                refreshController.refreshCompleted();
              });
            }
          }
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF009eeb),
          leading: Icon(Icons.arrow_back_ios, color: Color(0xFF009eeb)),
          title: Text('SAHAM LQ 45', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
                  builder: (context) => RecomendationDetailpage(
                    recomendation: data[index],
                    type: "trading",
                  )
                )),
                padding: 16,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextCustom(
                      data[index].kodeSaham,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText("Potensi"),
                        TextCustom(
                          data[index].potensiKenaikan,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }, 
          ),
        )
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
    bloc.add(LoadRecomendation(type: "trading"));
    setState(() {
      isLoading = true;
    });
  }
}