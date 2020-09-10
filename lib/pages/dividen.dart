import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_bloc.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_event.dart';
import 'package:trikcuan_app/core/bloc/dividen/dividen_state.dart';
import 'package:trikcuan_app/core/model/dividen_model.dart';
import 'package:trikcuan_app/pages/dividen_detail.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/text.dart';

class Dividen extends StatefulWidget {
  Dividen({Key key}) : super(key: key);

  @override
  _DividenState createState() => _DividenState();
}

class _DividenState extends State<Dividen> {

  List<DividenModel> dividens = <DividenModel>[];
  final bloc = DividenBloc();
  bool isLoading = true;
  final RefreshController refreshController = RefreshController();

  DateFormat formatDate = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    bloc.add(LoadDividen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is DividensLoaded) {
          setState(() {
            refreshController.refreshCompleted();
            isLoading = false;
            dividens = state.data;
          });
        } else if(state is DividenFailure) {
          Toast.show(state.error, context);
          setState(() {
            refreshController.refreshCompleted();
            isLoading = false;
          });
        }
      },
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
            separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300),
            itemCount: isLoading ? 3 : dividens.length,
            itemBuilder: (context, index) {
              return isLoading ? shimmerData(context) : Box(
                onPressed: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DividenDetail(dividen: dividens[index])
                )),
                padding: 16,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextCustom(
                            dividens[index].kodeSaham,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelText(
                                "Potensi",
                              ),
                              TextCustom(
                                dividens[index].potensi,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelText(
                                "Cumdate",
                              ),
                              TextCustom(
                                formatDate.format(dividens[index].cumdate),
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabelText(
                                "Ex Date",
                              ),
                              TextCustom(
                                formatDate.format(dividens[index].exdate),
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }, 
          ),
        ),
      ),
    );
  }

  onRefresh() {
    bloc.add(LoadDividen());
    setState(() {
      isLoading = true;
    });
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
}
