use crate::api_error::{ApiError, ApiResult};
use crate::db::AowDB;
use crate::models::Aspect;
use rocket::serde::json::Json;
use serde::{Deserialize, Serialize};
use rocket_okapi::{openapi, JsonSchema};
use rocket_db_pools::sqlx::{self, FromRow};
use rocket_db_pools::Connection;

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, FromRow)]
pub struct Culture_Trait {
    pub id: i32,
    pub name: String,
    pub aspect: Option<Aspect>,
    pub traits_excluded: Vec<i32>,
}

#[openapi]
#[get("/cultures/traits")]
pub async fn culture_traits(mut db: Connection<AowDB>) -> ApiResult<Vec<Culture_Trait>> {
    let traits = sqlx::query_as::<sqlx::Postgres, Culture_Trait>("SELECT * FROM culture_traits()")
        .fetch_all(&mut **db)
        .await
        .map_err(ApiError::from)?;

    Ok(Json(traits))
}
