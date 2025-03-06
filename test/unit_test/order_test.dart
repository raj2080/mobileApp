import 'package:blushstore/features/order/data/model/ShippingInfoModel.dart';
import 'package:blushstore/features/order/data/model/order_model.dart';
import 'package:blushstore/features/order/domain/entity/OrderEntity.dart';
import 'package:blushstore/features/order/domain/entity/ShippingInfoEntity.dart';
import 'package:blushstore/features/order/domain/usecases/order_use_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

@GenerateMocks([CreateOrderUseCase, GetUserOrdersUseCase])
void main() {
  const tOrderModel = OrderModel(
    id: '1',
    orderStatus: 'Delivered',
    totalPrice: 100,
    shippingInfo: ShippingInfoModel(
      address: '123 Main St',
      city: 'Metropolis',
      country: 'Country',
      phoneNo: 123456789, // Changed to match test data
      province: 'bagmati',
      postalCode: 444,
    ),
    orderItems: [],
    user: '123',
    paymentInfo: 'cash on delivery',
    itemsPrice: 300,
    taxPrice: 30,
    shippingPrice: 40,
  );

  const tOrderEntity = OrderEntity(
    id: '1',
    orderStatus: 'Delivered',
    totalPrice: 100,
    shippingInfo: ShippingInfoEntity(
      address: '123 Main St',
      city: 'Metropolis',
      country: 'Country',
      phoneNo: 123456789,
      province: 'bagmati',
      postalCode: 444,
    ),
    orderItems: [],
    user: '123',
    paymentInfo: 'cash on delivery',
    itemsPrice: 300,
    taxPrice: 30,
    shippingPrice: 40,
  );

  test('fromJson and toJson', () {
    final jsonMap = {
      '_id': '1',
      'orderStatus': 'Delivered',
      'totalPrice': 100.00,
      'shippingInfo': {
        'address': '123 Main St',
        'city': 'Metropolis',
        'country': 'Country',
        'phoneNo': '123-456-7890',
        'province': 'bagmati',
        'postalCode': 444,
      },
      'orderItems': [],
      'user': '123',
      'paymentInfo': 'cash on delivery',
      'itemsPrice': 300,
      'taxPrice': 30,
      'shippingPrice': 40,
    };

    final result = OrderModel.fromJson(jsonMap);
    expect(result, tOrderModel);
    expect(result.toJson(), jsonMap);
  });

  test('toEntity and fromEntity', () {
    final entityResult = tOrderModel.toEntity();
    expect(entityResult, tOrderEntity);

    final fromEntityResult = OrderModel.fromEntity(tOrderEntity);
    expect(fromEntityResult, tOrderModel);
  });

  test('Equatable props', () {
    expect(tOrderModel.props, [
      '1',
      'Delivered',
      100.00,
      ShippingInfoModel(
        address: '123 Main St',
        city: 'Metropolis',
        country: 'Country',
        phoneNo: 123456789,
        province: 'bagmati',
        postalCode: 444,
      ),
      [],
      '2024-08-01T12:00:00Z',
      '',
      'cash on delivery',
      300,
      30,
      40,
    ]);
  });
}
