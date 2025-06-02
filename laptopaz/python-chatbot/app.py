from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)  # Cho phép truy cập từ frontend (JS)


def find_products(keyword):
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='12345678',
        database='laptopshop'
    )
    cursor = conn.cursor(dictionary=True)

    words = keyword.split()
    like_clauses = " OR ".join(["name LIKE %s COLLATE utf8mb4_bin OR description LIKE %s COLLATE utf8mb4_bin"] * len(words))
    values = []
    for word in words:
        values.append(f"%{word}%")
        values.append(f"%{word}%")  # mỗi từ 2 lần: cho name và description

    sql = f"""
        SELECT product_id, name, price, final_price, description 
        FROM products 
        WHERE ({like_clauses}) AND is_deleted = FALSE
        LIMIT 10
    """
    cursor.execute(sql, values)
    products = cursor.fetchall()

    cursor.close()
    conn.close()
    return products
waiting_for_laptop_name = False

# Hàm xử lý chatbot dùng chung cho cả /predict và /query
def get_bot_response(message: str) -> str:
    global waiting_for_laptop_name

    message = message.lower().strip()

    if not message:
        return "Xin lỗi, tôi không hiểu câu hỏi."

    # Nếu đang chờ tên laptop thì tìm luôn
    if waiting_for_laptop_name:
        waiting_for_laptop_name = False
        products = find_products(message)

        if products:
            response = "🔍 Các sản phẩm phù hợp:\n"
            for p in products[:5]:
                price = p["final_price"] or p["price"]
                product_url = f"http://localhost:8181/product/{p['product_id']}"
                response += f"- {p['name']} (Giá bán: {price:,} VNĐ)\n 👉 {product_url}\n"
        else:
            response = "❌ Không tìm thấy sản phẩm phù hợp."
        return response

    # Khi user gửi "giới thiệu laptop" thì trả lời câu hỏi để hỏi tiếp
    if "giới thiệu laptop" in message:
        waiting_for_laptop_name = True
        return "Bạn muốn mình tư vấn về mẫu laptop nào?"

    if "giới thiệu về cửa hàng" in message or "laptopaz là gì" in message:
        return (
            "LaptopAZ là cửa hàng chuyên cung cấp laptop chính hãng, giá tốt, bảo hành uy tín.\n"
            "🏢 LaptopAZ cơ sở Thái Hà:\n"
            "Số 18, ngõ 121, Thái Hà, Đống Đa, Hà Nội\n"
            "🕒 Bán hàng: Từ 8h30 - 21h30\n"
            "🛠️ Kỹ thuật: Từ 8h30 - 12h & 13h30 - 17h30\n"
            "🏢 LaptopAZ cơ sở Hà Đông:\n"
            "Số 56 Trần Phú, Hà Đông, Hà Nội\n"
            "🕒 Bán hàng: Từ 8h30 - 21h30\n"
            "🛠️ Kỹ thuật: Từ 8h30 - 12h & 13h30 - 17h30"
        )
    elif "bảo hành" in message:
        return ("Tất cả sản phẩm tại LaptopAZ được bảo hành từ 6 đến 24 tháng, tùy theo từng dòng sản phẩm.\n"
                "Nếu cần hỗ trợ bảo hành, vui lòng liên hệ hotline 096.123.4567 hoặc email support@laptopaz.vn.")

    elif "liên hệ" in message or "sdt" in message or "số điện thoại" in message:
        return "Bạn có thể liên hệ với LaptopAZ qua số điện thoại: 096.123.4567 hoặc fanpage Facebook: https://www.facebook.com/profile.php?id=61574779367886"
    elif "xin chào" in message:
        return "Xin chào, tôi có thể giúp gì cho bạn"
    elif "tìm máy tính" in message:
        return (
            "Mình có thể giúp bạn tìm laptop theo:\n"
            "- Nhu cầu: học tập, đồ họa, chơi game...\n"
            "- Hãng: Dell, ASUS, HP, Lenovo...\n"
            "Bạn vui lòng cho biết thêm yêu cầu nhé!"
        )
    elif "giao hàng" in message or "ship" in message or "vận chuyển" in message:
        return (
            "🚚 LaptopAZ có giao hàng toàn quốc:\n"
            "- 📦 Nội thành Hà Nội: giao trong 1 ngày\n"
            "- 🛫 Các tỉnh/thành khác: 2-4 ngày\n"
            "- 💸 Phí vận chuyển đồng giá 30.000đ\n"
            "Bạn có thể chọn giao hàng khi thanh toán đơn hàng."
        )
    elif "thanh toán" in message or "trả góp" in message or "trả sau" in message or "cod" in message:
        return (
            "💳 LaptopAZ hỗ trợ các phương thức thanh toán sau:\n"
            "- Thanh toán khi nhận hàng (COD)\n"
            "- Chuyển khoản ngân hàng\n"
            "Bạn cần hỗ trợ hình thức nào cụ thể ạ?"
        )

    elif "mua hàng" in message or "đặt hàng" in message:
        return (
            "Hướng dẫn cách đặt hàng trên website:\n"
            "1. Truy cập vào trang sản phẩm bạn muốn mua.\n"
            "2. Chọn cấu hình, số lượng và bấm nút 'Thêm vào giỏ hàng'.\n"
            "3. Vào giỏ hàng, kiểm tra đơn hàng và bấm 'Thanh toán'.\n"
            "4. Điền thông tin giao hàng và chọn phương thức thanh toán.\n"
            "5. Xác nhận đơn hàng và chờ nhân viên liên hệ xác nhận.\n\n"
            "Nếu cần hỗ trợ, vui lòng gọi hotline 096.123.4567 để được tư vấn nhanh chóng"
        )
    elif "cảm ơn" in message or "thanks" in message:
        return "Rất vui được hỗ trợ bạn. Chúc bạn một ngày tốt lành!"

    if "laptop" in message or "máy" in message:
        for stopword in ["laptop", "máy"]:
            message = message.replace(stopword, "").strip()

        products = find_products(message)
        if products:
            response = "🔍 Các sản phẩm phù hợp:\n"
            for p in products[:5]:
                price = p["final_price"] or p["price"]
                product_url = f"http://localhost:8181/product/{p['product_id']}"
                response += f"- {p['name']} (Giá bán: {price:,} VNĐ)\n 👉 {product_url}\n"
        else:
            response = "❌ Không tìm thấy sản phẩm phù hợp."
        return response

    return "Xin lỗi, mình chưa hiểu câu hỏi của bạn. Vui lòng hỏi rõ hơn hoặc gọi hotline 096.123.4567."
# Định nghĩa endpoint /predict
@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()
    message = data.get("message", "")
    response = get_bot_response(message)
    return jsonify({"answer": response})


# Định nghĩa endpoint /query
@app.route("/query", methods=["POST"])
def query():
    data = request.get_json()
    query = data.get("query", "")
    response = get_bot_response(query)
    return jsonify({"response": response})


if __name__ == "__main__":
    app.run(debug=True)
