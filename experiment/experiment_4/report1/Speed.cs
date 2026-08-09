using UnityEngine;

public class Speed : MonoBehaviour
{

    private Rigidbody rb;
    public float forceMagnitude;
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    public void Force(Vector3 direction)
    {
        rb.AddForce(new Vector3(0f, 0f, 1f) * forceMagnitude);
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
