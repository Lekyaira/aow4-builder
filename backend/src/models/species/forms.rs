use crate::api_error::{ApiError, ApiResult};
use crate::db::AowDB;
use rocket::serde::json::Json;
use serde::{Deserialize, Serialize};
use rocket_okapi::{openapi, JsonSchema};
use rocket_db_pools::sqlx::{self, FromRow};
use rocket_db_pools::Connection;

#[derive(Debug, Clone, Serialize, Deserialize, JsonSchema, FromRow)]
pub struct Species_Form {
    pub id: i32,
    pub name: String,
}

#[openapi]
#[get("/species/forms")]
pub async fn species_forms(mut db: Connection<AowDB>) -> ApiResult<Vec<Species_Form>> {
    let forms = sqlx::query_as::<sqlx::Postgres, Species_Form>(
        r#"
        SELECT id, name
        FROM species_forms 
        "#
    )
    .fetch_all(&mut **db)
    .await
    .map_err(ApiError::from)?;

    Ok(Json(forms))
}
