use crate::api_error::{ApiError, ApiResult};
use crate::db::AowDB;
use crate::models::Aspect;
use rocket::serde::json::Json;
use serde::{Deserialize, Serialize};
use rocket_okapi::{openapi, JsonSchema};
use rocket_db_pools::sqlx::{self, FromRow};
use rocket_db_pools::Connection;

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, FromRow)]
pub struct Tome {
    pub id: i32,
    pub name: String,
    pub tier: i32,
    pub aspects: Vec<Aspect>,
}

#[openapi]
#[get("/tomes")]
pub async fn tomes(mut db: Connection<AowDB>) -> ApiResult<Vec<Tome>> {
    let tomes = sqlx::query_as::<sqlx::Postgres, Tome>("SELECT * FROM tomes()")
        .fetch_all(&mut **db)
        .await
        .map_err(ApiError::from)?;

    Ok(Json(tomes))
}

#[openapi]
#[get("/tomes/by-aspect/<aspect>")]
pub async fn tomes_by_aspect_path(mut db: Connection<AowDB>, aspect: Aspect) -> ApiResult<Vec<Tome>> {
    let tomes = sqlx::query_as::<sqlx::Postgres, Tome>("SELECT * FROM tomes_by_aspect($1)")
        .bind(aspect)
        .fetch_all(&mut **db)
        .await
        .map_err(ApiError::from)?;

    Ok(Json(tomes))
}

#[openapi]
#[get("/tomes/by-tier/<tier>")]
pub async fn tomes_by_tier_path(mut db: Connection<AowDB>, tier: i32) -> ApiResult<Vec<Tome>> {
    let tomes = sqlx::query_as::<sqlx::Postgres, Tome>("SELECT * FROM tomes_by_tier($1)")
        .bind(tier)
        .fetch_all(&mut **db)
        .await
        .map_err(ApiError::from)?;

    Ok(Json(tomes))
}
