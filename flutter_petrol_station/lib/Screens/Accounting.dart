import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_petrol_station/Services/cloud_services.dart';
import 'package:flutter_petrol_station/Widgets/Drawer.dart';
import 'package:intl/intl.dart';

import 'dashboard_firstore.dart';

class Accounting extends StatefulWidget {
  @override
  _AccountingState createState() => _AccountingState();
}

class _AccountingState extends State<Accounting> {
  DateTime first_record_data;
  String dropdownValue;
  int pumpid;
  int lastrecord;
  int totalbill = 0, totalprofit = 0;
  int sumrecords;
  DateTime dt;
  int price = 0, profit = 0;
  var formatter = NumberFormat('#,##,000');
  int button_type = -1;
  bool isloading = false;
  DateTime last_record_date;
  int previous_record_id;
  int contid; // for get the container id for specific pump
  String contname; //get container
  int calculationprofit, calculationprice;
  Fuel F;
  int previous_record;
  int idob;
  String nameob;
  var fuel_types;
  int pumpidtdy;
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  int cont_id;
  String cont_name;

  DateTime lastpricedate, lastprofitdate;
  DateTime datetimetoday = DateTime.now();
  DateFormat ff;
  DateTime todayy;
  int container_id_tdy;
  int totalbilltdy = 0, totalprofittoday = 0;
  int lastpricetdy, lastprofittdy;
  int previous_price, previous_profit;
  DateTime previous_price_date;
  int sum_littres = 0;

  DateTime T1, T2;
  List<DateTime> AllDateTime;
  DateTime last_pump_record_timestamp;

  int totalbillchanged = 0;
  int totalprofitchanged = 0;

  int record_value, record_id;
  int last_price;
  int last_profit;
  int last_littre;
 String fuel_name;
  int lastR = 0;
  int today = 0;
  int submit = 0;

  List<specificfuel> L;
  

   int lastRallfuel=0;
   int lastRspecifiquefuel=0;
  int date1error=0;
  int date2error=0;
  User loggedInUser;
  CloudServices cloudServices =
      CloudServices(FirebaseFirestore.instance, FirebaseAuth.instance);

  String station;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
     loggedInUser = cloudServices.getCurrentUser();
      ff = DateFormat('yyyy-MM-dd');
       t2.text = ff.format(DateTime.now()).toString();
     t1.text = ff.format(DateTime.now()).toString();
    todayy = ff.parse(ff.format(DateTime.now()));

    // t2.text = ff.format(DateTime.now()).toString();
    // t1.text = ff.format(DateTime.now()).toString();
     asyncmeth();
    // print('IN BUILD ${fuel_types[1].name.toString()}');
  }

  void asyncmeth() async {
    if (loggedInUser != null) {
      station = await cloudServices.getUserStation(loggedInUser);
      
    }
    await getarrayoffueltypes();
    setState(() {
      dropdownValue = fuel_types[0].name.toString();
    });
  }

  void getarrayoffueltypes() async {
    fuel_types = new List<Fuel>();
    fuel_types.add(new Fuel(0, "All Fuel Type"));
    await FirebaseFirestore.instance
        .collection("Stations")
        .doc(station)
        .collection("Fuel_Type")
        .get()
        .then((val) => {
              for (int i = 0; i < val.docs.length; i++)
                {
                  idob = val.docs[i].get("Fuel_Type_Id"),
                  nameob = val.docs[i].get("Fuel_Type_Name").toString(),
                  F = new Fuel(idob, nameob),
                  print("OBJECTTT ${F.name}"),
                  fuel_types.add(F),
                },
            });

    print(fuel_types);
  }

