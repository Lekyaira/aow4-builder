use serde::{Deserialize, Serialize};
use rocket_okapi::JsonSchema;
use sqlx::Type;
use std::str::FromStr;
use rocket::request::FromParam;

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

impl FromStr for Aspect {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s.to_ascii_lowercase().as_str() {
            "astral"   => Ok(Aspect::Astral),
            "shadow"   => Ok(Aspect::Shadow),
            "chaos"    => Ok(Aspect::Chaos),
            "materium" => Ok(Aspect::Materium),
            "nature"   => Ok(Aspect::Nature),
            "order"    => Ok(Aspect::Order),
            other => Err(format!("invalid aspect: {other}")),
        }
    }
}

impl<'r> FromParam<'r> for Aspect {
    type Error = String;

    fn from_param(param: &'r str) -> Result<Self, Self::Error> {
        Aspect::from_str(param)
    }
}
