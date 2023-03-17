enum AuthErrorCode {
  userNotFound("user-not-found"),
  invalidPassword("invalid-password"),
  invalidIdToken("invalid-id-token"),
  idTokenExpired("id-token-expired"),
  emailAlreadyExists("email-already-exists"),
  internalError("internal-error");

  final String errorCode;
  const AuthErrorCode(this.errorCode);
}
