using com.ivy.sdk;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OnButtonClickEvent : MonoBehaviour
{
   public void OnClicked(GameObject game)
    {
        string name = game.name;
        if (name.Equals("Button0")) {
            bool state = IvySdk.Instance.HasRewardedAd();
            Debug.Log($"video state:{state}");
        }

        if (name.Equals("Button1"))
        {
            IvySdk.Instance.ShowRewardedAd("default", 1);
        }

        if (name.Equals("Button2"))
        {
            IvySdk.Instance.LogInFacebook();
        }

        if (name.Equals("Button3"))
        {
            string info = IvySdk.Instance.GetFacebookUserInfo();
            Debug.Log($"facebook user:{info}");
        }

        if (name.Equals("Button4"))
        {
            IvySdk.Instance.LoginAppleBeforeFirestore();
        }

        if (name.Equals("Button5"))
        {
            string info = IvySdk.Instance.GetSignedAppleInfo();
            Debug.Log($"apple user:{info}");
        }
    }
}
