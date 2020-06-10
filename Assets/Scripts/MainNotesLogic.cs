using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class MainNotesLogic : MonoBehaviour
{
    [Header("Buttons in Main Menu")]
    public Button clearNotes;
    public Button saveNotes;
    [Header("Text Area for write")]
    public TMP_InputField InputFieldforNotes;

    public TMP_Text infoTitle;

    private int number = 1;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(ViewInfo("Hi bitch"));
  
        clearNotes.onClick.AddListener(KillAmAll);
        saveNotes.onClick.AddListener(GodsSave);
        
        InputFieldforNotes.text = AllSeeing();
    }

    private void KillAmAll()
    {
        PlayerPrefs.DeleteAll();
        InputFieldforNotes.text = AllSeeing();
        StartCoroutine(ViewInfo("I kill all"));
    }

    private void GodsSave()
    {
        PlayerPrefs.SetString("Notes" + number, InputFieldforNotes.text);
        StartCoroutine(ViewInfo("I save all your shit"));
    }

    private string AllSeeing()
    {         
        return PlayerPrefs.GetString("Notes" + number, "_");
    }

    private IEnumerator ViewInfo(string info)
    {
        infoTitle.text = info;
        yield return new WaitForSeconds(2f);
        infoTitle.text = "";
    }

}
