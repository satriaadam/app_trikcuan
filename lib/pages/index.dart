import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    bloc.add(LoadMarket(type: "index"));
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
            if(state is MarketLoaded) {
              setState(() {
                refreshController.refreshCompleted();
                isLoading = false;
                data = state.data;
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
        ),
      ],
      child: SmartRefresher(
        controller: refreshController,
        onRefresh: () => onRefresh(),
        child: ListView(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300,),
              itemCount: isLoading ? 3 : data.length,
              itemBuilder: (context, index) {
                return isLoading ? shimmerData(context) : Box(
                  padding: 8,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              data[index].code,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            TextCustom(
                              data[index].description,
                              maxLines: 3,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextCustom(
                            data[index].price.toStringAsFixed(2),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: data[index].priceChange > 0 ? Colors.green : Colors.red,
                          ),
                          TextCustom(
                            "${data[index].priceChange.toStringAsFixed(2)} (${data[index].percentageChange.toStringAsFixed(2)}%)",
                            color: data[index].priceChange > 0 ? Colors.green : Colors.red,
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            account?.catatanIndex != null ? Box(
              padding: 8,
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  SubtitleText("Catatan"),
                  Text(account?.catatanIndex)
                ],
              )
            ) : Container()
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