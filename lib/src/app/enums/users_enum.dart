enum AuthMethod { EmailAndPassword, PhoneNumber }

enum AuthError {
  UserNotFound,
  EmailNotValid,
  PasswordNotValid,
  WeakPassword,
  InvalidVerficationCode,
  NotAuthorized,
  NetworkError,
  UnknownError,
}

enum AuthStatus {
  Busy,
  Successful,
  Failed,
}

enum PhoneAuthStatus {
  Started,
  Progressing,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Successful,
  AutoRetrievalTimeOut
}
