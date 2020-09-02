import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/account/account_bloc.dart';
import 'package:trikcuan_app/core/bloc/account/account_event.dart';
import 'package:trikcuan_app/core/bloc/account/account_state.dart';
import 'package:trikcuan_app/core/bloc/market/market_bloc.dart';
import 'package:trikcuan_app/core/bloc/market/market_event.dart';
import 'package:trikcuan_app/core/bloc/market/market_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/core/model/market_model.dart';
import 'package:trikcuan_app/core/model/market_price_model.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/text.dart';

class Index extends StatefulWidget {
  const Index({Key key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  List<MarketModel> data = <MarketModel>[];
  final bloc = MarketBloc();
  bool isLoading = true;
  bool showMarket = true;
  MarketPriceModel price;
  final RefreshController refreshController = RefreshController();

  final accountBloc = AccountBloc();
  Account account;

  @override
  void initState() {
    bloc.add(LoadMarketToday());
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
                if(state is MarketTradingLoaded) {
                  setState(() {
                    refreshController.refreshCompleted();
                    isLoading = false;
                    data = state.data;
                  });
                } else if(state is MarketTodayLoaded) {
                  final haveMarketToday = state.data.firstWhere((item) => item.marketType == "index", orElse: () => null);
                  if(haveMarketToday != null) {
                    print("SUDAH BELI");
                    bloc.add(LoadMarket(type: "index"));
                    setState(() {
                      showMarket = true;
                    });
                  } else {
                    print("BELUM BELI");
                    bloc.add(LoadMarketPrice());
                    setState(() {
                      showMarket = false;
                    });
                  }
                } else if(state is MarketPriceLoaded) {
                  refreshController.refreshCompleted();
                  setState(() {
                    isLoading = false;
                    price = state.data.firstWhere((item) => item.market == "index");
                  });
                } else if(state is MarketFailure) {
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
        child: showMarket ? SmartRefresher(
          controller: refreshController,
          onRefresh: () => onRefresh(),
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: isLoading ? 3 : data.length,
            itemBuilder: (context, index) {
              return isLoading ? shimmerData(context) : Box(
                onPressed: () {},//=> Navigator.push(context, MaterialPageRoute(
         //           builder: (context) => MarketDetailpage(market: data[index]))),
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
                        bloc.add(BuyMarketToday(type: "index"));
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
    bloc.add(LoadMarket(type: "index"));
    setState(() {
      isLoading = true;
    });
  }
}