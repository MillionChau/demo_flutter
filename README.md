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

### Bước 7: Phát triển frontend và kiểm thử
    


