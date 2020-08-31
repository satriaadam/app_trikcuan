import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trikcuan_app/login_screen.dart';
import 'package:trikcuan_app/pages/corporate.dart';
import 'package:trikcuan_app/pages/daftarkelas.dart';
import 'package:trikcuan_app/pages/dataperusahaan.dart';
import 'package:trikcuan_app/utilities/currency.dart';
import 'package:trikcuan_app/utilities/styles.dart';
import 'package:intl/intl.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool _crossFadeStateShowFirst = true;
  final money = NumberFormat("#,##0","en_US");
  final nominal = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    nominal.dispose();
    super.dispose();
  }


  void _crossFade() {
    setState(() {
      _crossFadeStateShowFirst =
      _crossFadeStateShowFirst ? false : true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.limeAccent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.blueGrey[600],),
          onPressed: () {},
        ),
      ),
      body: ListView(
        children: [
          Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    stops: [0.2, 0.4, 0.7],
    colors: [
    Colors.limeAccent,
    Colors.limeAccent[100],
    Colors.white,
    ],
    ),
    ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Halo,\nADAM SATRIA',
                    style: kTitleStyle,
                  ),
                   SizedBox(height: 10.0),
                   Center(
                       child: AnimatedCrossFade(
                          duration: Duration(milliseconds: 500),
                          sizeCurve: Curves.easeIn,
                          crossFadeState: _crossFadeStateShowFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                         firstChild: Container(width: 300.0, height: 150.0,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                              color: Colors.white,
                              gradient: LinearGradient(
                              colors: [Colors.grey[200], Colors.limeAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                                ),
                              borderRadius: BorderRadius.circular(20.0)),
                              child: GestureDetector(
                                onTap: _crossFade,
                                child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                  SizedBox(height: 5.0),
                                   Container(
                                      child: Text(
                                    'Saldo', style: TextStyle(
                                    color: Colors.blueGrey[600],
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0
                                    ),
                                    ),),
                                      SizedBox(height: 5.0),
                                    Container(
                                        child: Text(
                                    'Rp. 500.000', style: TextStyle(
                                     color: Colors.blueGrey[600],
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35.0
                                    ),
                                    ),),
                                    SizedBox(height: 10.0,),
                                    Divider(height: 5.0, thickness: 2.0),
                                    SizedBox(height: 5.0),
                                    Container(
                                      child: Text(
                                        'Klik Disini Untuk Top Up Saldo', style: TextStyle(
                                          color: Colors.blueGrey[600],
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0
                                      ),
                                        textAlign: TextAlign.left,  ),),
                                  ],),),),
                                secondChild: Container(width: 300.0, height: 375.0,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                color: Colors.white,
                                  gradient: LinearGradient(
                                  colors: [Colors.grey[200], Colors.limeAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                    ),
                                borderRadius: BorderRadius.circular(20.0)),
                                   child: GestureDetector(
                                     onTap: _crossFade,
                                      child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                SizedBox(height: 5.0),
                                Container(
                                  child: Text(
                                  'MASUKKAN NOMINAL', style: TextStyle(
                                   color: Colors.blueGrey[600],
                                  fontFamily: 'Poppins',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.left,  ),),
                                SizedBox(height: 10.0),
                                TextField(
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    CurrencyFormat()
                                  ],
                                  controller: nominal,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                  hoverColor: Colors.blueGrey[600],
                                  hintText: 'Rp0',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  fontSize: 15.0,
                                  ),
                                        ),),
                                SizedBox(height: 20.0,),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                        nominal.text = "Rp10,000";
                                        });
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                        color: Colors.transparent,
                                        child: Container(width: 75.0,height: 75.0,
                                        decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                        colors: [Colors.lightGreen[400], Colors.lightGreen[700]],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Icon(
                                            Icons.attach_money,
                                            color: Colors.grey.shade300,
                                            size: 25.0,
                                            ),
                                      ),
                                      ),
                                      ),
                                      RaisedButton(
                                      onPressed: () {
                                      setState(() {
                                      nominal.text = "Rp50,000";
                                      });
                                      },
                                        padding: EdgeInsets.all(0.0),
                                          shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                        color: Colors.transparent,
                                        child: Container(width: 75.0,height: 75.0,
                                          decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                          colors: [Colors.indigo[300], Colors.indigo[700]],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          ),
                                            borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Icon(
                                              Icons.attach_money,
                                              color: Colors.grey.shade300,
                                              size: 35.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text('Rp.10.000     ',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.blueGrey[600],
                                          fontWeight: FontWeight.bold,
                                        ),),
                                        Text('Rp.50.000',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.blueGrey[600],
                                            fontWeight: FontWeight.bold,
                                          ),),],
                                    ),
                                  ),
                                SizedBox(height: 10.0,),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                  setState(() {
                                    nominal.text = "Rp100,000";
                                    });
                                    },
                                  padding: EdgeInsets.all(0.0),
                                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                                  color: Colors.transparent,
                                    child: Container(width: 75.0,height: 75.0,
                                        decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                        colors: [Colors.red[300], Colors.red[700]],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        ),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: Icon(
                                          Icons.attach_money,
                                          color: Colors.grey.shade300,
                                          size: 45.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    RaisedButton(
                                      onPressed: () {
                                      setState(() {
                                      nominal.text = "Rp200,000";
                                      });
                                      },
                                          padding: EdgeInsets.all(0.0),
                                          shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                          color: Colors.transparent,
                                      child: Container(width: 75.0,height: 75.0,
                                          decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                          colors: [Colors.blueGrey[300], Colors.blueGrey[700]],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Icon(
                                            Icons.attach_money,
                                            color: Colors.grey.shade300,
                                            size: 55.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                  SizedBox(height: 5.0,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text('Rp.100.000   ',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.blueGrey[600],
                                            fontWeight: FontWeight.bold,
                                          ),),
                                        Text('Rp.200.000',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.blueGrey[600],
                                            fontWeight: FontWeight.bold,
                                          ),),],
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  GestureDetector(
                                    onTap: (){
                                      _confirmPaymentModalBottomSheet(context);
                                    },
                                    child: Container( height: 40.0, width: double.infinity,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Colors.green[300], Colors.green[600]],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          border: Border.all(
                                            width: 2.0,
                                            color: Colors.grey.shade500
                                          ),
                                          borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text(
                                          'PROSES'
                                    ),
                                  )
                                    ),),],
                                      ),
                                   ),
                                ),
                         layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
                           return Stack(
                             overflow: Overflow.visible,
                             alignment: Alignment.center,
                             children: <Widget>[
                               Positioned(
                                 key: bottomChildKey,
                                 top: 0.0,
                                 child: bottomChild,
                               ),
                               Positioned(
                                   key: topChildKey,
                                   child: topChild
                               )
                             ],
                           );
                           }),
                   ),
                        SizedBox(height: 20.0),
                        Container(
                          child: Center(
                          child: Container(width: 300.0,height: 50.0,
                          decoration: BoxDecoration(
                          color: Colors.white,
                            boxShadow: [
                            BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(5, 5),
                            blurRadius: 10,
                              ),
                            BoxShadow(
                            color: Colors.grey.shade200,
                            offset: Offset(-5, -5),
                            blurRadius: 10,
                            ),],
                            gradient: LinearGradient(
                              colors: [Colors.grey[200], Colors.grey[300]],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,),
                            borderRadius: BorderRadius.circular(20.0)),
                              child: GestureDetector(
                               onTap: () {
                                Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => DaftarKelas())
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text('Daftar Kelas TrikCuan', style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey[600],
                                            ),),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                        ),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Container(width: 125.0,height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(5, 5),
                                  blurRadius: 10,
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: Offset(-5, -5),
                                  blurRadius: 10,
                                ),],
                              gradient: LinearGradient(
                                colors: [Colors.grey[200], Colors.grey[300]],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => DataPerusahaan())
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Data Perusahaan', style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[600],
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        child: Container(width: 125.0,height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(5, 5),
                                  blurRadius: 10,
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: Offset(-5, -5),
                                  blurRadius: 10,
                                ),],
                              gradient: LinearGradient(
                                colors: [Colors.grey[200], Colors.grey[300]],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (context) => Corporate())
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Corporate Action', style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                  color: Colors.blueGrey[600],
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Center(
                    child: Container(width: 300,height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(5, 5),
                              blurRadius: 10,
                            ),
                            BoxShadow(
                              color: Colors.grey.shade200,
                              offset: Offset(-5, -5),
                              blurRadius: 10,
                            ),],
                          gradient: LinearGradient(
                            colors: [Colors.red[300], Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,),
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => LoginPage())
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text('Log Out', style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[600],
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ),
    ],
          ),
          ),
          ),
          ],),
      );
  }
}

void _confirmPaymentModalBottomSheet(context) {
  showModalBottomSheet(context: context, builder: (BuildContext payment) {
    return Container(height: 225.0, width: double.infinity,
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close,
              color: Colors.red[400],
              size: 30.0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              '   KONFIRMASI ISI SALDO',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left:15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Jumlah Isi Saldo'
                  ),
                  Text("Rp.")
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Biaya Admin'
                  ),
                  Text(
                    'Rp.2000'
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container( height: 40.0, width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green[300], Colors.green[600]],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                          width: 2.0,
                          color: Colors.grey.shade500
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                        'ISI SALDO SEKARANG'
                    ),
                  )
              ),),],
        ),
      );
    });
}