import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indonesia/indonesia.dart';
import 'package:toast/toast.dart';
import 'package:trikcuan_app/core/bloc/admin/recomendation/recomendation_bloc.dart';
import 'package:trikcuan_app/core/bloc/admin/recomendation/recomendation_event.dart';
import 'package:trikcuan_app/core/bloc/admin/recomendation/recomendation_state.dart';
import 'package:trikcuan_app/core/model/options_model.dart';
import 'package:trikcuan_app/core/model/recomendation_model.dart';
import 'package:trikcuan_app/widget/box.dart';
import 'package:trikcuan_app/widget/button.dart';
import 'package:trikcuan_app/widget/form.dart';
import 'package:trikcuan_app/widget/select_options.dart';
import 'package:trikcuan_app/widget/text.dart';

class RecomendationForm extends StatefulWidget {

  RecomendationForm({
    Key key,
    this.recomendation
  }) : super(key: key);

  final RecomendationModel recomendation;

  @override
  _RecomendationFormState createState() => _RecomendationFormState();
}

class _RecomendationFormState extends State<RecomendationForm> {

  final bloc = AdminRecomendationBloc();

  final kodeSahamController = TextEditingController();
  final potensiKenaikanController = TextEditingController();
  final prospekPerusahaanController = TextEditingController();
  final fundamentalController = TextEditingController();
  final teknikalController = TextEditingController();
  final jualBeliController = TextEditingController();
  final hargaController = TextEditingController();

  OptionsModel category = OptionsModel(name: "Trading", value: "trading");
  final List<OptionsModel> categories = [
    OptionsModel(name: "Trading", value: "trading"),
    OptionsModel(name: "Swing", value: "swing"),
    OptionsModel(name: "Invest", value: "invest")
  ];

  DateTime selectedDate = DateTime.now();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if(widget.recomendation != null) {
      kodeSahamController.text = widget.recomendation.kodeSaham;
      potensiKenaikanController.text = widget.recomendation.potensiKenaikan;
      prospekPerusahaanController.text = widget.recomendation.prospekPerusahaan;
      fundamentalController.text = widget.recomendation.fundamental;
      teknikalController.text = widget.recomendation.teknikal;
      jualBeliController.text = widget.recomendation.jualBeli;
      hargaController.text = widget.recomendation.hargaBeli;
      selectedDate = DateTime.parse(widget.recomendation.date);
      category = categories.firstWhere(
        (element) => element.value == widget.recomendation.kategori, 
        orElse: () => categories[0]
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: bloc,
      listener: (context, state) {
        if(state is RecomendationCreated) {
          setState(() {
            isLoading = false;
            Toast.show("Berhasil", context);
            Navigator.of(context).pop({"data": state.data});
          });
        } else if(state is RecomendationUpdated) {
          setState(() {
            isLoading = false;
            Toast.show("Berhasil", context);
            Navigator.of(context).pop({"data": state.data});
          });
        } else if(state is RecomendationFailure) {
          setState(() {
            isLoading = false;
            Toast.show(state.error, context);
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Tambah Rekomendasi")
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  LabelText("Kategori"),
                  Box(
                    onPressed: () => selectCategory(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: BoldText(category?.name ?? ""),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  LabelText("Kode Saham"),
                  TextFieldBorderBottom(
                    autofocus: true,
                    controller: kodeSahamController,
                  ),
                  SizedBox(height: 20),
                  LabelText("Potensi Kenaikan"),
                  TextFieldBorderBottom(
                    controller: potensiKenaikanController,
                  ),
                  SizedBox(height: 20),
                  LabelText("Prospek Perusahaan"),
                  TextFieldBorderBottom(
                    controller: prospekPerusahaanController,
                  ),
                  SizedBox(height: 20),
                  LabelText("Fundamental"),
                  TextFormField(
                    controller: fundamentalController,
                    cursorColor: Colors.black54,
                    maxLines: 10,
                    minLines: 5,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: "",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black38),
                      contentPadding: EdgeInsets.all(0)
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  LabelText("Teknikal"),
                  TextFormField(
                    controller: teknikalController,
                    cursorColor: Colors.black54,
                    maxLines: 10,
                    minLines: 5,
                    style: TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      hintText: "",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black38),
                      contentPadding: EdgeInsets.all(0)
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  LabelText("Jual Beli"),
                  TextFieldBorderBottom(
                    inputType: TextInputType.number,
                    controller: jualBeliController,
                  ),
                  SizedBox(height: 20),
                  LabelText("Tanggal"),
                  Box(
                    onPressed: () => selectDate(context),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: BoldText(selectedDate != null ? tanggal(selectedDate) : ""),
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  LabelText("Harga jual info rekomendasi"),
                  TextFieldBorderBottom(
                    inputType: TextInputType.number,
                    controller: hargaController,
                  ),
                  SizedBox(height: 64),
                ],
              ),
            ),
            Box(
              padding: 8,
              child: SafeArea(
                child: RaisedButtonPrimary(
                  onPressed: isLoading ? null : () => save(),
                  isLoading: isLoading,
                  text: "Simpan"
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future selectCategory() async {
    Map results = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectOptions(
        title: "Pilih Bank",
        options: categories,
        selected: category
      )),
    );

    if (results != null && results.containsKey("data")) {
      setState(() {
        category = results["data"];
      });
    }
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(1960, 1),
        lastDate: DateTime.now()
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  save() {
    FocusScope.of(context).requestFocus(new FocusNode());
    var data = RecomendationPost(
      kategori: category.value,
      kodeSaham: kodeSahamController.text,
      potensiKenaikan: potensiKenaikanController.text,
      fundamental: fundamentalController.text,
      prospekPerusahaan: prospekPerusahaanController.text,
      teknikal: teknikalController.text,
      jualBeli: jualBeliController.text,
      hargaBeli: hargaController.text,
      date: "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"
    );
    if(widget.recomendation != null)
      bloc.add(EditRecomendation(data: data, id: widget.recomendation.id.toString()));
    else
      bloc.add(AddRecomendation(data: data));
    setState(() {
      isLoading = true;
    });
  }
}