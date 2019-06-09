﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class Wireframe : MonoBehaviour

{
    [SerializeField] AudioSource audioSource;

    private Material material;
    private AudioListener audioListener;

    // Start is called before the first frame update
    void Start()
    {
        MeshFilter mf = GetComponent<MeshFilter>();
        mf.mesh.SetIndices(mf.mesh.GetIndices(0), MeshTopology.Lines, 0);

        material = GetComponent<Renderer>().material;
    }

    // Update is called once per frame
    void Update()
    {
        float[] spectrum = new float[256];
        audioSource.GetSpectrumData(spectrum, 0, FFTWindow.Rectangular);
        material.SetFloatArray("_SPosAry", spectrum);
    }
}
