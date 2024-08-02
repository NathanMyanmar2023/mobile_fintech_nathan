import 'package:dio/dio.dart';
import 'package:flutter_launcher_icons/config/config.dart';
import 'package:fnge/models/response_objects/add_to_cart/add_to_cart_response_object.dart';
import 'package:fnge/models/response_objects/cart/cart_response_object.dart';
import 'package:fnge/models/response_objects/delivery_region/delivery_region_response_object.dart';
import 'package:fnge/models/response_objects/delivery_township/delivery_township_response_object.dart';
import 'package:fnge/models/response_objects/update_delivery_address/update_delivery_address_response_object.dart';
import 'package:fnge/models/utils/app_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: API_URL)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ADD_TO_CART)
  Future<AddToCartResponseObject> addToCart(
    @Header('Authorization') String token,
    @Header('X-API-KEY') String apiKey,
    @Field('quantity') int quantity,
    @Field('product_id') int productId,
    @Header('setLanguage') String language,
  );

  @POST(MAKE_CheckOut)
  Future<AddToCartResponseObject> makeCheckOut(
    @Header('Authorization') String token,
    @Header('X-API-KEY') String apiKey,
    @Field('township_id') int townshipId,
    @Field('address') String address,
    @Header('setLanguage') String language,
  );

  @GET(GET_CART)
  Future<CartResponseObject> getCart(
    @Header('Authorization') String token,
    @Header('X-API-KEY') String apiKey,
    @Header('setLanguage') String language,
  );

  @GET(GET_DELIVERY_REGIONS)
  Future<DeliveryRegionResponseObject> getDeliveryRegions(
    @Header('Authorization') String token,
    @Header('X-API-KEY') String apiKey,
    @Header('setLanguage') String language,
  );

  @GET('$GET_DELIVERY_TOWNSHIPS/{regionId}')
  Future<DeliveryTownshipResponseObject> getDeliveryTownships(
    @Header('Authorization') String token,
    @Header('X-API-KEY') String apiKey,
    @Path('regionId') int regionId,
    @Header('setLanguage') String language,
  );

  @POST(UPDATE_DELIVERY_ADDRESS)
  Future<UpdateDeliveryAddressResponseObject> updateAddress(
    @Header('Authorization') String token,
    @Header('X-API-KEY') String apiKey,
    @Field('region_id') int regionId,
    @Field('township_id') int townshipId,
    @Field('address_line') String addressLine,
    @Field('phone') String phone,
    @Field('receiver_name') String receiverName,
    @Field('is_home') bool isHome,
    @Header('setLanguage') String language,
  );
}
