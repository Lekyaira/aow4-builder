use rocket_db_pools::Database;

#[derive(Database)]
#[database("aow")]
pub struct AowDB(rocket_db_pools::sqlx::PgPool);
