import 'package:dio/dio.dart';

sealed class HttpRequestFailure {
  const HttpRequestFailure();

  factory HttpRequestFailure.network() = NetworkFailure;
  factory HttpRequestFailure.notFound() = NotFoundFailure;
  factory HttpRequestFailure.server() = ServerFailure;
  factory HttpRequestFailure.unauthorized() = UnauthorizedFailure;
  factory HttpRequestFailure.forbidden() = ForbiddenFailure;
  factory HttpRequestFailure.badRequest() = BadRequestFailure;
  factory HttpRequestFailure.local() = LocalFailure;

  static HttpRequestFailure fromCode(int? code) {
    if (code == null) return HttpRequestFailure.badRequest();

    if (code >= 500) return HttpRequestFailure.server();

    if (code == 404) return HttpRequestFailure.notFound();

    if (code == 401) return HttpRequestFailure.unauthorized();

    if (code == 403) return HttpRequestFailure.forbidden();

    return HttpRequestFailure.local();
  }

  static HttpRequestFailure fromException(Object e) {
    if (e is HttpRequestFailure) return e;
    if (e is DioException) {
      if (e.type == DioExceptionType.badResponse) {
        return HttpRequestFailure.fromCode(e.response?.statusCode);
      }
      return HttpRequestFailure.network();
    }
    return HttpRequestFailure.local();
  }

  T when<T>({
    required T Function() network,
    required T Function() notFound,
    required T Function() server,
    required T Function() unauthorized,
    required T Function() forbidden,
    required T Function() badRequest,
    required T Function() local,
  }) {
    if (this is NetworkFailure) return network();
    if (this is NotFoundFailure) return notFound();
    if (this is ServerFailure) return server();
    if (this is UnauthorizedFailure) return unauthorized();
    if (this is ForbiddenFailure) return forbidden();
    if (this is BadRequestFailure) return badRequest();
    return local();
  }

  T map<T>({
    required T Function(NetworkFailure) network,
    required T Function(NotFoundFailure) notFound,
    required T Function(ServerFailure) server,
    required T Function(UnauthorizedFailure) unauthorized,
    required T Function(ForbiddenFailure) forbidden,
    required T Function(BadRequestFailure) badRequest,
    required T Function(LocalFailure) local,
  }) {
    if (this is NetworkFailure) return network(this as NetworkFailure);
    if (this is NotFoundFailure) return notFound(this as NotFoundFailure);
    if (this is ServerFailure) return server(this as ServerFailure);
    if (this is UnauthorizedFailure) {
      return unauthorized(this as UnauthorizedFailure);
    }
    if (this is ForbiddenFailure) return forbidden(this as ForbiddenFailure);
    if (this is BadRequestFailure) return badRequest(this as BadRequestFailure);
    return local(this as LocalFailure);
  }
}

class NetworkFailure extends HttpRequestFailure {
  const NetworkFailure();
}

class NotFoundFailure extends HttpRequestFailure {
  const NotFoundFailure();
}

class ServerFailure extends HttpRequestFailure {
  const ServerFailure();
}

class UnauthorizedFailure extends HttpRequestFailure {
  const UnauthorizedFailure();
}

class ForbiddenFailure extends HttpRequestFailure {
  const ForbiddenFailure();
}

class BadRequestFailure extends HttpRequestFailure {
  const BadRequestFailure();
}

class LocalFailure extends HttpRequestFailure {
  const LocalFailure();
}
