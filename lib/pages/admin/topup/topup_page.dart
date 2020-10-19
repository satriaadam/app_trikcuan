import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/admin/balance/balance_bloc.dart';
import 'package:trikcuan_app/core/bloc/admin/balance/balance_event.dart';
import 'package:trikcuan_app/core/bloc/admin/balance/balance_state.dart';
import 'package:trikcuan_app/core/model/topup_model.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/dialog.dart';
import 'package:trikcuan_app/widget/loading.dart';
import 'package:trikcuan_app/widget/text.dart';

class TopupPage extends StatefulWidget {
  @override
  _TopupPageState createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {

  final bloc = BalanceTopupBloc();
  List<TopupModel> data = [];
  List<TopupModel> dataFiltered = [];
  bool  isStarting = true,
        isLoadMore = false,
        hasReachedMax = false;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  int verifyIndex;
  bool verifyLoading = false;

  final _searchController = TextEditingController();
  Timer searchOnStoppedTyping;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    refresh();
    super.initState();
  }

  refresh() {
    bloc.add(GetData(isRefresh: true));
    setState(() {
      isStarting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is BalanceTopUpLoaded) {
          _refreshController.refreshCompleted();
          setState(() {
            isStarting = false;
            isLoadMore = false;
            hasReachedMax = state.hasReachedMax;
            data = state.data;
            dataFiltered = data.where((element) => element.name.toString().toLowerCase().contains(_searchController.text.toLowerCase()) || element.balance.toString().toLowerCase().contains(_searchController.text.toLowerCase())).toList();
          });
        }
        else if(state is TopupVerified) {
          dataFiltered.removeWhere((element) => element.id == state.data.id);
          Toast.show("TOPUP BERHASIL DITERIMA", context, duration: 3);
          setState(() {
            verifyIndex = null;
            verifyLoading = false;
          });
        }
        else if(state is BalanceTopUpFailure) {
          _refreshController.refreshCompleted();
          setState(() {
            verifyIndex = null;
            verifyLoading = false;
            isStarting = false;
            isLoadMore = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("UNPAID TOPUP")
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: TextFormField(
                controller: _searchController,
                cursorColor: Colors.black54,
                style: TextStyle(color: Colors.black87),
                onChanged: _onChangeHandler,
                decoration: InputDecoration(
                  hintText: "Cari disini...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black38),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: refresh,
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    !isStarting ? (
                      dataFiltered.length > 0 ? ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: dataFiltered.length,
                        itemBuilder: (context, index) => TopupItem(
                          isLoading: verifyIndex == index && verifyLoading,
                          data: dataFiltered[index],
                          onTap: () => dialogConfirmation(
                            context: context,
                            textConfirm: "Terima",
                            message: "Apakah anda ingin menyetujui Top Up saldo ini?",
                            callback: () {
                              setState(() {
                                verifyIndex = index;
                                verifyLoading = true;
                              });
                              bloc.add(VerifyTopup(id: dataFiltered[index].id));
                              Navigator.pop(context);
                            }
                          ),
                        )
                      ) : Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 64),
                          child: Text("Tidak ada Topup")
                        ),
                      )
                    ) : Box(padding: 16, child: LoadingForButton()),
                    isLoadMore ? Box(padding: 16, child: LoadingForButton()) : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !hasReachedMax && !isLoadMore) {
      if(!isStarting) {
        bloc.add(GetData(isLoadMore: true));
      }
      setState(() {
        isLoadMore = true;
      });
    }
  }

  _onChangeHandler(value) {
    setState(() {
      dataFiltered = data.where((element) => element.name.toString().toLowerCase().contains(value.toLowerCase()) || element.balance.toString().toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
}

class TopupItem extends StatelessWidget {
  const TopupItem({
    Key key,
    @required this.data,
    this.onTap,
    this.isLoading = false
  }) : super(key: key);

  final TopupModel data;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    var formatDate = DateFormat('yyyy-MM-dd H:m:s');
    return Box(
      onPressed: onTap,
      padding: 16,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(data?.name ?? ""),
                TextCustom(data?.phoneNumber ?? "")
              ]
            )
          ),
          isLoading ? LoadingForButton() : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextCustom(rupiah(data.balance)),
              LabelText(formatDate.format(data.createdAt))
            ],
          )
        ],
      )
    );
  }
}