void get_first_record_date() async {
    await FirebaseFirestore.instance
        .collection("Stations")
        .doc(station)
        .collection("Pump_Record")
        .get()
        .then((value) => {
              if (value.docs.length > 0)
                {
                  first_record_data = DateTime.tryParse(
                      (value.docs[0].get("Record_Time")).toDate().toString()),
                }
            });

   // print(" ... first_record_data in fuction ... ${first_record_data}");
    //
  }

  List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(DateTime(
          startDate.year,
          startDate.month,
          // In Dart you can set more than. 30 days, DateTime will do the trick
          startDate.day + i));
    }
    return days;
  }




  void getlastreacordNew()async{
    L = new List();
     totalbill = 0;
     totalprofit = 0;
     setState(() {
                  date2error=0;
                  date1error=0;
                }); 
  setState(() {
      isloading = true;
    });

      if (dropdownValue == "All Fuel Type") {
     //for loop on fueltypename
      await FirebaseFirestore.instance
        .collection("Stations")
        .doc(station)
        .collection("Fuel_Type")
        .get().then((val) async =>{
            if(val.docs.length>0){
              print("*****************************"),
              for(int i=0;i<val.docs.length;i++){
                fuel_name=val.docs[i].get("Fuel_Type_Name"),
                print("fuel name ${fuel_name}"),
                //last price and profit for each fuelname from accounting collection
                 await FirebaseFirestore.instance
                .collection("Stations")
                .doc(station)
                .collection("Accounting")
                .where('Fuel_Type_Id' , isEqualTo: fuel_name)
                .orderBy("Accounting_Id",
                                              descending: true)
                .get().then((val1) async =>{
                  last_price=val1.docs[0].get('Price'),
                  last_profit= val1.docs[0].get('Profit'),
                  last_littre=val1.docs[0].get('Record'),
                    totalbill = totalbill+ last_price,
                    totalprofit = totalprofit + last_profit,
                    
                    print("last price for ${fuel_name} is ${last_price}"),
                    print("last profit for ${fuel_name} is ${last_profit}"),
                    
                    print("last littre for ${fuel_name} is ${last_littre}"),
                    
                }),
                L.add(new specificfuel(fuel_name,last_price,last_profit,last_littre)),
              },
              
              print("*****************************"),

            }
        });
        L.add(new specificfuel(
                        "Total", totalbill, totalprofit, 0));
     print("Total bill for last record is ${totalbill}");
     print("Total profit for last record is ${totalprofit}");
     setState(() {
       lastRallfuel=1;

        lastRspecifiquefuel=0;
      isloading = false;
      button_type = 3;
      totalbill;
      totalprofit;
    });
      }
      else{
        //specific fuel type 
        fuel_name = dropdownValue;
        print("selectd fuel name is ${fuel_name}");
         await FirebaseFirestore.instance
                .collection("Stations")
                .doc(station)
                .collection("Accounting")
                .where('Fuel_Type_Id' , isEqualTo: fuel_name)
                .orderBy("Accounting_Id",
                                              descending: true)
                .get().then((val1) async =>{
                  last_price=val1.docs[0].get('Price'),
                  last_profit= val1.docs[0].get('Profit'),
                  last_littre = val1.docs[0].get('Record'),
                    
                });
                print("last price (selectd)for ${fuel_name} is ${last_price}");
                print("last profit (selected) for ${fuel_name} is ${last_profit}");
                print("last littre (selected) for ${fuel_name} is ${last_littre}");
                
                
           setState(() {
      lastRspecifiquefuel=1;
      lastRallfuel=0;
              
      isloading = false;
      button_type = 3;
      fuel_name;
      last_price;
      last_profit;
      last_littre;
    });        
      
      
      }
     
  }


