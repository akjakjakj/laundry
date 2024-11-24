import 'dart:convert';

class NotificationInvoiceModel {
  final int id;
  final String orderId;
  final String posOrderId;
  final String branchId;
  final String branchName;
  final String totalBillNo;
  final String customerName;
  final String customerMobile;
  final String customerEmail;
  final String customerVno;
  final String customerBuilding;
  final String customerApartmentVilla;
  final String customerStreetNo;
  final String subTotal;
  final String? discountAmount;
  final String totalAmount;
  final String taxAmount;
  final String netAmount;
  final String remark;
  final String cardTypeName;
  final String voucherAmount;
  final String onlineReconciliationDeduction;
  final String userableType;
  final String employeeCashierName;
  final String branchAdminCashierName;
  final String waiterName;
  final String deliveryTypeTitle;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;

  NotificationInvoiceModel({
    required this.id,
    required this.orderId,
    required this.posOrderId,
    required this.branchId,
    required this.branchName,
    required this.totalBillNo,
    required this.customerName,
    required this.customerMobile,
    required this.customerEmail,
    required this.customerVno,
    required this.customerBuilding,
    required this.customerApartmentVilla,
    required this.customerStreetNo,
    required this.subTotal,
    this.discountAmount,
    required this.totalAmount,
    required this.taxAmount,
    required this.netAmount,
    required this.remark,
    required this.cardTypeName,
    required this.voucherAmount,
    required this.onlineReconciliationDeduction,
    required this.userableType,
    required this.employeeCashierName,
    required this.branchAdminCashierName,
    required this.waiterName,
    required this.deliveryTypeTitle,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory NotificationInvoiceModel.fromJson(Map<String, dynamic> json) {
    final dataJson = jsonDecode(json['data']);
    return NotificationInvoiceModel(
      id: dataJson['id'],
      orderId: dataJson['order_id'],
      posOrderId: dataJson['pos_order_id'],
      branchId: dataJson['branch_id'],
      branchName: dataJson['branch_name'],
      totalBillNo: dataJson['total_bill_no'],
      customerName: dataJson['customer_name'],
      customerMobile: dataJson['customer_mobile'],
      customerEmail: dataJson['customer_email'],
      customerVno: dataJson['customer_vno'],
      customerBuilding: dataJson['customer_building'],
      customerApartmentVilla: dataJson['customer_apartment_villa'],
      customerStreetNo: dataJson['customer_street_no'],
      subTotal: dataJson['sub_total'],
      discountAmount: dataJson['discount_amount'],
      totalAmount: dataJson['total_amount'],
      taxAmount: dataJson['tax_amount'],
      netAmount: dataJson['net_amount'],
      remark: dataJson['remark'],
      cardTypeName: dataJson['card_type_name'],
      voucherAmount: dataJson['voucher_amount'],
      onlineReconciliationDeduction:
          dataJson['online_reconciliation_deduction'],
      userableType: dataJson['userable_type'],
      employeeCashierName: dataJson['employee_cashier_name'],
      branchAdminCashierName: dataJson['branch_admin_cashier_name'],
      waiterName: dataJson['waiter_name'],
      deliveryTypeTitle: dataJson['delivery_type_title'],
      status: dataJson['status'],
      createdAt: DateTime.parse(dataJson['created_at']),
      updatedAt: DateTime.parse(dataJson['updated_at']),
      type: json['type'],
    );
  }
}
