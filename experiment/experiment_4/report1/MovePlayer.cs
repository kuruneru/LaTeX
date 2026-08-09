using UnityEngine;
using TMPro;
using UnityEngine.SceneManagement;

public class MovePlayer : MonoBehaviour
{
    private Rigidbody rb;
    public float forceMagnitude;

    public TextMeshProUGUI pointsText;
    public TextMeshProUGUI timerText;

    public static int points;
    private int totalCoins;
    private float timer;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        points = 0;
        totalCoins = GameObject.FindGameObjectsWithTag("Coin").Length;
    }

    // Update is called once per frame
    void Update()
    {
        if (points >= totalCoins)
        {
            pointsText.text = "Score: " + points.ToString() + "\nLevel Completed!";
            if (Input.GetKeyDown(KeyCode.Space))
            {
                LoadNextScene();
            }
        }
        else
        {
            pointsText.text = "Score: " + points.ToString();
            timer += Time.deltaTime;
            timerText.text = "Timer: " + timer.ToString("F2") + " s";
        }
    }

    private void FixedUpdate()
    {
        if (Input.GetKey(KeyCode.W))
        {
            rb.AddForce(new Vector3(0f, 0f, 1f) * forceMagnitude); // W: forward
        }
        if (Input.GetKey(KeyCode.S))
        {
            rb.AddForce(new Vector3(0f, 0f, -1f) * forceMagnitude); // S: backward
        }
        if (Input.GetKey(KeyCode.A))
        {
            rb.AddForce(new Vector3(-1f, 0f, 0f) * forceMagnitude); // A: left
        }
        if (Input.GetKey(KeyCode.D))
        {
            rb.AddForce(new Vector3(1f, 0f, 0f) * forceMagnitude); // D: right
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Coin"))
        {
            other.gameObject.SetActive(false);
            points += 1;
        }
    }

    public void LoadNextScene()
    {
        int currenSceneIndex = SceneManager.GetActiveScene().buildIndex;
        int totalScenes = SceneManager.sceneCountInBuildSettings;

        if (currenSceneIndex + 1 < totalScenes)
        {
            SceneManager.LoadScene(currenSceneIndex + 1);
        }
        else
        {
            Debug.Log("No more stages!");
        }
    }
}
