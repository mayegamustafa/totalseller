import 'package:seller_management/main.export.dart';

class ProductRepo extends Repo {
  FutureResponse<PagedItem<ProductModel>> getDigitalPRoduct({
    String? status,
    String? search,
  }) async {
    final data = await rdb.getDigitalProduct(status ?? '', search ?? '');
    return data;
  }

  FutureResponse<PagedItem<ProductModel>> getPhysicalProduct({
    String? status,
    String? search,
  }) async {
    final data = await rdb.getPhysicalProduct(search ?? '', status ?? '');
    return data;
  }

  FutureResponse<PagedItem<ProductModel>> getProductByUrl(String url) async {
    final data = await rdb.getProductByUrl(url);
    return data;
  }

  FutureResponse<ProductModel> getProductDetails(String id) async {
    final data = await rdb.productDetails(id);
    return data;
  }

  FutureResponse<ProductModel> storeDigitalAttribute(
      String uid, QMap formData) async {
    final data = await rdb.digitalAttributeStore(uid: uid, formData: formData);
    return data;
  }

  FutureResponse<ProductModel> updateDigitalAttribute(
    String uid,
    QMap formData,
  ) async {
    final data = await rdb.digitalAttributeUpdate(uid: uid, formData: formData);
    return data;
  }

  FutureResponse<ProductModel> attributeValueStore(
    String uid,
    QMap formaData,
  ) async {
    final data = await rdb.productAttributeValueStore(
      uid: uid,
      formaData: formaData,
    );
    return data;
  }

  FutureResponse<ProductModel> attributeValueUpdate(
    String uid,
    String valueUid,
    QMap formaData,
  ) async {
    final data = await rdb.productAttributeValueUpdate(
      uid: uid,
      valueUid: valueUid,
      formaData: formaData,
    );
    return data;
  }

  FutureResponse<ProductModel> attributeDelete(String id) async {
    final data = await rdb.attributeDelete(id);
    return data;
  }

  FutureResponse<ProductModel> attributeValueDelete(
    String id,
  ) async {
    final data = await rdb.attributeValueDelete(id);
    return data;
  }

  FutureResponse<String> deleteGalleryImage(
    String id,
  ) async {
    final data = await rdb.deleteGalleryImage(id);
    return data;
  }

  FutureResponse<String> productDelete(
    String id,
  ) async {
    final data = await rdb.productDelete(id);
    return data;
  }

  FutureResponse<String> deletePermanently(
    String id,
  ) async {
    final data = await rdb.deletePermanently(id);
    return data;
  }

  FutureResponse<String> productRestore(
    String id,
  ) async {
    final data = await rdb.productRestore(id);
    return data;
  }
}
