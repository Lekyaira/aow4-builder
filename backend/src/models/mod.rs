pub mod forms;
pub mod empire;

pub use forms::Species_Form;
pub use empire::Empire;

pub mod routes {
    pub use super::forms::species_forms;
    pub use super::forms::okapi_add_operation_for_species_forms_;
}
