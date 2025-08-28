use rocket::http::Method;

// Import the route builder to inspect registered endpoints
use backend::routes::get_routes;

#[test]
fn all_model_endpoints_are_registered() {
    let routes = get_routes();

    // Collect (method, path) pairs for quick lookup
    let actual: std::collections::HashSet<(Method, String)> = routes
        .into_iter()
        .map(|r| (r.method, r.uri.path().to_string()))
        .collect();

    let expected = vec![
        (Method::Get, "/species/forms".to_string()),
        (Method::Get, "/species/traits".to_string()),
        (Method::Get, "/cultures".to_string()),
        (Method::Get, "/cultures/traits".to_string()),
        (Method::Get, "/rulers/types".to_string()),
        (Method::Get, "/tomes".to_string()),
        (Method::Get, "/tomes/by-aspect/<aspect>".to_string()),
        (Method::Get, "/tomes/by-tier/<tier>".to_string()),
    ];

    for pair in expected {
        assert!(
            actual.contains(&pair),
            "Missing endpoint: {:?} {}",
            pair.0,
            pair.1
        );
    }
}

// Basic sanity checks for the path parameter type used by /tomes/by-aspect/<aspect>
#[test]
fn aspect_from_param_parses_valid_values() {
    use backend::models::Aspect;
    use rocket::request::FromParam;

    let ok = |s: &str, a: Aspect| assert_eq!(Aspect::from_param(s).unwrap(), a, "{s}");

    ok("astral", Aspect::Astral);
    ok("shadow", Aspect::Shadow);
    ok("chaos", Aspect::Chaos);
    ok("materium", Aspect::Materium);
    ok("nature", Aspect::Nature);
    ok("order", Aspect::Order);

    // Case-insensitive
    ok("AsTrAl", Aspect::Astral);
}

#[test]
fn aspect_from_param_rejects_invalid_values() {
    use backend::models::Aspect;
    use rocket::request::FromParam;

    assert!(Aspect::from_param("unknown").is_err());
}

