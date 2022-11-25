class CredentialsMismatchError implements Exception {
  const CredentialsMismatchError(this.msg);
  final String msg;

  @override
  String toString() => 'CredentialsMismatchError: $msg';
}

class AuthTokenMissingError implements Exception {
  const AuthTokenMissingError();

  @override
  String toString() => 'AuthTokenMissingError: No auth token was found.';
}

class NotLoggedInUserError implements Exception {
  const NotLoggedInUserError();

  @override
  String toString() => 'NotLoggedInUserError: No user is logged in.';
}
