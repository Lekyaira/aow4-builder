pub mod aspects;
pub mod species;
pub mod cultures;
pub mod rulers;
pub mod tomes;
pub mod empire;

pub use aspects::Aspect;
pub use species::forms::Species_Form;
pub use species::traits::Species_Trait;
pub use cultures::cultures::Culture;
pub use cultures::culture_traits::Culture_Trait;
pub use rulers::Ruler;
pub use tomes::Tome;
pub use empire::Empire;

pub mod routes {
    pub use super::species::forms::species_forms;
    pub use super::species::forms::okapi_add_operation_for_species_forms_;
    pub use super::species::traits::species_traits;
    pub use super::species::traits::okapi_add_operation_for_species_traits_;
    pub use super::cultures::cultures::cultures;
    pub use super::cultures::cultures::okapi_add_operation_for_cultures_;
    pub use super::cultures::culture_traits::culture_traits;
    pub use super::cultures::culture_traits::okapi_add_operation_for_culture_traits_;
    pub use super::rulers::ruler_types;
    pub use super::rulers::okapi_add_operation_for_ruler_types_;
    pub use super::tomes::tomes;
    pub use super::tomes::okapi_add_operation_for_tomes_;
    pub use super::tomes::tomes_by_aspect_path;
    pub use super::tomes::okapi_add_operation_for_tomes_by_aspect_path_;
    pub use super::tomes::tomes_by_tier_path;
    pub use super::tomes::okapi_add_operation_for_tomes_by_tier_path_;
}
