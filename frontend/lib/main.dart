import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Hàm main là điểm bắt đầu ứng dụng
void main() {
  runApp(const MainApp()); //Chạy ứng dụng với widget MainApp
}

// Widget MainAp là Widget gốc ứng dụng, sử dụng một StatelessWidget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false, //Tắt biểu tượng debug góc trên bên phải
      title: 'Ứng dụng full-stack flutter đơn giản',
      home: MyHomePage(),
    );
  }
}

// Widget MyHomePage là trang chính ứng dụng, sử dụng StatefulWidget
// Để quản lí trạng thái nội dung cần thay đổi trên trang này
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

// Lớp state cho MyHomePage
class _MyHomePageState extends State<MyHomePage> {
// Controller để lấy dữ liệu từ Widget TextField
final controller = TextEditingController();

// Biến để lưu thông điệp phản hồi từ server
String responseMessage = "";

// Hàm để gửi tên tới server
Future<void> sendName() async{
  //Lấy tên từ TextField
  final name = controller.text;
  // Sau khi lấy được tên thì xoá nội dung trong controller
  controller.clear();
  // Endpoint submit
  final url = Uri.parse("http://localhost:8080/api/v1/submit");
  try {
    // Gửi yêu cầu POST tới server
    final response = await http
    .post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    )
    .timeout(const Duration(seconds: 10));
    // Kiểm tra phản hồi có nội dung
    if(response.body.isNotEmpty) {
      // Giải mã phản hồi từ server
      final data = json.decode(response.body);

      // Cập nhật trạng thái với thông điệp nhận được từ server
      setState(() {
        responseMessage = data['message'];
      });
    } else {
      // Phản hồi không có nội dung
      setState(() {
        responseMessage = 'Không nhận được phản hồi từ server';
      });
    }
  } catch(e) {
    // Xử lý lỗi kết nối hoặc lỗi khác
    setState(() {
      responseMessage = "Đã xảy ra lỗi: ${e.toString()}";
    });
  }
}

 @override
 Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(title: const Text('Ứng dụng full-stack flutter đơn giản')),
    body: Column(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Tên:"),
        ),
        const SizedBox(height: 20,),
        FilledButton(
          onPressed: sendName, 
          child: const Text('Gửi'),
        ),
        Text(
        responseMessage,
        style: Theme.of(context).textTheme.titleLarge,
        )
      ],
    ),
  );
 }
}