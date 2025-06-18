package hp.backend.domain;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Recipe {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "recipe_id")
	private Long recipeId;

	@Column(nullable = false, length = 255, name = "recipe_title")
	private String title;

	@Column(nullable = false, columnDefinition = "TEXT", name = "recipe_description")
	private String description;

}
