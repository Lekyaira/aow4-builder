use serde::{Deserialize, Serialize};
use rocket_okapi::JsonSchema;
use sqlx::Type;

#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize, JsonSchema, Type)]
#[sqlx(type_name = "aspects", rename_all = "lowercase")]
#[serde(rename_all = "lowercase")]
pub enum Aspect {
    Astral,
    Shadow,
    Chaos,
    Materium,
    Nature,
    Order,
}

// Enable decoding of `aspects[]` -> Vec<Aspect>
impl sqlx::postgres::PgHasArrayType for Aspect {
    fn array_type_info() -> sqlx::postgres::PgTypeInfo {
        sqlx::postgres::PgTypeInfo::with_name("_aspects")
    }
}