void gettoday() async {

     print('**********************todayyy ${todayy}********************');
    L = new List();
setState(() {
                  date2error=0;
                  date1error=0;
                }); 
    setState(() {
      isloading = true;
    });
    sum_littres = 0;
    totalbilltdy = 0;
    totalprofittoday = 0;
    totalbillchanged = 0;
    totalprofitchanged = 0;
    L.clear();
    int cont_id;
    String cont_name, fuel_type_name;
    if (dropdownValue == "All Fuel Type") {
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Fuel_Type')
          .get()
          .then((value) async => {
                if (value.docs.length > 0)
                  {
                    for (int i = 0; i < value.docs.length; i++)
                      {
                        fuel_type_name = value.docs[i].get('Fuel_Type_Name'),
                        print('Fuel nameeeee******************${fuel_type_name}'),
                        await FirebaseFirestore.instance
                            .collection('Stations')
                            .doc(station)
                            .collection('Accounting')
                            .where('Fuel_Type_Id', isEqualTo: fuel_type_name)
                            .where('Date', isGreaterThanOrEqualTo: todayy)
                            .get()
                            .then((val) => {
                                  totalbillchanged = 0,
                                  totalprofitchanged = 0,
                                  sum_littres = 0,
                                  if (val.docs.length > 0)
                                    {
                                      //loop over today's accounting for the current fuel name from loop i
                                      for (int k = 0; k < val.docs.length; k++)
                                        {
                                          totalbillchanged +=
                                              val.docs[k].get('Price'),
                                          totalprofitchanged +=
                                              val.docs[k].get('Profit'),
                                          sum_littres +=
                                              val.docs[k].get('Record'),
                                          totalbilltdy +=
                                              val.docs[k].get('Price'),
                                          totalprofittoday +=
                                              val.docs[k].get('Profit'),
                                        },
                                      print("total billlll $totalbilltdy"),
                                    print('///////fuel name : ${fuel_type_name} , total bill : ${totalbillchanged} , totalprofit ${totalprofitchanged} , sum_littres : ${sum_littres}') ,

                                      L.add(new specificfuel(
                                          fuel_type_name,
                                          totalbillchanged,
                                          totalprofitchanged,
                                          sum_littres)),
          
                                      
                                    }
                                }),
                        
                      },
                    L.add(new specificfuel(
                        "Total", totalbilltdy, totalprofittoday, 0)),
                  }
              });

    } else {
      print("elseee specificccccc");
      sum_littres = 0;
      totalbillchanged = 0;
      totalprofitchanged = 0;
      //cont_id = val.docs[k].get("Container_Id"),
      cont_name = dropdownValue;
      print("contanier nameeeeeeeee: $cont_name");
      await FirebaseFirestore.instance
          .collection('Stations')
          .doc(station)
          .collection('Accounting')
          .where('Fuel_Type_Id', isEqualTo: dropdownValue)
          .where('Date', isGreaterThanOrEqualTo: todayy)
          .get()
          .then((val) => {
                if (val.docs.length > 0)
                  {
                    for (int k = 0; k < val.docs.length; k++)
                      {
                        totalbillchanged += val.docs[k].get('Price'),
                        totalprofitchanged += val.docs[k].get('Profit'),
                        sum_littres += val.docs[k].get('Record'),
                        totalbilltdy += val.docs[k].get('Price'),
                        totalprofittoday += val.docs[k].get('Profit'),
                      },
                    L.add(new specificfuel(cont_name, totalbillchanged,
                        totalprofitchanged, sum_littres)),
                  }
              });

      print("total billlll $totalbilltdy");
    }
    setState(() {
      isloading = false;
    });
  }
  

