import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class simplepage extends StatefulWidget {
  const simplepage({super.key});

  @override
  State<simplepage> createState() => _simplepageState();
}

class _simplepageState extends State<simplepage> {
  late double CRIM,ZN,INDUS,CHAS,NOX,RM,AGE,DIS,RAD,TAX,PTRATIO,B,LSTAT;
  String value="";
  TextEditingController CRIM_controler=TextEditingController();
  TextEditingController ZN_controler=TextEditingController();
  TextEditingController INDUS_controler=TextEditingController();
  TextEditingController CHAS_controler=TextEditingController();
  TextEditingController NOX_controler=TextEditingController();
  TextEditingController RM_controler=TextEditingController();
  TextEditingController AGE_controler=TextEditingController();
  TextEditingController DIS_controler=TextEditingController();
  TextEditingController RAD_controler=TextEditingController();
  TextEditingController TAX_controler=TextEditingController();
  TextEditingController PTRATIO_controler=TextEditingController();
  TextEditingController B_controler=TextEditingController();
  TextEditingController LSTAT_controler=TextEditingController();
  var elementlist=["CRIM","ZN","INDUS","CHAS","NOX","RM","AGE","DIS","RAD","TAX","PTRATIO","B","LSTAT"];
  String baseurl="http://127.0.0.1:5000";
  String androidurl="http://10.0.2.2:5000";
  final _formkey=GlobalKey<FormState>();
  Future<String> getPredictvalue() async{
    final responce= await http.post(Uri.parse("${androidurl}/predict/${CRIM}/${ZN}/${INDUS}/${CHAS}/${NOX}/${RM}/${AGE}/${DIS}/${RAD}/${TAX}/${PTRATIO}/${B}/${LSTAT}"));
    var data=responce.body;
    if(responce.statusCode==200){
      print("Hello");
      return data.toString();
    }
    return "Error in Conection";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prediction"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Before Filling all this details Press the I button at the bottom",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    inputbox(elementlist[0],CRIM_controler),
                    inputbox(elementlist[1],ZN_controler),
                    inputbox(elementlist[2],INDUS_controler),
                    inputbox(elementlist[3],CHAS_controler),
                    inputbox(elementlist[4],NOX_controler),
                    inputbox(elementlist[5],RM_controler),
                    inputbox(elementlist[6],AGE_controler),
                    inputbox(elementlist[7],DIS_controler),
                    inputbox(elementlist[8],RAD_controler),
                    inputbox(elementlist[9],TAX_controler),
                    inputbox(elementlist[10],PTRATIO_controler),
                    inputbox(elementlist[11],B_controler),
                    inputbox(elementlist[12],LSTAT_controler),
                  ],
                ),
              ),
              SizedBox(height: 9,),
              value==""?Shimmer(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Your Predicted Value will be shown here :"),
                  Text("0.0")
                ],
              ), 
                  gradient: LinearGradient(colors: [Colors.grey,Colors.grey.shade100])):Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("The MEDV value of the house will be around :"),
                  Text(value.toString()),
                ],
              ),
              SizedBox(height: 9,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(onTap: () async{
                  if(_formkey.currentState!.validate()){
                    CRIM=double.parse(CRIM_controler.text.toString());
                    ZN=double.parse(ZN_controler.text.toString());
                    INDUS=double.parse(INDUS_controler.text.toString());
                    CHAS=double.parse(CHAS_controler.text.toString());
                    NOX=double.parse(NOX_controler.text.toString());
                    RM=double.parse(RM_controler.text.toString());
                    AGE=double.parse(AGE_controler.text.toString());
                    DIS=double.parse(DIS_controler.text.toString());
                    RAD=double.parse(RAD_controler.text.toString());
                    TAX=double.parse(TAX_controler.text.toString());
                    PTRATIO=double.parse(PTRATIO_controler.text.toString());
                    B=double.parse(B_controler.text.toString());
                    LSTAT=double.parse(LSTAT_controler.text.toString());
                    value="Wait";
                    value=await getPredictvalue();
                    setState(() {

                    });
                  }
                }, child:Container(
                  width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Center(child: Text("Lets Predict",style: TextStyle(color: Colors.white),)))),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context,showDragHandle: true, builder: (context) {
            List content=['CRIM - per capita crime rate by town',
            'ZN - proportion of residential land zoned for lots over 25,000 sq.ft.',
            'INDUS - proportion of non-retail business acres per town.',
            'CHAS - Charles River dummy variable (1 if tract bounds river; 0 otherwise)',
            'NOX - nitric oxides concentration (parts per 10 million)',
            'RM - average number of rooms per dwelling',
            'AGE - proportion of owner-occupied units built prior to 1940',
            'DIS - weighted distances to five Boston employment centres',
            'RAD - index of accessibility to radial highways',
            'TAX - full-value property-tax rate per \$10,000',
            'PTRATIO - pupil-teacher ratio by town',
            'B - 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town',
            'LSTAT - % lower status of the population',
            "MEDV - Median value of owner-occupied homes in \$1000's"
            ];
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "• ${content[index]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                itemCount: content.length,),
              ),
              floatingActionButton: Container(
                transform: Matrix4.translationValues(0.0, -120, 0.0),
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  shape: CircleBorder(),
                  backgroundColor: Colors.black38,
                  child: Icon(Icons.close, color: Colors.white,),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
            );
          },);
        },
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        child: Icon(Icons.info_outline,color: Colors.white,),
      ),
    );
  }
  Widget inputbox(String name, TextEditingController data){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Container(
                width: 70,
                height: 70,
                //color: Colors.grey.shade100,
                child: Card(
                  child: TextFormField(
                    controller: data,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Please enter any value";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 8,),
      ],
    );
  }
}
