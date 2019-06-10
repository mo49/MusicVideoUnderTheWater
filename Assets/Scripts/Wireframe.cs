using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class Wireframe : MonoBehaviour

{
    private AudioSource audioSource;
    private Material material;

    // Start is called before the first frame update
    void Start()
    {
        audioSource = GameObject.Find("AudioManager").GetComponent<AudioSource>();
        material = GetComponent<Renderer>().material;

        MeshFilter mf = GetComponent<MeshFilter>();
        mf.mesh.SetIndices(mf.mesh.GetIndices(0), MeshTopology.Lines, 0);
        Debug.Log(mf.mesh.GetTopology(0));
    }

    // Update is called once per frame
    void Update()
    {
        float[] spectrum = new float[256];
        audioSource.GetSpectrumData(spectrum, 0, FFTWindow.Rectangular);
        material.SetFloatArray("_SPosAry", spectrum);
    }
}
