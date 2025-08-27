use rocket::{get, serde::json::Json};
use rocket_okapi::{
    okapi::{schemars, schemars::JsonSchema},
    openapi, openapi_get_routes,
    swagger_ui::{SwaggerUIConfig, make_swagger_ui},
};
use crate::models::routes::*;

pub fn get_routes() -> Vec<rocket::Route> {
    openapi_get_routes![
        species_forms,
        species_traits,
        cultures,
        culture_traits,
    ]
}
