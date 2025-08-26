use rocket::{response::status::Custom, http::Status};
use rocket::serde::{Deserialize, Serialize, json::Json};
use rocket_okapi::{
    okapi::{schemars, schemars::JsonSchema},
};

#[derive(Debug, Serialize, Deserialize, JsonSchema)]
pub struct ApiErrorBody {
    /// HTTP status code (e.g., 400, 404, 500)
    pub code: u16,
    /// Short machine-readable error kind (e.g., "bad_request")
    pub error: &'static str,
    /// Human-readable message for the UI
    pub message: String,
    /// Optional extra details (validation errors, etc.)
    pub details: Option<serde_json::Value>,
}

#[derive(Debug)]
pub enum ApiError {
    BadRequest(String),
    NotFound(String),
    Conflict(String),
    Unauthorized(String),
    Forbidden(String),
    Internal(String),
}

impl ApiError {
    pub fn bad_request<M: Into<String>>(m: M) -> Self { Self::BadRequest(m.into()) }
    pub fn not_found<M: Into<String>>(m: M) -> Self { Self::NotFound(m.into()) }
    pub fn conflict<M: Into<String>>(m: M) -> Self { Self::Conflict(m.into()) }
    pub fn unauthorized<M: Into<String>>(m: M) -> Self { Self::Unauthorized(m.into()) }
    pub fn forbidden<M: Into<String>>(m: M) -> Self { Self::Forbidden(m.into()) }
    pub fn internal<M: Into<String>>(m: M) -> Self { Self::Internal(m.into()) }

    fn status_and_kind(&self) -> (Status, &'static str) {
        match self {
            ApiError::BadRequest(_)   => (Status::BadRequest, "bad_request"),
            ApiError::NotFound(_)     => (Status::NotFound, "not_found"),
            ApiError::Conflict(_)     => (Status::Conflict, "conflict"),
            ApiError::Unauthorized(_) => (Status::Unauthorized, "unauthorized"),
            ApiError::Forbidden(_)    => (Status::Forbidden, "forbidden"),
            ApiError::Internal(_)     => (Status::InternalServerError, "internal"),
        }
    }

    fn message(&self) -> &str {
        match self {
            ApiError::BadRequest(m)
            | ApiError::NotFound(m)
            | ApiError::Conflict(m)
            | ApiError::Unauthorized(m)
            | ApiError::Forbidden(m)
            | ApiError::Internal(m) => m.as_str(),
        }
    }
}

// Convert to an okapi-aware responder: (Status + JSON) with schema.
impl From<ApiError> for Custom<Json<ApiErrorBody>> {
    fn from(err: ApiError) -> Self {
        let (status, kind) = err.status_and_kind();
        let body = ApiErrorBody {
            code: status.code,
            error: kind,
            message: err.message().to_string(),
            details: None,
        };
        Custom(status, Json(body))
    }
}

impl From<sqlx::Error> for ApiError {
    fn from(e: sqlx::Error) -> Self {
        // Tune these cases as you like:
        match e {
            sqlx::Error::RowNotFound => ApiError::not_found("Resource not found."),
            _ => ApiError::internal("Database error."),
        }
    }
}

pub type ApiResult<T> = Result<Json<T>, Custom<Json<ApiErrorBody>>>;
