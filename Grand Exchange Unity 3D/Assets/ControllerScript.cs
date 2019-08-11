using UnityEngine;
using System.Collections;
public class ControllerScript : MonoBehaviour
{
	private Animator myAnimator;

	void Start() {
		myAnimator = GetComponent<Animator>();
	}
	void Update() {
		myAnimator.SetFloat("VSpeed", Input.GetAxis("Vertical"));
		if (Input.GetKey("left")) {
			transform.Rotate(Vector3.down * Time.deltaTime * 100.0f);
			if ((Input.GetAxis("Vertical") == 0f) && (Input.GetAxis("Horizontal") == 0)) {
				myAnimator.SetBool("TurningLeft", true);
			}
		} else {
			myAnimator.SetBool("TurningLeft", false);
		}

		if(Input.GetKey("right")){
			transform.Rotate(Vector3.up * Time.deltaTime * 100.0f);
			if ((Input.GetAxis ("Vertical") == 0f) && (Input.GetAxis ("Horizontal") == 0)) {
				myAnimator.SetBool("TurningRight", true);
			}
		} else {
			myAnimator.SetBool("TurningRight", false);
		}
		if (Input.GetKey("r"))
		{
			myAnimator.SetBool("Running", true);
		}
		else {
			myAnimator.SetBool("Running", false);
		}

	}
}