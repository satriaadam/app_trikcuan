import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:trikcuan_app/core/bloc/admin/recomendation/recomendation_bloc.dart';
import 'package:trikcuan_app/core/bloc/admin/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/admin/recomendation/recomendation_state.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/pages/admin/recomendation/recomendation_form.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';

class AdminRecomendationPage extends StatefulWidget {
  @override
  _AdminRecomendationPageState createState() => _AdminRecomendationPageState();
}

class _AdminRecomendationPageState extends State<AdminRecomendationPage> {

  final bloc = AdminRecomendationBloc();
  List<RecomendationModel> data = [];
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    bloc.add(LoadRecomendation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: bloc,
          listener: (context, state) {
            if(state is RecomendationLoaded) {
              refreshController.refreshCompleted();
              setState(() {
                data = state.data;
              });
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rekomendasi")
        ),
        body: SmartRefresher(
          controller: refreshController,
          onRefresh: () => onRefresh(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Box(
                padding: 16,
                child: Text("Rekomendasi Saham"),
              ),
              Divider(),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => Divider(), 
                  itemBuilder: (context, index) {
                    return Box(
                      onPressed: () => openForm(data[index]),
                      padding: 16,
                      child: Text(data[index].kodeSaham)
                    );
                  }
                ),
              ),
              Box(
                padding: 8,
                child: SafeArea(
                  child: RaisedButtonPrimary(
                    onPressed: () => openForm(null),
                    text: "Tambah Rekomendasi"
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future openForm(RecomendationModel recomendation) async {
    Map results = await Navigator.push(context, MaterialPageRoute(
      builder: (context) => RecomendationForm(recomendation: recomendation)
    ));

    if (results != null && results.containsKey("data")) {
      setState(() {
        var index = data.indexWhere((e) => e.id == results["data"].id);
        if(index > -1) {
          data[index] = results["data"];
        } else {
          data.insert(0, results["data"]);
        }
      });
    }
  }

  onRefresh() {
    bloc.add(LoadRecomendation());   
  }
}