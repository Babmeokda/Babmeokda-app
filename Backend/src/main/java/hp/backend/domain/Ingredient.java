package hp.backend.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
public class Ingredient {

	@Id @GeneratedValue
	@Column(name = "ingredient_id")
	private Long ingredientId;

	@Column(nullable = false, name = "ingredient_name", length = 255)
	private String ingredientName;
}
