use crate::api_error::{ApiError, ApiResult};
use crate::db::AowDB;
use crate::models::Aspect;
use rocket::serde::json::Json;
use serde::{Deserialize, Serialize};
use rocket_okapi::{openapi, JsonSchema};
use rocket_db_pools::sqlx::{self, FromRow};
use rocket_db_pools::Connection;

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, FromRow)]
pub struct Culture {
    pub id: i32,
    pub name: String,
    pub aspects: Vec<Aspect>,
}

#[openapi]
#[get("/cultures")]
pub async fn cultures(mut db: Connection<AowDB>) -> ApiResult<Vec<Culture>> {
    let cultures = sqlx::query_as::<sqlx::Postgres, Culture>("SELECT * FROM cultures_with_aspects()")
        .fetch_all(&mut **db)
        .await
        .map_err(ApiError::from)?;

    Ok(Json(cultures))
}
