package hp.backend.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class RecipeProgress {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long recipeProgressId;

	@ManyToOne
	@JoinColumn(name = "recipe_id")
	private Recipe recipe;

	@Column(name = "step_no",nullable = false)
	private int stepNumber;

	@Column(name = "recipe_progress_description",columnDefinition = "TEXT" ,nullable = false)
	private String description;
}
