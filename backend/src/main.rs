use rocket_db_pools::{sqlx::{self, Row}, Connection, Database};
use rocket_okapi::{okapi::schemars, swagger_ui::{SwaggerUIConfig, make_swagger_ui}};

#[macro_use]
extern crate rocket;
extern crate rocket_db_pools;

mod config;
mod db;
mod routes;
mod models;
mod api_error;

fn ui() -> SwaggerUIConfig {
    SwaggerUIConfig {
        url: "/openapi.json".into(),
        ..Default::default()
    }
}

#[launch]
fn rocket() -> _ {
    use config::config;
    // Insert database url into Rocket
    let rocket_config = rocket::Config::figment()
        .merge((
            "databases.aow",
            rocket_db_pools::Config {
                url: config().aow.host.into(),
                min_connections: config().aow.connections.min,
                max_connections: config().aow.connections.max,
                connect_timeout: config().aow.timeout.connect,
                idle_timeout: config().aow.timeout.idle,
                extensions: config().aow.extensions,
            },
        ));

    // Built server routes
    rocket::custom(rocket_config)
        .attach(db::AowDB::init())
        .mount(
            "/", // openapi_get_routes![list_test_entries, auth::login, auth::signup],
            routes::get_routes(),
        )
        .mount("/docs", make_swagger_ui(&ui()))
}
