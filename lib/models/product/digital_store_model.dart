import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';
import 'package:seller_management/main.export.dart';

class DigitalStoreState {
  DigitalStoreState({
    required this.name,
    required this.categoryId,
    required this.subCategoryId,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaKeywords,
    required this.featuredImage,
    required this.attributes,
    required this.attributeNames,
    required this.attributePrices,
    required this.taxIds,
    required this.taxAmounts,
    required this.taxTypes,
    required this.customerData,
    required this.isPublished,
    required this.slug,
    required this.point,
  });

  factory DigitalStoreState.fromProduct(ProductModel? product) {
    final attribute = <({String name, String price, int id})>[];
    if (product != null) {
      for (var i = 0; i < product.digitalAttributes.length; i++) {
        final e = product.digitalAttributes[i];
        attribute.add((name: e.name, price: '${e.price}', id: i));
      }
    }

    return DigitalStoreState(
      name: product?.name,
      categoryId: product?.category.id.toString(),
      subCategoryId: product?.subCategory?.id.toString(),
      description: product?.description,
      metaTitle: product?.metaTitle,
      metaDescription: product?.metaTitle,
      metaKeywords: product?.metaKeywords,
      featuredImage:
          product?.featuredImage == null ? null : left(product!.featuredImage),
      attributes: attribute,
      attributeNames: product?.digitalAttributes.map((e) => e.name).toList(),
      attributePrices:
          product?.digitalAttributes.map((e) => '${e.price}').toList(),
      taxIds: null,
      taxAmounts: product?.tax.map((e) => '${e.amount}').toList(),
      taxTypes: product?.tax.map((e) => e.isPercentage() ? '0' : '1').toList(),
      customerData: product?.customInfo,
      isPublished: product?.isPublished,
      slug: product?.slug,
      point: product?.clubPoint.toString(),
    );
  }

  final String? name;
  final String? categoryId;
  final String? subCategoryId;
  final String? description;
  final Either<String, File>? featuredImage;
  final String? metaTitle;
  final List<String>? metaKeywords;
  final String? metaDescription;
  final List<String>? attributeNames;
  final List<String>? attributePrices;
  final List<({String name, String price, int id})>? attributes;
  final List<CustomInfo>? customerData;
  final List<String>? taxIds;
  final List<String>? taxAmounts;
  final List<String>? taxTypes;
  final bool? isPublished;
  final String? slug;
  final String? point;

  bool isMetaDataDone() {
    return metaDescription.isNotNullOrEmpty() &&
        metaTitle.isNotNullOrEmpty() &&
        metaKeywords.isNotNullOrEmpty();
  }

  bool isCategoryDone() => categoryId.isNotNullOrEmpty();

  Map<String, dynamic> toMap([bool excludeFile = true]) {
    return {
      'name': name,
      'description': description,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'meta_title': metaTitle,
      'meta_keywords': metaKeywords,
      'meta_description': metaDescription,
      if (!excludeFile) 'featured_image': featuredImage,
      'attribute_option[name]': attributeNames,
      'attribute_option[price]': attributePrices,
      'tax_id': taxIds,
      'tax_amount': taxAmounts,
      'tax_type': taxTypes,
      'data_name': customerData?.map((e) => e.name).toList(),
      'required': customerData?.map((e) => e.isRequired ? '1' : '0').toList(),
      'option_value': customerData?.map((e) => e.options).toList(),
      'type': customerData?.map((e) => e.type.name).toList(),
      'data_label': customerData?.map((e) => e.label).toList(),
      'status': isPublished == true ? 1 : 2,
      'slug': slug,
      'point': point,
    }.removeNullAndEmpty();
  }

  Future<Map<String, MultipartFile?>> toMapMultiPart() async {
    final feature = await featuredImage?.fold(
      (l) => null,
      (r) async => await MultipartFile.fromFile(
        r.path,
        filename: r.path.split('/').last,
      ),
    );

    return {'featured_image': feature};
  }

  DigitalStoreState copyWithMap(Map<String, dynamic> map) {
    return DigitalStoreState(
      name: map.notNullOrEmpty('name') ?? name,
      slug: map.notNullOrEmpty('slug') ?? slug,
      categoryId: categoryId,
      subCategoryId: subCategoryId,
      description: map.notNullOrEmpty('description') ?? description,
      metaTitle: map.notNullOrEmpty('meta_title') ?? metaTitle,
      metaDescription:
          map.notNullOrEmpty('meta_description') ?? metaDescription,
      metaKeywords: metaKeywords,
      featuredImage: featuredImage,
      attributes: attributes,
      attributeNames: attributeNames,
      attributePrices: attributePrices,
      taxIds: taxIds,
      taxAmounts: taxAmounts,
      taxTypes: taxTypes,
      customerData: customerData,
      isPublished: isPublished,
      point: map.notNullOrEmpty('point') ?? point,
    );
  }

  DigitalStoreState copyWith({
    ValueGetter<String?>? name,
    ValueGetter<String?>? categoryId,
    ValueGetter<String?>? subCategoryId,
    ValueGetter<String?>? description,
    ValueGetter<Either<String, File>?>? featuredImage,
    ValueGetter<String?>? metaTitle,
    ValueGetter<List<String>?>? metaKeywords,
    ValueGetter<String?>? metaDescription,
    ValueGetter<List<String>?>? attributeNames,
    ValueGetter<List<String>?>? attributePrices,
    ValueGetter<List<({String name, String price, int id})>?>? attributes,
    ValueGetter<List<String>?>? taxIds,
    ValueGetter<List<String>?>? taxAmounts,
    ValueGetter<List<String>?>? taxTypes,
    ValueGetter<List<CustomInfo>?>? customerData,
    ValueGetter<bool?>? isPublished,
    ValueGetter<String?>? slug,
    ValueGetter<String?>? point,
  }) {
    return DigitalStoreState(
      name: name != null ? name() : this.name,
      categoryId: categoryId != null ? categoryId() : this.categoryId,
      subCategoryId:
          subCategoryId != null ? subCategoryId() : this.subCategoryId,
      description: description != null ? description() : this.description,
      featuredImage:
          featuredImage != null ? featuredImage() : this.featuredImage,
      metaTitle: metaTitle != null ? metaTitle() : this.metaTitle,
      metaKeywords: metaKeywords != null ? metaKeywords() : this.metaKeywords,
      metaDescription:
          metaDescription != null ? metaDescription() : this.metaDescription,
      attributes: attributes != null ? attributes() : this.attributes,
      attributeNames:
          attributeNames != null ? attributeNames() : this.attributeNames,
      attributePrices:
          attributePrices != null ? attributePrices() : this.attributePrices,
      taxIds: taxIds != null ? taxIds() : this.taxIds,
      taxAmounts: taxAmounts != null ? taxAmounts() : this.taxAmounts,
      taxTypes: taxTypes != null ? taxTypes() : this.taxTypes,
      customerData: customerData != null ? customerData() : this.customerData,
      isPublished: isPublished != null ? isPublished() : this.isPublished,
      slug: slug != null ? slug() : this.slug,
      point: point != null ? point() : this.point,
    );
  }
}
