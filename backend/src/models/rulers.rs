use crate::api_error::{ApiError, ApiResult};
use crate::db::AowDB;
use crate::models::Aspect;
use rocket::serde::json::Json;
use serde::{Deserialize, Serialize};
use rocket_okapi::{openapi, JsonSchema};
use rocket_db_pools::sqlx::{self, FromRow};
use rocket_db_pools::Connection;

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, FromRow)]
pub struct Ruler {
    pub id: i32,
    pub name: String,
    pub aspects: Vec<Aspect>,
}

#[openapi]
#[get("/ruler_types")]
pub async fn ruler_types(mut db: Connection<AowDB>) -> ApiResult<Vec<Ruler>> {
    let rulers = sqlx::query_as::<sqlx::Postgres, Ruler>("SELECT * FROM lord_types_with_aspects()")
        .fetch_all(&mut **db)
        .await
        .map_err(ApiError::from)?;

    Ok(Json(rulers))
}