void submitbtn()async{

            L = new List();
int iddd;
    
    totalbilltdy = 0;
    totalprofittoday = 0;
    totalbillchanged = 0;
    totalprofitchanged = 0;
    sum_littres = 0;
    L.clear();
    String fuel_type;
    print("todayy ${todayy}");

     if(t1.text.isEmpty && t2.text.isEmpty){
setState(() {
                  date1error=1;
                  date2error=1;
                });
     } 
    else if(t1.text.isEmpty && !t2.text.isEmpty){
      print("T1 IS EMPTYYYY");

        setState(() {
                  date1error=1;
                  date2error=0;
                });
    }
    else if(t2.text.isEmpty && !t1.text.isEmpty){
      print("T2 IS EMPTYYYY");
      setState(() {
                  date2error=1;
                  date1error=0;
                });         
    }
    else{
      setState(() {
                  date2error=0;
                  date1error=0;
                });  
       T1 = DateTime.parse(t1.text);
       T2 = DateTime.parse(t2.text);
    

      setState(() {
      isloading = true;
    });
    print("T1111 ${T1}");
    print("T1111 ${T2}");

    AllDateTime = getDaysInBeteween(T1, T2);
    //print(AllDateTime);
    if (dropdownValue == "All Fuel Type") {                  
                        await FirebaseFirestore.instance
                            .collection('Stations')
                            .doc(station)
                            .collection('Fuel_Type')
                            .get()
                            .then((val) async => {
                                  if (val.docs.length > 0)
                                    {
                                      for (int i = 0; i < val.docs.length; i++)
                                        {
										
											totalbillchanged = 0,
											totalprofitchanged = 0,
											sum_littres = 0,
                                          fuel_type =
                                              val.docs[i].get("Fuel_Type_Name"),
                      await FirebaseFirestore.instance
                                              .collection('Stations')
                                              .doc(station)
                                              .collection('Accounting').where('Fuel_Type_Id', isEqualTo: fuel_type)
											  .where('Date', isGreaterThanOrEqualTo: T1)
											  .where('Date', isLessThanOrEqualTo: T2.add(const Duration(days: 1)))
											  .get()
											  .then((value) => {
											  if(value.docs.length>0){
                         
											  for(int k = 0;k<value.docs.length; k++){
                           iddd=value.docs[k].get("Accounting_Id"),
                            print("ID FETCHED ARE ${iddd}"),
                          
												totalbillchanged += value.docs[k].get('Price'),
												totalprofitchanged +=value.docs[k].get('Profit'),
												totalbilltdy +=value.docs[k].get('Price'),
												totalprofittoday += value.docs[k].get('Profit'),
												sum_littres += value.docs[k].get('Record'),
											  },
											  L.add(new specificfuel(fuel_type, totalbillchanged,
                            totalprofitchanged, sum_littres)),
											  
											  }
											  }),
                                        }
                                    }
                                });
                       print("Total Bill ${totalbilltdy}");
                        L.add(new specificfuel("Total", totalbilltdy, totalprofittoday, 0));
                      } 
                      else {
                        // specfiiccccccc submit
                        sum_littres = 0;
                        totalbillchanged = 0;
                                        totalprofitchanged = 0;
                                        sum_littres = 0;
                      await FirebaseFirestore.instance
                                              .collection('Stations')
                                              .doc(station)
                                              .collection('Accounting').where('Fuel_Type_Id', isEqualTo: dropdownValue)
											  .where('Date', isGreaterThanOrEqualTo: T1)
											  .where('Date', isLessThanOrEqualTo: T2.add(const Duration(days: 1)))
											  .get()
											  .then((value) => {
											  if(value.docs.length>0){
											  for(int k = 0;k<value.docs.length; k++){
                           iddd=value.docs[k].get("Accounting_Id"),
                            print("ID FETCHED ARE ${iddd}"),
												totalbillchanged += value.docs[k].get('Price'),
												totalprofitchanged +=value.docs[k].get('Profit'),
												totalbilltdy +=value.docs[k].get('Price'),
												totalprofittoday += value.docs[k].get('Profit'),
												sum_littres += value.docs[k].get('Record'),
											  },
											  L.add(new specificfuel(dropdownValue, totalbillchanged,
                            totalprofitchanged, sum_littres)),
											  
											  }
											  });
                                        
              
    }

    setState(() {
      isloading = false;
    });
    }

}



  @override
  Widget build(BuildContext context) {
    // getarrayoffueltypes();
    ff = DateFormat('yyyy-MM-dd');
    todayy = ff.parse(ff.format(DateTime.now()));

    // t2.text = ff.format(DateTime.now()).toString();
    // t1.text = ff.format(DateTime.now()).toString();

    get_first_record_date();
    print(" ... first_record_data ... ${first_record_data}");


    return WillPopScope(
      // ignore: missing_return
      onWillPop: () { 
        Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Dashboard()),
  );
       },
      child: Scaffold(
        
          backgroundColor: Colors.indigo[50],
          appBar: AppBar(
            backgroundColor: Color(0xFF083369),
           
          ),
          drawer: getDrawer(),
          body: ListView(
            children: [
              Card(
                  elevation: 12,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(children: [
                      SizedBox(height: 15),
                      Text("Fuel Type",
                          style: TextStyle(fontSize: 21, color: Colors.black45)),
                      SizedBox(height: 10),
                      Container(
                          width: 350.0,
                          height: 58,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0, style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: fuel_types==null?null:fuel_types
                                      .map<DropdownMenuItem<String>>((f) {
                                    print(f.name.toString());
                                    return new DropdownMenuItem<String>(
                                        value: f.name.toString(),
                                        child: new Container(
                                          child: Center(
                                            child: new Text(
                                              '${f.name.toString()}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ));
                                  }).toList()))),
                      SizedBox(height: 15),
                      Text("From Date",
                          style: TextStyle(fontSize: 21, color: Colors.black45)),
                      SizedBox(height: 10),


                      TextFormField(
                          controller: t1,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.date_range_rounded,
                                  color: Colors.indigo[300]),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                              ),
                              fillColor: Colors.white,
                              labelText: ff.format(DateTime.now()),
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0))),
                          
                          onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         t1.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },


                          onChanged: (String s) {}),
                      SizedBox(height: 15),
                      date1error==0?Text(''):Text("You must enter a specific date" , style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red
                      ),),
  SizedBox(height: 12),
                      Text("To Date",
                          style: TextStyle(fontSize: 21, color: Colors.black45)),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: t2,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.date_range_rounded,
                                  color: Colors.indigo[300]),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                              ),
                              fillColor: Colors.white,
                              labelText: ff.format(DateTime.now()),
                              labelStyle: TextStyle(color: Colors.black45),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 2.0))),
                          
                          onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         t2.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },

                          
                          onChanged: (String s) {}),

                      SizedBox(height: 10),
                       date2error==0?Text(''):Text("You must enter a specific date" , style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red
                      ),),
  SizedBox(height: 12),
                      Divider(height: 10, thickness: 2, color: Colors.grey),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonTheme(
                              height: 50.0,
                              minWidth: 100,
                              child: RaisedButton(
                                color: Color(0xFF083369),
                                elevation: 6,
                                child: Text('Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19)),
                                onPressed: () {
                                  setState(() {
                                    submit = 1;
                                    today = 0;
                                    lastR = 0;
                                  });
                                  submitbtn();
                                },
                              ),
                            ),
                            ButtonTheme(
                              height: 50.0,
                              minWidth: 100,
                              child: RaisedButton(
                                color: Color(0xFF083369),
                                elevation: 6,
                                child: Text('Today',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19)),
                                onPressed: () {
                                  setState(() {
                                    submit = 0;
                                    today = 1;
                                    lastR = 0;
                                    t1.text =
                                        ff.format(DateTime.now()).toString();
                                    t2.text =
                                        ff.format(DateTime.now()).toString();
                                  });

                                  gettoday();
                                },
                              ),
                            ),
                            ButtonTheme(
                              height: 50.0,
                              minWidth: 100,
                              child: RaisedButton(
                                color: Color(0xFF083369),
                                elevation: 6,
                                child: Text('Last Record',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19)),
                                onPressed: () {
                                  setState(() {
                                    submit = 0;
                                    today = 0;
                                    lastR = 1;
                                  });
                                  getlastreacordNew();
                                },
                              ),
                            ),
                          ]),
                      SizedBox(height: 10),
                    ]),
                  )),
              SizedBox(height: 10),
              // totalbill;
               if(isloading==true)...[
                 CircularProgressIndicator(),
               ],
               if(lastR==1)...[
                    if(lastRallfuel==1)...[
                        //TotalCard(totalbill, totalprofit)
                        ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                               reverse: true,
                              itemCount: L.length,
                              itemBuilder: (context, index) {
                                print("IN LIST VIEW ${index}");
                                return SpecificCard(
                                    L[index].getf(),
                                    L[index].gettb(),
                                    L[index].gettp(),
                                    L[index].getsl());
                              })
                    ],
                    if(lastRspecifiquefuel==1)...[
                        SpecificCard(fuel_name, last_price, last_profit, last_littre)
                    ]
               ],
               today == 1
                          ? ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                               reverse: true,
                              itemCount: L.length,
                              itemBuilder: (context, index) {
                                print("IN LIST VIEW ${index}");
                                return SpecificCard(
                                    L[index].getf(),
                                    L[index].gettb(),
                                    L[index].gettp(),
                                    L[index].getsl());
                              })
                          : submit == 1
                              ? ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                   reverse: true,
                                  itemCount: L.length,
                                  
                                  itemBuilder: (context, index) {
                                    print("IN LIST VIEW ${index}");
                                    return SpecificCard(
                                        L[index].getf(),
                                        L[index].gettb(),
                                        L[index].gettp(),
                                        L[index].getsl());
                                  })
                              : Text(""),

               


            ],
          )),
    );
  }
}

