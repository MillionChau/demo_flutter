import 'dart:io';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final _router = Router(notFoundHandler: _notFoundHandler)
  ..get('/', _rootHandler)
  ..get('/api/v1/check', _checkHandler)
  ..get('/api/v1/echo/<message>', _echoHandler)
  ..post('/api/v1/submit', _submitHandler);

// Header mặc định cho dữ liệu trả về dưới dạng JSON
final _headers = {'ContentType': 'application/json'};

// Xử lí các yêu cầu các đường dẫn không được định nghĩa (404 Not Found).
Response _notFoundHandler(Request req){
  return Response.notFound('Không tìm thấy đường dẫn "${req.url}" trên server');
}

// Hàm sử lý các yêu cầu gốc tại đường dẫn '/

// Trả về phản hồi với thông điệp 'Hello, World!' dưới dạng JSON

// [req]: Đối tượng yêu cầu từ client

// Trả về: Một đối tượng `Response` với mã trạng thái 200 dưới dạng JSON
Response _rootHandler(Request req) {
  // Constructor `ok` của Response có statusCode là 200
  return Response.ok(
    json.encode({'message': 'Hello, World!'}),
    headers: _headers,
  );
}

Response  _checkHandler(Request req) {
  return Response.ok(
    json.encode({'message': 'Chào mừng bạn đến với ứng dụng web động'}),
    headers: _headers,
  );
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _submitHandler(Request req) async{
  try{
    // Đọc payload từ request
    final payload = await req.readAsString();

    // Giải mã JSON từ payload
    final data = jsonDecode(payload);

    // Kiểm tra name nếu hợp lệ
    final name = data['name'] as String?;

    // Tạo phản hồi chào mừng
    if (name != null && name.isNotEmpty) {
      final response = {'message': 'Chào mừng ${name}!'};
    
      // Trả về phản hồi với statusCode 200 và nội dung JSON
      return Response.ok(
        json.encode(response),
        headers: _headers,
      );
    } else {
      // Tạo phản hồi yêu cầu cung cấp tên
      final response = {'message': 'Server không nhận được tên của bạn.'};

      // Trả về phản hồi với statusCode 400 và nội dung JSON
      return Response.ok(
        json.encode(response),
        headers: _headers,
      );
    }
    
    
  } catch(e) {
    // 
    final response = {
      'message': 'Yêu cầu không hợp lệ. Mã lỗi ${e.toString()}'
    };
    // 
    return  Response.badRequest(
      body: json.encode(response),
      headers: _headers,
    );
  }
}

void main(List<String> args) async {
  // Lắng nghe tất cả địa chỉ IPv4
  final ip = InternetAddress.anyIPv4;

  final corsHeader = createMiddleware(
    requestHandler: (req) {
      if(req.method == 'OPTIONS') {
        return Response.ok(
          '',
          headers: {
            'Access-Control-Alow-Origin': '*',// Cho phép mọi nguồn truy cập(môi trường trong dev). Trong môi trường production ta thay * bằng domain cụ thể 
            'Access-Control-Alow-Methods': 'GET,  POST, PUT, DELETE, PATCH, HEAD',
            'Access-Control-Alow-Headers': 'Content-Type,Authorization',
          }
        );
      }
      return null; //Tiếp tục xử lý các yêu cầu khác
    },
    responseHandler: (res) {
      return res.change(headers:  {
        'Access-Control-Alow-Origin': '*',// Cho phép mọi nguồn truy cập(môi trường trong dev). Trong môi trường production ta thay * bằng domain cụ thể 
            'Access-Control-Alow-Methods': 'GET,  POST, PUT, DELETE, PATCH, HEAD',
            'Access-Control-Alow-Headers': 'Content-Type,Authorization',
      });
    }
  );
  // Cấu hình một pipeline để logs các request và middleware
  final handler = Pipeline()
    .addMiddleware(corsHeader)
    .addMiddleware(logRequests())
    .addHandler(_router.call);

  // Để chạy trên các container, chúng ta sử dụng biến mội trường POST,
  // Nếu biến môi trường không được thiết lập nó sẽ sử dụng giá trị từ biến
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  // Khởi chạy server tại cổng chỉ định
  final server = await serve(handler, ip, port);
  print('Server đang chạy tại http://${server.address.host}:${server.port}');
}
