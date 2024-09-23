# Làm quen với ứng dụng web đơn giản sử dụng flutter và dart

Trong bài lab này tôi sẽ hướng dẫn phát triển ứng dụng full-stack đơn giản với Dart và Flutter bao gồm cả backend và frontend

Việc sử dụng các framework hiện đại trong quá trình phát triển ứng dụng web giúp tăng tốc quá trình phát triển và dễ dàng quản lí dự án, Flutter là một công cụ phát triển ứng dụng đa nền tảng, cho phép chúng ta tạo ra các ứng dụng cho web di động (Android, iOS) và desktop (Window, macOS) từ cùng một dự án mã nguồn (codebase). Điều này giúp chúng ta tiết kiệm thời gian và công sức khi chúng ta chỉ cần viết mã một lần mà có thể biên dịch để chạy trên nhiều nền tảng khác nhau.

Quá trình biên dịch và phát hành ứng dụng web từ dart và Framework sẽ tự động sinh ra mã cho backend và cho frontend (HTML, CSS, Js) mà chúng ta không cần phải viết trực tiếp. Điều này giúp chúng ta tập trung vào logic ứng dụng và giảm thiểu thời gian viết mã lặp lại. Tương tự, khi biên dịch ra các nền tảng di động hay desktop, chúng cũng sinh ra ứng dụng native trên cùng một codebase.

## Mục tiêu
- Hiểu và áp dụng được các khái niệm cơ bản về ứng dụng web động, ứng dụng đa nền tảng.
- sử dụng Flutter framework  để tạo giao diện cơ bản cho một ứng dụng.
- Sử dụng dart và thư viện shelf, shelf_router để tạo server đơn giản xử lí các yêu cầu HTTP theo chuẩn RESTful API
- Tích hợp giao diện với logic xử lí phản hồi từ server, thực hiện thao tác gửi dữ liệu từ client lên server thông qua HTTP POST.
- Kiểm thử đơn giản với Postman để kiểm tra phản hồi từ server với các yêu cầ get và post bao gồm cả trường hợp hợp lệ và không hợp lệ

## Cấu trúc thư mục
Để tiện cho việc quản lí và có thể đẩy lên github, chúng ta sẽ cài đặt backend và frontend trên cùng một thư mục dự án.
```plaintext
    !-- frontend/ # thư mục chứa mã nguồn Dart và Flutter cho frontend
    !-- backend/ # thư mục chứa mã nguồn dart cho backend
```

## Các bước thực hiện
### Bước 1: Khởi tạo dự án
1. Tạo thư mục gốc chứa dự án `simple_flutter_project`
2. Tạo thư mục `backend` và `frontend` trong thư mục `simple_flutter_project` như cấu trúc ở trên
3. Mở ứng dụng VSCode và mở thư mục `simple_flutter_project`

### Bước 2: Tạo ứng dụng server cho backend với dart framwork
1. Đi đến thư mục backend từ thư mục `simple_flutter_project`
```bash
    cd backend
```

2. Khởi tạo dự án Dart mới cho server
```bash
    dart create -t server-shelf . --force
```

    **Lưu ý:**
    - Nếu bạn chưa cài đặt Flutter, hãy truy cập vào https://docs.flutter.dev/get-started/install/windows/web để tải về và cài đặt theo hướng dẫn. Bạn có thể chọn nền tảng Windows hoặc macOS của bạn
    - Lệnh `dart create -t server-shelf . --force` sẽ tạo một dự án Dảt với mẫu `-t, template` là `server-shelf` trong thư mục hiện tại `.` và tham số `--force` cho biết sẽ tạo dự án cho dù thư mục gốc đã tồn tại(mặc định là sẽ tạo mới thư mục)
    3. Thêm các thư viện backend nếu cần
    - Trong ứng dụng mẫu `server-shelf`, flutter đã sử dụng các thư viện `shelf` và `shelf-router` trong tệp `pubpec.yaml`
    - Các bạn có thể xem thêm các thư viện khác trên `https://pub.dev/`
### Bước 3: Tạo ứng dụng frontend bằng flutter framwork
1. Quay lại thư mục dự án chính(Nếu đang trong thư mục backend)
```bash
    cd ..
```

2. Chuyển đến thư mục frontend
```bash
    cd frontend
```
3. Khởi tạo dự án Flutter với thư mục frontend
```bash
    flutter create -e .
```

    **Lưu ý:** Lệnh trên sẽ tạo một dự án Flutter mới trong thư mục frontend với mẫu là `Empty Application` với tham số `-e` và tham số dấu `.` cho biết sẽ khởi tạo trong thư mục hiện tại là thư mục `frontend`
4. Thêm thư viện `http` vào dự án frontend
```bash
    flutter pub add http
```
### Bước 4: Thiết lập debug cho cả backend và frontend
- Mở tệp `frontend/lib/main.dart` trước
- Chọn `run and debug` ở thanh sidebar và chọn `create a launch` đẻ tạo file gỡ lỗi(debug).
- Tiến hành gỡ lỗi backend và frontend
**Lưu ý:** Chúng ta thiết lập cổng mặc định cho server backend là 8080 và cổng mặc định cho frontend là 8081 khi debug. Các bạn có thể thay đổi cổng.

### Bước 5: Đẩy thư mục lên Github và quản lí mã nguồn
- Chọn `Source Control` ở thanh Side Bả và chọn `Publish to Github`.
- Quản lý mã nguồn bằng cách commit, push(Sync Changes...), pull... từ cửa sổ `Source Control`.
**Lưu ý:** Nếu bạn chưa có git thì hã cài đặt Git(Tham khảo google). Các bạn cũng cần một chút kiến thức sử dụng Github từ google cũng khá là dễ.
### Bước 6: Phát triển backend và kiểm thử
1. Chỉnh sửa file `backend/bin/server.dart`:
- Mở file `server.dart` và chỉnh sửa:
```dart
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
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
```
2. Debug và kiểm thử với postman
3. Thêm Middleware xử lí CORS cho backend
- **CORS là gì?** CORS (Cross-Origin Resource Sharing) là một cơ chế bảo mật được các trình duyệt web sử dụng để ngăn chặn các wen gửi yêu cầu đến một domain khác với domain của trang web hiện tại. Điều này nhằm bảo vệ người dùng khỏi các cuộc tấn công CSRF (Cross-Site Request Forgery) và các mối đe doạ bảo mật khác.
- **Vì sao cần thêm CORS middleware?** khi frontend (Flutter Web) gửi yêu cầu HTTP đến backend trên một domain khác, trình duyệt web sẽ chặn yêu cầu do vi phạm chính sách cùng nguồn gốc (Same-Origin Policy). Các yêu cầu từ Flutter Web(chạy trên localhost:8081) đến server backend (chạy trên localhost:8080) sẽ bị chặn nếu không xử lý đúng các header CORS. trình duyệt sẽ gửi một yêu cầu OPTIONS (Preflight Request) để kiểm tả xem server có cho phép không. Nếu server không phản hồi đúng, yêu cầu chính sẽ không được gửi.
- **Giải pháp:** Thêm middlewware xử lí CORS và server backend để xử lí các yêu cầu OPTIONS bằng cách trả về các header CORS cần thiết. Thêm các header CORS vào tất cả các phản hồi từ server để trình duyệt cho phép giao tiếp giữa frontend và backend. 

- Cập nhật mã nguồn hàm main của servers
```dart
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
```

### Bước 7: Phát triển frontend và kiểm thử
1. Chỉnh sửa mã nguồn frontend
- Mở tệp `frontend/lib/main.dart` và thay thế nội dung bằng mã sau:
```dart

```