class TotalCard extends StatefulWidget {
  int bill, profit;
  TotalCard(int bill, int profit) {
    this.bill = bill;
    this.profit = profit;
  }

  @override
  _TotalCardState createState() => _TotalCardState();
}

class _TotalCardState extends State<TotalCard> {
  var formatter = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(7),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 4, color: Colors.green)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Total',
                      style: TextStyle(fontSize: 35, color: Color(0xFF083369))),
                ),
              ),
              SizedBox(height: 10),
              Card(
                  child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Bill',
                        style: TextStyle(fontSize: 22, color: Colors.green)),
                  ),
                ),
                SizedBox(height: 30),
                Text('${formatter.format(widget.bill)}L.L',
                    style: TextStyle(fontSize: 35, color: Colors.green))
              ])),
              SizedBox(height: 10),
              Card(
                  child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Profit',
                        style: TextStyle(fontSize: 22, color: Colors.green)),
                  ),
                ),
                SizedBox(height: 30),
                Text('${formatter.format(widget.profit)}L.L',
                    style: TextStyle(fontSize: 35, color: Colors.green))
              ]))
            ],
          ),
        ));
  }
}

class SpecificCard extends StatelessWidget {
  int bill, profit, littres;
  String fuel_name;
  SpecificCard(String fuel_name, int bill, int profit, int littres) {
    this.bill = bill;
    this.profit = profit;
    this.fuel_name = fuel_name;
    this.littres = littres;
  }

