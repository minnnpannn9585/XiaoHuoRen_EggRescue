using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

[RequireComponent(typeof(MeshFilter), typeof(MeshRenderer))]
public class MeshCombiner : MonoBehaviour
{
    [ContextMenu("Combine Child Meshes Permanently")]
    public void CombineChildMeshesPermanently()
    {
        MeshFilter parentMeshFilter = GetComponent<MeshFilter>();
        MeshRenderer parentMeshRenderer = GetComponent<MeshRenderer>();

        MeshFilter[] allMeshFilters = GetComponentsInChildren<MeshFilter>(true);
        List<CombineInstance> combineInstances = new List<CombineInstance>();
        Material firstMaterial = null;

        for (int i = 0; i < allMeshFilters.Length; i++)
        {
            MeshFilter meshFilter = allMeshFilters[i];

            if (meshFilter == parentMeshFilter)
            {
                continue;
            }

            if (meshFilter.sharedMesh == null)
            {
                continue;
            }

            MeshRenderer childRenderer = meshFilter.GetComponent<MeshRenderer>();
            if (childRenderer == null)
            {
                continue;
            }

            if (firstMaterial == null)
            {
                firstMaterial = childRenderer.sharedMaterial;
            }

            CombineInstance combineInstance = new CombineInstance
            {
                mesh = meshFilter.sharedMesh,
                transform = transform.worldToLocalMatrix * meshFilter.transform.localToWorldMatrix
            };

            combineInstances.Add(combineInstance);
        }

        if (combineInstances.Count == 0)
        {
            Debug.LogWarning("No child meshes found to combine.", this);
            return;
        }

        Mesh combinedMesh = new Mesh
        {
            name = gameObject.name + "_CombinedMesh",
            indexFormat = IndexFormat.UInt32
        };

        combinedMesh.CombineMeshes(combineInstances.ToArray(), true, true);

        parentMeshFilter.sharedMesh = combinedMesh;

        if (firstMaterial != null)
        {
            parentMeshRenderer.sharedMaterial = firstMaterial;
        }

        List<GameObject> childrenToDelete = new List<GameObject>();
        for (int i = transform.childCount - 1; i >= 0; i--)
        {
            childrenToDelete.Add(transform.GetChild(i).gameObject);
        }

        for (int i = 0; i < childrenToDelete.Count; i++)
        {
#if UNITY_EDITOR
            if (!Application.isPlaying)
            {
                DestroyImmediate(childrenToDelete[i]);
            }
            else
            {
                Destroy(childrenToDelete[i]);
            }
#else
            Destroy(childrenToDelete[i]);
#endif
        }
    }
}