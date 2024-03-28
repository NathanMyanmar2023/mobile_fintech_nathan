// ignore_for_file: constant_identifier_names

import 'package:nathan_app/config/config.dart';

const API_URL = "${Config.productionUrl}api/";
const App_Version = "1.0.1";
const PRESIGN = "${API_URL}presign";
const GET_COUNTRIES = "${API_URL}countries";
const CHECK_REFER = "${API_URL}check/refer_code";
const CHECK_PHONE = "${API_URL}check/phone";
const CHECK_EMAIL = "${API_URL}check/email";
const VERIFY_EMAIL = "${API_URL}verify";
const CHECK_USERNAME = "${API_URL}check/username";
const REGISTER_URL = "${API_URL}register";
const LOGIN_URL = "${API_URL}login";
const FORGOT_PASS_URL = "${API_URL}forgot/password";
const PHONE_BILL_URL = "${API_URL}phone/billing";

const LUCKY_DRAW = "${API_URL}lucky/draws";
const CHECK_TICKET = "${API_URL}check/lucky/tickets";
const GET_TICKET = "${API_URL}get/lucky/tickets";
const BUY_TICKET = "${API_URL}buy/lucky/tickets";
const WINNER = "${API_URL}lucky/draws/winners";
const SHOPPING = "${API_URL}products";
const SHOPPING_BRAND = "${API_URL}products/brand-lists/";
const Product_detail = "${API_URL}products/";
const Category_url = "${API_URL}shopping/categories";
const Brands_url = "${API_URL}shopping/category";

const CART = "${API_URL}cart";
const ADD_TO_SHOPPING_CART = "${API_URL}add_to_cart";
const UPDATE_SHOPPING_CART = "${API_URL}cart/update";

const CHECKOUT = "${API_URL}checkout";
const ORDER = "${API_URL}orders";
const ORDER_detail = "${API_URL}voucher/";
const REGIONS = "${API_URL}delivery/regions";

const REQUEST_OTP = "${API_URL}resend/code";
const VERIFY_OTP = "${API_URL}verify";

const UPLOAD_KYC = "${API_URL}kyc/store";

const WALLETS = "${API_URL}user/wallets";
const USER_INFO = "${API_URL}user/infos";
const RANK = "${API_URL}rank";

const UPDATE_PROFILE = "${API_URL}user/profile/update";
const CHANGE_PASSWORD = "${API_URL}user/change/password";
const CHANGE_WALLET_TYPE = "${API_URL}change/main_wallet/currency/type";

const GET_CURRENCIES = "${API_URL}currencies";
const GET_CURRENT_CURRENCIES = "${API_URL}current/currency";
const DEPOSIT = "${API_URL}deposit";
const GET_APPLICATION_FEES = "${API_URL}history/application/fees";

const EXCHANGE = "${API_URL}exchange";
const INVESTMENT_PLANS = "${API_URL}plans";
const INVEST = "${API_URL}invest";
const WITHDRAW = "${API_URL}withdraw";

const CHECK_USER = "${API_URL}check_user";
const TRANSFER = "${API_URL}transfer/money";

const GET_LEVELS = "${API_URL}all/user/level";

const GET_LEVEL_ONE_USERS = "${API_URL}level/one/users";

//Ecommerce
const GET_PRODUCTS = "${API_URL}products";
const GET_PHOTOS = "${API_URL}product";
const ADD_TO_CART = "${API_URL}add_to_cart";
const GET_CART = "${API_URL}cart";
const MAKE_CheckOut = "${API_URL}checkout";
const GET_DELIVERY_REGIONS = "${API_URL}delivery/regions";
const GET_DELIVERY_TOWNSHIPS = "${API_URL}delivery/townships";
const UPDATE_DELIVERY_ADDRESS = "${API_URL}delivery_address/update";

// const GET_PAYMENT_METHOD = "${API_URL}currency/{id}/payment";