  var formatter = NumberFormat('###,###,###');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(7),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(width: 4, color: Colors.green)),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('${fuel_name}',
                      style: TextStyle(fontSize: 35, color: Color(0xFF083369))),
                ),
              ),
              fuel_name != "Total"
                  ? Card(
                      child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Text('Litters',
                              style:
                                  TextStyle(fontSize: 22, color: Colors.green)),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text('${formatter.format(littres)} L',
                          style: TextStyle(fontSize: 35, color: Colors.green))
                    ]))
                  : Text(""),
              SizedBox(height: 10),
              Card(
                  child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Bill',
                        style: TextStyle(fontSize: 22, color: Colors.green)),
                  ),
                ),
                SizedBox(height: 30),
                Text('${formatter.format(bill)} L.L',
                    style: TextStyle(fontSize: 35, color: Colors.green))
              ])),
              SizedBox(height: 10),
              Card(
                  child: Column(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('Profit',
                        style: TextStyle(fontSize: 22, color: Colors.green)),
                  ),
                ),
                SizedBox(height: 30),
                Text('${formatter.format(profit)} L.L',
                    style: TextStyle(fontSize: 35, color: Colors.green))
              ]))
            ],
          ),
        ));
  }
}

class Fuel {
  int id;
  String name;
  Fuel(int id, String name) {
    this.id = id;
    this.name = name;
  }
}

class specificfuel {
  String fuel_name;
  int totalbill;
  int totalprofit;
  int sumlittre;

  specificfuel(
      String fuel_name, int totalbill, int totalprofit, int sumlittre) {
    this.fuel_name = fuel_name;
    this.totalbill = totalbill;
    this.totalprofit = totalprofit;
    this.sumlittre = sumlittre;
  }
  String getf() {
    return fuel_name;
  }

  int gettb() {
    return totalbill;
  }

  int gettp() {
    return totalprofit;
  }

  int getsl() {
    return sumlittre;
  }
}
