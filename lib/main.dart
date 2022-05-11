import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InformationScreen(),
    );
  }
}

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController diemToan = TextEditingController();
  TextEditingController diemVan = TextEditingController();
  TextEditingController diemAnh = TextEditingController();

  String diemTrungBinh = 'Chua xac dinh';
  String danhGia = 'Chua xac dinh';
  String nameShow = 'Chua xac dinh';
  String diemToanShow = 'Chua xac dinh';
  String diemVanShow = 'Chua xac dinh';
  String diemAnhShow = 'Chua xac dinh';
  showInfo() {
    setState(() {
      nameShow = userName.text;
      diemToanShow = double.parse(diemToan.text).toString();
      diemVanShow = double.parse(diemVan.text).toString();
      diemAnhShow = double.parse(diemAnh.text).toString();
      double toan = double.parse(diemVan.text);
      double van = double.parse(diemVan.text);
      double anh = double.parse(diemAnh.text);

      double check = ((toan + van + anh) / 3);
      diemTrungBinh = check.toString();

      if (check >= 8.5)
        danhGia = 'Loại giỏi';
      else if (check >= 6.5 && check < 8.5)
        danhGia = 'Loại Khá';
      else if (check >= 5 && check < 6.5)
        danhGia = 'Loại Trung Bình';
      else
        danhGia = 'Loại Yếu kém';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Thông tin học sinh',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Column(
            children: [
              //nhap ho ten
              inputInformation(
                labelText: 'Ho va Ten',
                hintText: 'nhap ho va ten',
                controller: userName,
              ),
              //nhap diem mon Toan
              inputInformation(
                  labelText: 'Diem Toan',
                  hintText: 'nhap diem mon toan',
                  controller: diemToan),
              //nhap diem mon Van
              inputInformation(
                  labelText: 'Diem Van',
                  hintText: 'nhap diem mon van',
                  controller: diemVan),
              inputInformation(
                  labelText: 'Diem Anh',
                  hintText: 'nhap diem mon Anh',
                  controller: diemAnh),
              ElevatedButton(
                  onPressed: showInfo, child: const Text('Show Result')),
              const SizedBox(
                height: 20,
              ),
              Card(
                child: Container(
                  width: 300,
                  child: Column(
                    children: [
                      Text('Ho va Ten: $nameShow',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Diem mon Toan : $diemToanShow',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Diem mon Van : $diemVanShow',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Diem mon Anh : $diemAnhShow',
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Diem Trung Binh la: $diemTrungBinh',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.redAccent)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Đánh Giá: $danhGia',
                          style: const TextStyle(fontSize: 20))
                    ],
                  ),
                  color: Colors.lightGreenAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputInformation(
    {required String labelText,
    required String hintText,
    required controller}) {
  return Container(
    padding: const EdgeInsets.only(top: 5, bottom: 15),
    child: TextField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText),
      controller: controller,
    ),
  );
}
