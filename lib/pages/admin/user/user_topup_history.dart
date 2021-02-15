import 'package:flutter/material.dart';
import 'package:trikcuan_app/core/model/topup_model.dart';
import 'package:trikcuan_app/pages/admin/topup/topup_page.dart';
import 'package:trikcuan_app/widget/text.dart';

class UserTopupHistoryPage extends StatefulWidget {
  const UserTopupHistoryPage({
    Key key,
    this.data
  }) : super(key: key);

  final List<TopupModel> data;

  @override
  _UserTopupHistoryPageState createState() => _UserTopupHistoryPageState();
}

class _UserTopupHistoryPageState extends State<UserTopupHistoryPage> {

  List<TopupModel> data = [];

  @override
  void initState() {
    print(widget.data);
    print(widget.data.length);
    data = widget.data;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UNPAID TOPUP")
      ),
      body: data.length > 0 ? ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: data.length,
        itemBuilder: (context, index) => TopupItem(
          isLoading: false,
          onTap: null,
          data: data[index]
        )
      ) : Center(child: LabelText("BELUM PERNAH TOPUP")),
    );
  }
}