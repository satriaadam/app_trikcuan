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
import 'package:trikcuan_app/widget/dialog.dart';
import 'package:trikcuan_app/widget/loading.dart';

class AdminRecomendationPage extends StatefulWidget {
  @override
  _AdminRecomendationPageState createState() => _AdminRecomendationPageState();
}

class _AdminRecomendationPageState extends State<AdminRecomendationPage> {

  final bloc = AdminRecomendationBloc();
  List<RecomendationModel> data = [];
  RefreshController refreshController = RefreshController();

  int deleteIndex;
  bool deleteLoading = false;

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
            } else if(state is RecomendationDeleted) {
              setState(() {
                deleteIndex = null;
                deleteLoading = false;
                data.removeWhere((item) => item.id == state.id);
              });
            } else if(state is RecomendationFailure) {
              setState(() {
                deleteIndex = null;
                deleteLoading = false;
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
                child: data.length > 0 ? ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => Divider(), 
                  itemBuilder: (context, index) {
                    return Box(
                      onPressed: () => openForm(data[index]),
                      padding: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data[index].kodeSaham),
                          deleteLoading && index == deleteIndex ? LoadingForButton() : GestureDetector(
                            child: Icon(Icons.close), 
                            onTap: () => dialogConfirmation(
                              context: context,
                              message: "Ingin menghapus rekomendasi ini?",
                              textConfirm: "Ya",
                              textCancel: "Tidak",
                              callback: () => delete(index)
                            )
                          ),
                        ],
                      )
                    );
                  }
                ) : Center(child: Text("Belum ada rekomendasi hari ini")),
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

  delete(int index) {
    Navigator.pop(context);
    bloc.add(DeleteRecomendation(id: data[index].id));
    setState(() {
      deleteIndex = index;
      deleteLoading = true;
    });
  }
}