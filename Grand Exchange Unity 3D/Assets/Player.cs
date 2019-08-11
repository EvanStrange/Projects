using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour
{
	CharacterController cc;
	public float speed = 10f;

	float ySpeed = 0;
	float gravity = -15f;
	public Transform fpsCamera;
	float pitch = 0f;

    // Start is called before the first frame update
    void Start()
    {
		cc = GetComponent<CharacterController>();
    }

    // Update is called once per frame
    void Update()
    {
		float xInput = Input.GetAxis("Horizontal") * speed / 3;
		float zInput = Input.GetAxis("Vertical") * speed / 3;

		Vector3 move = new Vector3(xInput, 0, zInput);
		move = Vector3.ClampMagnitude(move, speed);
		move = transform.TransformVector(move);

		if (cc.isGrounded) {
			if (Input.GetButtonDown("Jump")) {
				ySpeed = 5f;
			} else {
				ySpeed = gravity * Time.deltaTime;
			}
		}
		else {
			ySpeed += gravity * Time.deltaTime;
		}

		cc.Move((move + new Vector3(0, ySpeed, 0)) * Time.deltaTime);


		float xMouse = Input.GetAxis("Mouse X") * 10f;
		transform.Rotate(0, xMouse, 0);

		pitch -= Input.GetAxis("Mouse Y") * 10f;
		pitch = Mathf.Clamp(pitch, -45f, 45f);
		Quaternion camRotation = Quaternion.Euler(pitch, 0 , 0);
		fpsCamera.localRotation = camRotation;
    }
}
