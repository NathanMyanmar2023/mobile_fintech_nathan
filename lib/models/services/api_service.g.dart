// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://thecreatorcreates.com/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AddToCartResponseObject> addToCart(
    String token,
    String apiKey,
    int quantity,
    int productId,
    String language,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': token,
      r'X-API-KEY': apiKey,
      r'setLanguage': language,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'quantity': quantity,
      'product_id': productId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddToCartResponseObject>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'http://thecreatorcreates.com/api/add_to_cart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AddToCartResponseObject.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddToCartResponseObject> makeCheckOut(
    String token,
    String apiKey,
    int townshipId,
    String address,
    String language,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': token,
      r'X-API-KEY': apiKey,
      r'setLanguage': language,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'township_id': townshipId,
      'address': address,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddToCartResponseObject>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'http://thecreatorcreates.com/api/checkout',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AddToCartResponseObject.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CartResponseObject> getCart(
    String token,
    String apiKey,
    String language,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': token,
      r'X-API-KEY': apiKey,
      r'setLanguage': language,
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CartResponseObject>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'http://thecreatorcreates.com/api/cart',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CartResponseObject.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeliveryRegionResponseObject> getDeliveryRegions(
    String token,
    String apiKey,
    String language,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': token,
      r'X-API-KEY': apiKey,
      r'setLanguage': language,
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeliveryRegionResponseObject>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'http://thecreatorcreates.com/api/delivery/regions',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DeliveryRegionResponseObject.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeliveryTownshipResponseObject> getDeliveryTownships(
    String token,
    String apiKey,
    int regionId,
    String language,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': token,
      r'X-API-KEY': apiKey,
      r'setLanguage': language,
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeliveryTownshipResponseObject>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'http://thecreatorcreates.com/api/delivery/townships/${regionId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = DeliveryTownshipResponseObject.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateDeliveryAddressResponseObject> updateAddress(
    String token,
    String apiKey,
    int regionId,
    int townshipId,
    String addressLine,
    String phone,
    String receiverName,
    bool isHome,
    String language,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': token,
      r'X-API-KEY': apiKey,
      r'setLanguage': language,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'region_id': regionId,
      'township_id': townshipId,
      'address_line': addressLine,
      'phone': phone,
      'receiver_name': receiverName,
      'is_home': isHome,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateDeliveryAddressResponseObject>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'http://thecreatorcreates.com/api/delivery_address/update',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = UpdateDeliveryAddressResponseObject.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
