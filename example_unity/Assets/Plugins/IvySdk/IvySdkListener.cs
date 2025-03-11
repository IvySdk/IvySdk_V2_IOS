using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace com.ivy.sdk
{
    public class IvySdkListener : MonoBehaviour
    {

        private static IvySdkListener _instance;


        public static event Action<IvySdk.PaymentResult, int, string> OnPaymentEvent;
        public static event Action<IvySdk.PaymentResult, int, string, string> OnPaymentWithPayloadEvent;

        public static event Action<int> HelperUnreadMsgCountEvent;

        public static event Action OnAuthPlatformInitializeEvent; // 三方登录 平台初始化回调
        public static event Action<bool> OnFacebookLoginEvent;

        public static event Action<string> OnSignInAppleSuccess;
        public static event Action<string> OnSignInAppleFailure;

        /**
         * int 为广告位, 其中AD_LOADED、AD_LOAD_FAILED事件中无效
         */
        public static event Action<IvySdk.AdEvents, int> OnInterstitialAdEvent;
        public static event Action<IvySdk.AdEvents, int> OnRewardedAdEvent;
        public static event Action<IvySdk.AdEvents, int> OnBannerAdEvent;


        public static IvySdkListener Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = FindObjectOfType(typeof(IvySdkListener)) as IvySdkListener;
                    if (_instance == null)
                    {
                        var obj = new GameObject("IvySdkListener");
                        _instance = obj.AddComponent<IvySdkListener>();
                        DontDestroyOnLoad(obj);
                    }
                }
                return _instance;
            }
        }

        public void onInitialized(string msg)
        {
            if (OnAuthPlatformInitializeEvent != null && OnAuthPlatformInitializeEvent.GetInvocationList().Length > 0)
            {
                OnAuthPlatformInitializeEvent.Invoke();
            }
        }

        public void adReward(string data)
        {
            if (OnRewardedAdEvent != null && OnRewardedAdEvent.GetInvocationList().Length > 0)
            {
                string tag = "Default";
                int placementId = -1;
                if (!string.IsNullOrEmpty(data))
                {
                    string[] str = data.Split('|');
                    if (str.Length == 1)
                    {
                        tag = str[0];
                    }
                    else if (str.Length >= 2)
                    {
                        tag = str[0];
                        int.TryParse(str[1], out placementId);
                    }
                }
                OnRewardedAdEvent.Invoke(IvySdk.AdEvents.AD_CLOSED, placementId);
                OnRewardedAdEvent.Invoke(IvySdk.AdEvents.AD_REWARD_USER, placementId);
            }
        }

        public void adLoaded(string data)
        {
            string tag = "Default";
            int adType = -1;
            if (!string.IsNullOrEmpty(data))
            {
                string[] str = data.Split('|');
                if (str.Length == 1)
                {
                    tag = str[0];
                }
                else if (str.Length >= 2)
                {
                    tag = str[0];
                    int.TryParse(str[1], out adType);
                }
            }
            if (adType == 1)
            {
                if (OnInterstitialAdEvent != null && OnInterstitialAdEvent.GetInvocationList().Length > 0)
                {
                    OnInterstitialAdEvent.Invoke(IvySdk.AdEvents.AD_LOADED, 0);
                }
            }
            else if (adType == 2)
            {
                if (OnRewardedAdEvent != null && OnRewardedAdEvent.GetInvocationList().Length > 0)
                {
                    OnRewardedAdEvent.Invoke(IvySdk.AdEvents.AD_LOADED, 0);
                }
            }
            else if (adType == 3)
            {
                if (OnBannerAdEvent != null && OnBannerAdEvent.GetInvocationList().Length > 0)
                {
                    OnBannerAdEvent.Invoke(IvySdk.AdEvents.AD_LOADED, 0);
                }
            }
        }

        public void adShowFailed(string data)
        {
            string tag = "Default";
            int adType = -1;
            if (!string.IsNullOrEmpty(data))
            {
                string[] str = data.Split('|');
                if (str.Length == 1)
                {
                    tag = str[0];
                }
                else if (str.Length >= 2)
                {
                    tag = str[0];
                    int.TryParse(str[1], out adType);
                }
            }
            if (adType == 1)
            {
                if (OnInterstitialAdEvent != null && OnInterstitialAdEvent.GetInvocationList().Length > 0)
                {
                    OnInterstitialAdEvent.Invoke(IvySdk.AdEvents.AD_SHOW_FAILED, 0);
                }
            }
            else if (adType == 2)
            {
                if (OnRewardedAdEvent != null && OnRewardedAdEvent.GetInvocationList().Length > 0)
                {
                    OnRewardedAdEvent.Invoke(IvySdk.AdEvents.AD_SHOW_FAILED, 0);
                }
            }
            else if (adType == 3)
            {
                if (OnBannerAdEvent != null && OnBannerAdEvent.GetInvocationList().Length > 0)
                {
                    OnBannerAdEvent.Invoke(IvySdk.AdEvents.AD_SHOW_FAILED, 0);
                }
            }
        }

        public void adDidShown(string data)
        {
            string tag = "Default";
            int adType = -1;
            if (!string.IsNullOrEmpty(data))
            {
                string[] str = data.Split('|');
                if (str.Length == 1)
                {
                    tag = str[0];
                }
                else if (str.Length >= 2)
                {
                    tag = str[0];
                    int.TryParse(str[1], out adType);
                }
            }
            if (adType == 1)
            {
                if (OnInterstitialAdEvent != null && OnInterstitialAdEvent.GetInvocationList().Length > 0)
                {
                    OnInterstitialAdEvent.Invoke(IvySdk.AdEvents.AD_SHOW_SUCCEED, 0);
                }
            }
            else if (adType == 2)
            {
                if (OnRewardedAdEvent != null && OnRewardedAdEvent.GetInvocationList().Length > 0)
                {
                    OnRewardedAdEvent.Invoke(IvySdk.AdEvents.AD_SHOW_SUCCEED, 0);
                }
            }
            else if (adType == 3)
            {
                if (OnBannerAdEvent != null && OnBannerAdEvent.GetInvocationList().Length > 0)
                {
                    OnBannerAdEvent.Invoke(IvySdk.AdEvents.AD_SHOW_FAILED, 0);
                }
            }
        }

        public void adDidClose(string data)
        {
            string tag = "Default";
            int adType = -1;
            if (!string.IsNullOrEmpty(data))
            {
                string[] str = data.Split('|');
                if (str.Length == 1)
                {
                    tag = str[0];
                }
                else if (str.Length >= 2)
                {
                    tag = str[0];
                    int.TryParse(str[1], out adType);
                }
            }
            if (adType == 1)
            {
                if (OnInterstitialAdEvent != null && OnInterstitialAdEvent.GetInvocationList().Length > 0)
                {
                    OnInterstitialAdEvent.Invoke(IvySdk.AdEvents.AD_CLOSED, 0);
                }
            }
            else if (adType == 2)
            {
                if (OnRewardedAdEvent != null && OnRewardedAdEvent.GetInvocationList().Length > 0)
                {
                    OnRewardedAdEvent.Invoke(IvySdk.AdEvents.AD_CLOSED, 0);
                }
            }
            else if (adType == 3)
            {
                if (OnBannerAdEvent != null && OnBannerAdEvent.GetInvocationList().Length > 0)
                {
                    OnBannerAdEvent.Invoke(IvySdk.AdEvents.AD_CLOSED, 0);
                }
            }
        }

        public void adDidClick(string data)
        {
            string tag = "Default";
            int adType = -1;
            if (!string.IsNullOrEmpty(data))
            {
                string[] str = data.Split('|');
                if (str.Length == 1)
                {
                    tag = str[0];
                }
                else if (str.Length >= 2)
                {
                    tag = str[0];
                    int.TryParse(str[1], out adType);
                }
            }
            if (adType == 1)
            {
                if (OnInterstitialAdEvent != null && OnInterstitialAdEvent.GetInvocationList().Length > 0)
                {
                    OnInterstitialAdEvent.Invoke(IvySdk.AdEvents.AD_CLICKED, 0);
                }
            }
            else if (adType == 2)
            {
                if (OnRewardedAdEvent != null && OnRewardedAdEvent.GetInvocationList().Length > 0)
                {
                    OnRewardedAdEvent.Invoke(IvySdk.AdEvents.AD_CLICKED, 0);
                }
            }
            else if (adType == 3)
            {
                if (OnBannerAdEvent != null && OnBannerAdEvent.GetInvocationList().Length > 0)
                {
                    OnBannerAdEvent.Invoke(IvySdk.AdEvents.AD_CLICKED, 0);
                }
            }
        }

        public void onPaymentSuccess(string data)
        {
            if (!string.IsNullOrEmpty(data))
            {
                string[] args = data.Split('|');
                if (args != null && args.Length == 2)
                {
                    int payId = int.Parse(args[0]);
                    string merchantTransactionId = args[1];
                    if (OnPaymentEvent != null && OnPaymentEvent.GetInvocationList().Length > 0)
                    {
                        OnPaymentEvent.Invoke(IvySdk.PaymentResult.Success, payId, merchantTransactionId);
                    }
                }
            }
        }

        public void onPaymentSuccessWithPayload(string data)
        {
            if (!string.IsNullOrEmpty(data))
            {
                string[] args = data.Split('|');
                if (args != null && args.Length == 3)
                {
                    int payId = int.Parse(args[0]);
                    string payload = args[1];
                    string merchantTransactionId = args[2];
                    if (OnPaymentWithPayloadEvent != null && OnPaymentWithPayloadEvent.GetInvocationList().Length > 0)
                    {
                        OnPaymentWithPayloadEvent.Invoke(IvySdk.PaymentResult.Success, payId, payload, merchantTransactionId);
                    }
                }
            }
        }

        public void onPaymentFailure(string data)
        {
            if (!string.IsNullOrEmpty(data))
            {
                string[] args = data.Split('|');
                if (args != null && args.Length == 2)
                {
                    int payId = int.Parse(args[0]);
                    string merchantTransactionId = args[1];
                    if (OnPaymentEvent != null && OnPaymentEvent.GetInvocationList().Length > 0)
                    {
                        OnPaymentEvent.Invoke(IvySdk.PaymentResult.Failed, payId, merchantTransactionId);
                    }
                }
            }
        }

        public void onShippingResult(string data)
        {
            if (!string.IsNullOrEmpty(data))
            {
                string[] args = data.Split('|');
                if (args != null && args.Length == 2)
                {
                    int status = int.Parse(args[1]);
                    string merchantTransactionId = args[0];
                    //TODO: 
                }
            }
        }

        public void onPaymentReady(string data)
        {
            if (OnPaymentEvent != null && OnPaymentEvent.GetInvocationList().Length > 0)
            {
                OnPaymentEvent.Invoke(IvySdk.PaymentResult.PaymentSystemValid, 0, "");
            }
        }

        public void signInAppleSuccess(string data)
        {
            string appleUID = data;
            if (OnSignInAppleSuccess != null && OnSignInAppleSuccess.GetInvocationList().Length > 0)
            {
                OnSignInAppleSuccess(appleUID);
            }
        }

        public void signInAppleFailure(string data)
        {
            string error = data;
            if (OnSignInAppleFailure != null && OnSignInAppleFailure.GetInvocationList().Length > 0)
            {
                OnSignInAppleFailure(error);
            }
        }

        public void snsLoginSuccess(string data)
        {
            if (OnFacebookLoginEvent != null && OnFacebookLoginEvent.GetInvocationList().Length > 0)
            {
                OnFacebookLoginEvent.Invoke(true);
            }
        }

        public void snsLoginFailure(string data)
        {
            if (OnFacebookLoginEvent != null && OnFacebookLoginEvent.GetInvocationList().Length > 0)
            {
                OnFacebookLoginEvent.Invoke(false);
            }
        }

        public void snsLoginCancel(string data)
        {
            if (OnFacebookLoginEvent != null && OnFacebookLoginEvent.GetInvocationList().Length > 0)
            {
                OnFacebookLoginEvent.Invoke(false);
            }
        }


    }
}