import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trikcuan_app/core/bloc/admin/user/user_bloc.dart';
import 'package:trikcuan_app/core/bloc/admin/user/user_event.dart';
import 'package:trikcuan_app/core/bloc/admin/user/user_state.dart';
import 'package:trikcuan_app/core/model/account_model.dart';
import 'package:trikcuan_app/pages/admin/user/user_topup_history.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/loading.dart';
import 'package:trikcuan_app/widget/text.dart';

class MemberListPage extends StatefulWidget {
  @override
  _MemberListPageState createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {

  final bloc = AdminUserBloc();
  List<Account> data = [];
  List<Account> dataFiltered = [];
  bool  isStarting = true,
        isLoadMore = false,
        hasReachedMax = false;
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  final _searchController = TextEditingController();
  Timer searchOnStoppedTyping;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    refresh();
    super.initState();
  }

  refresh() {
    bloc.add(AdminLoadUsers(
      isRefresh: true,
      search: _searchController.text ?? ""
    ));
    setState(() {
      isStarting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is AdminUserLoaded) {
          _refreshController.refreshCompleted();
          setState(() {
            isStarting = false;
            isLoadMore = false;
            hasReachedMax = state.hasReachedMax;
            data = state.data;
            dataFiltered = state.data;
          });
        }
        else if(state is AdminUserFailure) {
          _refreshController.refreshCompleted();
          setState(() {
            isStarting = false;
            isLoadMore = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("MEMBER")
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
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  controller: _scrollController,
                  children: [
                    !isStarting ? (
                      data.length > 0 ? ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: data.length,
                        itemBuilder: (context, index) => Box(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => UserTopupHistoryPage(
                              data: data[index].balanceTopup
                            )
                          )),
                          padding: 16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index].name.toUpperCase()),
                                    SmallText(data[index].phoneNumber),
                                    SmallText("@${data[index].username}"),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  LabelText("SALDO"),
                                  Text(rupiah(data[index].balance)),
                                ],
                              ),
                            ],
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
        bloc.add(AdminLoadUsers(
          isLoadMore: true,
          search: _searchController.text ?? ""
        ));
      }
      setState(() {
        isLoadMore = true;
      });
    }
  }

  _onChangeHandler(value) {
    const duration = Duration(milliseconds:1000);
    if (searchOnStoppedTyping != null) {
        setState(() => searchOnStoppedTyping.cancel());
    }
    setState(() => searchOnStoppedTyping = new Timer(duration, () => refresh()));
  }
}