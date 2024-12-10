part of 'widget_imports.dart';

class PaymentPage extends StatefulWidget {
  final String subscriptionType;
  final String price; // Giá trị price là String, cần chuyển đổi thành double

  PaymentPage({
    required this.subscriptionType,
    required this.price,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int? selectedPlanIndex; // Để theo dõi kế hoạch đã chọn
  int? selectedPaymentMethodIndex; // Để theo dõi phương thức thanh toán đã chọn
  String discountCode = '';
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị mặc định cho giá tổng
    totalPrice = double.tryParse(widget.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  }

  // Hàm tính giá tổng khi chọn kế hoạch
  void updateTotalPrice(double planPrice) {
    setState(() {
      totalPrice = planPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    // Remove ₫ and non-numeric characters
    String cleanedPrice = widget.price.replaceAll(RegExp(r'[^0-9.]'), '');
    double priceValue = double.tryParse(cleanedPrice) ?? 0.0;

    // Calculate price per month for each plan
    double pricePerMonth1 = priceValue; // 1 month
    double pricePerMonth2 = priceValue * 3 * 0.7; // 3 months with 30% off
    double pricePerMonth3 = priceValue * 6 * 0.5; // 6 months with 50% off

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
            Text(
              'User Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Obx(
                  () => TProfileMenu(
                title: 'Username',
                value: controller.user.value.username.isEmpty
                    ? 'No username'
                    : controller.user.value.username,
                onTap: () {},
              ),
            ),
            SizedBox(height: 10),
            Obx(
                  () => TProfileMenu(
                title: 'Email',
                value: controller.user.value.email.isEmpty
                    ? 'No email'
                    : controller.user.value.email,
                onTap: () {},
              ),
            ),
            SizedBox(height: 10),
            Obx(
                  () => TProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber.isEmpty
                    ? 'No phone number'
                    : controller.user.value.phoneNumber,
                onTap: () {},
              ),
            ),
            SizedBox(height: 20),

            // Order Information Section
            Text(
              'Order Information',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Subscription Package: ${widget.subscriptionType}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            // Select a Plan Section (Dọc thay vì ngang)
            Text(
              'Select a Plan:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                // 1 Month Option
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlanIndex = 1;
                      updateTotalPrice(pricePerMonth1);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity, // Kéo dài khung ra 2 bên
                    decoration: BoxDecoration(
                      color: selectedPlanIndex == 1 ? Colors.pink : Colors.transparent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '1 Month',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '₫${pricePerMonth1.toStringAsFixed(2)} /month',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // 3 Month Option
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlanIndex = 2;
                      updateTotalPrice(pricePerMonth2);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity, // Kéo dài khung ra 2 bên
                    decoration: BoxDecoration(
                      color: selectedPlanIndex == 2 ? Colors.pink : Colors.transparent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '3 Months',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '₫${pricePerMonth2.toStringAsFixed(2)} /month',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Save 30%',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // 6 Month Option
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlanIndex = 3;
                      updateTotalPrice(pricePerMonth3);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity, // Kéo dài khung ra 2 bên
                    decoration: BoxDecoration(
                      color: selectedPlanIndex == 3 ? Colors.pink : Colors.transparent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '6 Months',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '₫${pricePerMonth3.toStringAsFixed(2)} /month',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Save 50%',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Payment Method Section (Màu hồng khi chọn phương thức)
            Text(
              'Payment Method:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // MoMo Option
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPaymentMethodIndex = 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selectedPaymentMethodIndex == 1 ? Colors.pink : Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung
                        children: [
                          Text(
                            'MoMo',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Image.asset(
                            'assets/icons/payment_methods/momo.png',
                            width: 50, // Kích thước ảnh
                            height: 50, // Kích thước ảnh
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Khoảng cách giữa MoMo và ZaloPay
                // ZaloPay Option
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPaymentMethodIndex = 2;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selectedPaymentMethodIndex == 2 ? Colors.pink : Colors.transparent,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung
                        children: [
                          Text(
                            'ZaloPay',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Image.asset(
                            'assets/icons/payment_methods/zalopay.png',
                            width: 50, // Kích thước ảnh
                            height: 50, // Kích thước ảnh
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 20),

            // Additional Options Section (Discount)
            Text(
              'Additional Options',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Enter Discount Code',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    // Handle discount code verification here
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  discountCode = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Continue button with total price
            ElevatedButton(
              onPressed: () {
                // Payment logic here
                Get.snackbar('Payment', 'Payment successful!');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Continue', style: TextStyle(fontSize: 18)),
                  Text(
                    '₫${totalPrice.toStringAsFixed(2)} total',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
                minimumSize: Size(double.infinity, 0), // Stretch button to full width
              ),
            ),
          ],
        ),
      ),
    );
  }
}
