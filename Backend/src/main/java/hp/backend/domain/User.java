package hp.backend.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;

@Entity
public class User {

	@Id
	@GeneratedValue
	@Column(name = "user_id")
	private Long userId;

	@Column(nullable = false)
	private String email;

	@Column(nullable = false)
	private String nickname;
}
