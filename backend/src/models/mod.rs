pub mod species;
pub mod empire;

pub use species::forms::Species_Form;
pub use species::traits::Species_Trait;
pub use empire::Empire;

pub mod routes {
    pub use super::species::forms::species_forms;
    pub use super::species::forms::okapi_add_operation_for_species_forms_;
    pub use super::species::traits::species_traits;
    pub use super::species::traits::okapi_add_operation_for_species_traits_;
}
