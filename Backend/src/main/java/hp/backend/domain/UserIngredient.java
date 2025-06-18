package hp.backend.domain;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class UserIngredient {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long userIngredientId;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;

	@ManyToOne
	@JoinColumn(name = "ingredient_id")
	private Ingredient ingredient;

	@Column(name = "expiration_date")
	private LocalDate expirationDate;

	@Column(nullable = true)
	private Float amount;

	@Column(nullable = true, length = 20)
	private String unit;

}
