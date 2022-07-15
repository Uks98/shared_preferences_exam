import 'package:flutter/material.dart';
import 'package:shared2/page/short_memo_page.dart';
import 'package:shared2/shared_prePrence/share_class.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? _id; String? _pw;


  void getIdAndPw()async{
    final pref = await SharedClass();
    _id = await pref.getSharedIdAndPw(key:"id");
    _pw = await pref.getSharedIdAndPw(key:"pw");
    print("id는 ${_id}입니다");
    print("pw는 ${_pw}입니다");
    setState((){});
  }

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdAndPw();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("exam shared pack",),
        actions: [
          IconButton(onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ShortMemo())), icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: TextField(
                controller: idController,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "아이디를 입력해주세요.",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 30, 16, 0),
              child: TextField(
                controller: pwController,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "비밀번호를 입력해주세요",
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: ()async{
                  _id = idController.text;
                  _pw = pwController.text;
                  final pref = await SharedClass();
                  pref.setShared(key:"pw",text:_pw);
                  pref.setShared(key:"id",text:_id);
                  setState((){});
                }, child: Text("저장하기"))),
              ],
            ),
            Text("아이디: ${_id}",style: TextStyle(fontSize: 20),),
            Text("비밀번호: ${_pw}",style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
