using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerScript : MonoBehaviour
{
	public float playerVelocity;
	public float boundary;
	private Vector3 playerPosition;
	private int playerLives;
	private int playerPoints;
	private AudioSource audioSource;
	public AudioClip pointSound;
	public AudioClip lifeSound;


	// Start is called before the first frame update
	void Start()
    {
		playerPosition = gameObject.transform.position;

		playerLives = 3;
		playerPoints = 0;

		audioSource = GetComponent<AudioSource>();
	}
	void addPoints(int points)
	{
		playerPoints += points;
		audioSource.clip = pointSound;
		audioSource.Play();
	}
	void OnGUI()
	{
		GUI.Label(new Rect(5.0f, 3.0f, 200.0f, 200.0f), "Live's: " + playerLives + "  Score: " + playerPoints);
	}
	void TakeLife()
	{
		playerLives--;
		audioSource.clip = lifeSound;
		audioSource.Play();
	}
	void WinLose()
	{
		// restart the game
		if (playerLives == 0)
		{
			SceneManager.LoadScene("Level1");
		}
		if ((GameObject.FindGameObjectsWithTag("Block")).Length == 0)
		{
			// check the current level
			if (SceneManager.GetActiveScene().name == "Level1")
			{
				SceneManager.LoadScene("Level2");
			}
			else
			{
				Application.Quit();
			}
		}
	}
	// Update is called once per frame
	void Update()
    {
		playerPosition.x += Input.GetAxis("Horizontal") * playerVelocity;

		if (Input.GetKeyDown(KeyCode.Escape))
		{
			Application.Quit();
		}

		transform.position = playerPosition;

		if (playerPosition.x < -boundary)
		{
			playerPosition.x = -boundary;
		}
		if (playerPosition.x > boundary)
		{
			playerPosition.x = boundary;
		}
		transform.position = playerPosition;

		WinLose();

	}
}
