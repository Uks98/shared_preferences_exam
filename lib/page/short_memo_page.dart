import 'package:flutter/material.dart';
import 'package:shared2/shared_prePrence/share_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShortMemo extends StatefulWidget {
  const ShortMemo({Key? key}) : super(key: key);

  @override
  State<ShortMemo> createState() => _ShortMemoState();
}

class _ShortMemoState extends State<ShortMemo> {
  TextEditingController memoController = TextEditingController();
  String? _memoText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMemo();
  }

  void getMemo() async {
    final pref = await SharedClass();
    _memoText = await pref.getSharedIdAndPw(key: "memo");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0.0,
        title: Text("오늘 하루를 위한 짧은 메모"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "짧은 메모를 남겨보세요",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
            ),
            child: _memoText!.isEmpty
                ? Text("오늘 하루 메모를 저장해보세요!")
                : Text(
                    "${_memoText}",
                    style: TextStyle(fontSize: 25),
                  ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: memoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "메모를 입력해주세요",
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_memoText!.isEmpty) {
                        _memoText = "메모를 입력해주세요";
                      } else {
                        _memoText = memoController.text;
                      }
                      memoController.clear();
                      final _pref = SharedClass();
                      _pref.setShared(key: "memo", text: _memoText);
                      setState(() {});
                    },
                    child: Text("저장"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
