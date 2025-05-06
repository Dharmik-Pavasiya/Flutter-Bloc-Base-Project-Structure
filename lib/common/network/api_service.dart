import 'package:flutter_bloc_base_structure/common/network/api_base.dart';
import 'package:flutter_bloc_base_structure/core/api_config.dart';

class ApiService extends ApiBaseService {
  ApiService() : super(baseUrl: ApiConfig.baseUrl);
}
