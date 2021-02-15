import 'package:flutter/material.dart';
import 'package:trikcuan_app/core/model/options_model.dart';
import 'package:trikcuan_app/widget/text.dart';

class SelectOptions extends StatefulWidget {
  const SelectOptions({
    Key key,
    this.options,
    this.selected,
    this.title = "Select",
    this.useImageAsset = false,
    this.useImageNetwork = false,
    this.multipleSelect = false,
    this.useFilter = false
  }) : super(key: key);

  final bool multipleSelect;
  final bool useImageAsset;
  final bool useImageNetwork;
  final bool useFilter;
  final dynamic selected;
  final List<OptionsModel> options;
  final String title;

  @override
  _SelectOptionsState createState() => _SelectOptionsState();
}

class _SelectOptionsState extends State<SelectOptions> {

  final _searchController = TextEditingController();
  List<OptionsModel> optionsFiltered = <OptionsModel>[];
  List<OptionsModel> optionsSelected = <OptionsModel>[];

  @override
  void initState() {
    optionsFiltered = widget.options;
    if(widget.multipleSelect) optionsSelected.addAll(widget.selected);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        brightness: Brightness.light,
        actions: <Widget>[
          widget.multipleSelect ? 
          IconButton(
            icon: Icon(Icons.check, color: Colors.white), 
            onPressed: () => Navigator.of(context).pop({'data': optionsSelected})
          ) : Container()
        ],
      ),
      body: Column(
        children: <Widget>[
          Divider(color: Colors.grey, height: 2),
          widget.useFilter ? Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: TextFormField(
              controller: _searchController,
              cursorColor: Colors.black54,
              style: TextStyle(color: Colors.black87),
              onChanged: (value) {
                setState(() {
                  optionsFiltered = value.isEmpty ? widget.options : widget.options.where((q) => q.name.toLowerCase().contains(value.toLowerCase())).toList();
                });
              },
              decoration: InputDecoration(
                hintText: "Cari disini...",
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black38),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16)
              ),
            ),
          ) : Container(),
          widget.useFilter ? Divider() : Container(),
          widget.multipleSelect ? ListTile(
            trailing: Icon(Icons.check_circle, color: optionsSelected.length == selectedCount(widget.options) ? Colors.green : Colors.grey[300]),
            title: BoldText("${optionsSelected.length} selected"),
            onTap: () {
              if(optionsSelected.length < widget.options.length) {
                setState(() {
                  optionsSelected.clear();
                  selectAll(widget.options);
                });
              } 
              else {
                setState(() => optionsSelected.clear());
              }
            }
          ) : Container(),
          widget.multipleSelect ? Divider() : Container(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: optionsFiltered.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                if(optionsFiltered[index].value is List) {
                  return createParentItem(context, optionsFiltered[index]);
                }
                return createItemSelectable(context, optionsFiltered[index]);
              }
            ),
          ),
        ],
      ),
    );
  }

  void selectAll(List<OptionsModel> data) {
    for(int i=0; i<data.length; i++) {
      if(data[i].value is List) {
        selectAll(data[i].value);
      } else {
        optionsSelected.add(data[i]);
      }
    }
  }

  int selectedCount(List<OptionsModel> data) {
    int count = 0;
    for(int i=0; i<data.length; i++) {
      if(data[i].value is List) count += selectedCount(data[i].value);
      else count++;
    }
    return count;
  }

  ListView createParentItem(BuildContext context, OptionsModel data) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          color: Colors.grey[100],
          child: ListTile(
            trailing: !widget.multipleSelect ? null
              : Icon(Icons.check_circle, color: Colors.green),
            title: BoldText(data.name),
            onTap: () {},
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: data.value.length,
          separatorBuilder: (context, i) => Divider(),
          itemBuilder: (context, i) {
            return createItemSelectable(context, data.value[i]);
          }
        )
      ],
    );
  }

  Widget createItemSelectable(BuildContext context, OptionsModel item) {
    bool isSelected = false;
    int indexSelected = 0;
    if(widget.multipleSelect && optionsSelected.length > 0) {
      for(int i=0; i<optionsSelected.length; i++) {
        if(optionsSelected[i] == item) {
          isSelected = true;
          indexSelected = i;
        }
      }
    } else {
      if(widget.selected == item) isSelected = true;
    } 
    return ListTile(
      trailing: Icon(Icons.check_circle, color: isSelected ? Colors.green : Colors.transparent),
      title: Row(
        children: <Widget>[
          widget.useImageAsset ? Padding(
            padding: EdgeInsets.only(right: 16),
            child: item.imageAsset != null ? Image.asset(
              item.imageAsset,
              width: 40,
              height: 40,
            ) : Container(),
          ) : Container(),
          widget.useImageNetwork ? Padding(
            padding: EdgeInsets.only(right: 16),
            child: item.imageNetwork != null ? Image.network(
              item.imageNetwork,
              width: 40,
              height: 40,
            ) : Container(),
          ) : Container(),
          Text(item.name),
        ],
      ),
      onTap: () {
        if(!widget.multipleSelect) {
          Navigator.of(context).pop({'data': item});
        } else {
          if(isSelected) {
            setState(() => optionsSelected.removeAt(indexSelected));
          } else {
            setState(() => optionsSelected.add(item));
          }
        }
      }
    );
  }
}