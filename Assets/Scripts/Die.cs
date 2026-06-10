using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Die : MonoBehaviour
{
    public Transform[] _diceSides;
    public float _force = 5f;
    public float _torque = 5f;
    private Rigidbody _rigidbody;
    // Start is called before the first frame update
    void Start()
    {
        _rigidbody =GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        Debug.Log("AAAAA");
        if (Input.GetMouseButtonDown(0))
        {
            RollDice();
        }
       
        GetSideFacingUp();
    }
    
    void RollDice()
    {
        Vector3 force = new Vector3(0f, _force, 0);
        Vector3 torque = new Vector3(Random.Range(-1f,1f), Random.Range(-1f,1f), Random.Range(-1f,1f)) * _torque;
        _rigidbody.AddForce(force,ForceMode.Impulse);
        _rigidbody.AddTorque(torque,ForceMode.Impulse);
    }
    
    /// <summary>
    /// 方向计算
    /// </summary>
    void GetSideFacingUp()
    {
        Transform upSide = null;
        float maxDot = -1;
        foreach (Transform side in _diceSides)
        {
            float dot = Vector3.Dot(side.up, Vector3.up);
            if (! (dot > maxDot)) continue;
            maxDot = dot;
            upSide = side;
        }
        Debug.Log("AAAAA");

        if (upSide == null) return;
        Debug.Log(upSide.name);
    }
}
