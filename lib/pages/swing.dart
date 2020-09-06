import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/account/account_bloc.dart';
import 'package:trikcuan_app/core/bloc/account/account_event.dart';
import 'package:trikcuan_app/core/bloc/account/account_state.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_bloc.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/recomendation/recomendation_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/core/model/recomendation_price_model.dart';
import 'package:trikcuan_app/pages/recomendation_detail.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/text.dart';

class Swing extends StatefulWidget {
  const Swing({Key key}) : super(key: key);

  @override
  _SwingState createState() => _SwingState();
}

class _SwingState extends State<Swing> {

  List<RecomendationModel> data = <RecomendationModel>[];
  final bloc = RecomendationBloc();
  bool isLoading = true;
  bool showRecomendation = true;
  RecomendationPriceModel price;
  final RefreshController refreshController = RefreshController();
  
  final accountBloc = AccountBloc();
  Account account;

  @override
  void initState() {
    bloc.add(LoadRecomendationToday());
    accountBloc.add(GetAccount());
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
            } else if(state is RecomendationTodayLoaded) {
              final haveRecomendationToday = state.data.firstWhere((item) => item.recomendationType == "swing", orElse: () => null);
              if(haveRecomendationToday != null) {
                print("SUDAH BELI");
                bloc.add(LoadRecomendation(type: "swing"));
                setState(() {
                  showRecomendation = true;
                });
              } else {
                print("BELUM BELI");
                bloc.add(LoadRecomendationPrice());
                setState(() {
                  showRecomendation = false;
                });
              }
            } else if(state is RecomendationPriceLoaded) {
              refreshController.refreshCompleted();
              setState(() {
                isLoading = false;
                price = state.data.firstWhere((item) => item.recomendation == "swing");
              });
            } else if(state is RecomendationFailure) {
              Toast.show(state.error, context);
              setState(() {
                isLoading = false;
                refreshController.refreshCompleted();
              });
            }
          }
        ),
        BlocListener(
          cubit: accountBloc,
          listener: (context, state) {
            if(state is AccountSuccess) {
              setState(() {
                account = state.data;
              });
            }
          }
        )
      ],
      child: showRecomendation ? SmartRefresher(
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
                  type: "swing",
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
      ) : Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextCustom(
              "Silahkan bayar untuk melihat rekomendasi saham hari ini ", 
              textAlign: TextAlign.center, 
              fontSize: 18,
              maxLines: 3
            ),
            SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButtonPrimary(
                isLoading: isLoading,
                onPressed: int.parse(account?.balance) < int.parse(price?.price) ? null : (){
                  setState(() {
                    isLoading = true;
                    bloc.add(BuyRecomendation(
                      recomendation: "swing",
                      type: "recomendation"
                    ));
                  });
                },
                text: rupiah(price?.price)
              ),
            ),
            SizedBox(height: 16),
            int.parse(account?.balance) < int.parse(price?.price) ? TextCustom("Saldo Anda ${rupiah(account?.balance)} tidak cukup", color: Colors.red) : Text("")
          ],
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
    bloc.add(LoadRecomendation(type: "swing"));
    setState(() {
      isLoading = true;
    });
  }
}