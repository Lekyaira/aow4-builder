use crate::api_error::{ApiError, ApiResult};
use crate::db::AowDB;
use rocket::serde::json::Json;
use serde::{Deserialize, Serialize};
use rocket_okapi::{openapi, JsonSchema};
use rocket_db_pools::sqlx::{self, FromRow};
use rocket_db_pools::Connection;

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, FromRow)]
pub struct Species_Trait {
    pub id: i32,
    pub name: String,
    pub cost: i32,
}

#[openapi]
#[get("/species_traits")]
pub async fn species_traits(mut db: Connection<AowDB>) -> ApiResult<Vec<Species_Trait>> {
    let forms = sqlx::query_as::<sqlx::Postgres, Species_Trait>(
        r#"
        SELECT id, name, cost
        FROM species_traits 
        "#
    )
    .fetch_all(&mut **db)
    .await
    .map_err(ApiError::from)?;

    Ok(Json(forms))
}
