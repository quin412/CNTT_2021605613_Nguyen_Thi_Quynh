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

    # Tách từ khóa thành các từ riêng
    words = keyword.split()
    like_clauses = " AND ".join(["name LIKE %s"] * len(words))
    values = [f"%{word}%" for word in words]

    sql = f"""
        SELECT name, price, final_price, description 
        FROM products 
        WHERE {like_clauses} AND is_deleted = FALSE 
        LIMIT 5
    """
    cursor.execute(sql, values)
    products = cursor.fetchall()

    print(f"Tìm kiếm: {keyword}")
    print(f"Kết quả: {products}")

    cursor.close()
    conn.close()
    return products

# Hàm xử lý chatbot dùng chung cho cả /predict và /query
def get_bot_response(message: str) -> str:
    message = message.lower()

    if not message.strip():
        return "Xin lỗi, tôi không hiểu câu hỏi."

    if "giới thiệu" in message or "laptopaz là gì" in message:
        return "LaptopAZ là cửa hàng chuyên cung cấp laptop chính hãng, giá tốt, bảo hành uy tín."

    elif "giờ làm việc" in message:
        return "LaptopAZ làm việc từ 8h00 đến 21h00 tất cả các ngày trong tuần."

    elif "địa chỉ" in message:
        return "LaptopAZ có địa chỉ tại: 10 Trần Đại Nghĩa, Hai Bà Trưng, Hà Nội."

    elif "bảo hành" in message:
        return "Tất cả sản phẩm tại LaptopAZ được bảo hành từ 6 đến 24 tháng, tùy theo từng dòng sản phẩm."

    elif "liên hệ" in message or "sdt" in message or "số điện thoại" in message:
        return "Bạn có thể liên hệ với LaptopAZ qua số điện thoại: 096.123.4567 hoặc fanpage Facebook."

    elif "khuyến mãi" in message or "giảm giá" in message:
        return "Hiện tại LaptopAZ có chương trình khuyến mãi giảm giá lên đến 15% cho nhiều dòng laptop."

    elif "mua hàng" in message or "đặt hàng" in message:
        return "Bạn có thể đặt hàng trực tiếp trên website hoặc gọi đến 096.123.4567 để được tư vấn nhanh chóng."

    elif "cảm ơn" in message or "thank" in message:
        return "Rất vui được hỗ trợ bạn. Chúc bạn một ngày tốt lành!"

    elif "laptop" in message or "máy" in message:
        for stopword in ["laptop", "máy"]:
            message = message.replace(stopword, "").strip()

        # Bây giờ message chỉ còn phần còn lại, ví dụ "dell"
        products = find_products(message)
        if products:
            response = "Các sản phẩm phù hợp:\n\n"  # Thêm dòng trống sau tiêu đề
            for p in products:
                price = p["final_price"] or p["price"]
                # Tạo 1 dòng riêng cho từng sản phẩm, cách nhau bằng dòng mới
                response += f"- {p['name']}:\n  Giá: {price:,} VNĐ\n  Mô tả: {p['description']}\n\n"
        else:
            response = "Không tìm thấy sản phẩm phù hợp."
        return response

    else:
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
