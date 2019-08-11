using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BallScript : MonoBehaviour
{
	private bool ballIsActive;
	private Vector3 ballPosition;
	private Vector2 ballInitialForce;
	private AudioSource audioSource;
	public GameObject playerObject;
	public AudioClip hitSound;

	// Start is called before the first frame update
	void Start()
	{
		// create the force
		ballInitialForce = new Vector2(100.0f, 300.0f);

		// set to inactive
		ballIsActive = false;

		// ball position
		ballPosition = transform.position;

		audioSource = GetComponent<AudioSource>();

	}
	void OnCollisionEnter2D(Collision2D collision)
	{
		if (ballIsActive)
		{
			audioSource.clip = hitSound;
			audioSource.Play();
		}
	}
	// Update is called once per frame
	void Update()
	{
		// check for user input
		if (Input.GetButtonDown("Jump") == true)
		{
			// check if is the first play
			if (!ballIsActive)
			{
				// add a force
				GetComponent<Rigidbody2D>().AddForce(ballInitialForce);

				// set ball active
				ballIsActive = !ballIsActive;
			}
		}

		if (!ballIsActive && playerObject != null)
		{
			// get and use the player position
			ballPosition.x = playerObject.transform.position.x;

			// apply player X position to the ball
			transform.position = ballPosition;
		}
		if (ballIsActive && transform.position.y < -6)
		{
			ballIsActive = !ballIsActive;
			ballPosition.x = playerObject.transform.position.x;
			ballPosition.y = -4.0f;
			transform.position = ballPosition;

			ballInitialForce = new Vector2(0.00f, 0.00f);

			playerObject.SendMessage("TakeLife");
		}
	}
}