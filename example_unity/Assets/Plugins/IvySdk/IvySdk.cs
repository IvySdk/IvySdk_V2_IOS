using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;


namespace com.ivy.sdk
{
    public sealed class IvySdk
    {

        [DllImport("__Internal")]
        private static extern int getScreenWidth();
        [DllImport("__Internal")]
        private static extern int getScreenHeight();
        [DllImport("__Internal")]
        private static extern int getScreenDesignWidth();
        [DllImport("__Internal")]
        private static extern int getScreenDesignHeight();
        [DllImport("__Internal")]
        private static extern void onCreate();
        [DllImport("__Internal")]
        private static extern bool isBannerAvailable();
        [DllImport("__Internal")]
        private static extern bool isBannerAvailableWithTag(string tag);
        [DllImport("__Internal")]
        private static extern void showBanner(int pos);
        [DllImport("__Internal")]
        private static extern void showBannerWithTag(string tag, int pos);
        [DllImport("__Internal")]
        private static extern void closeBanner();
        [DllImport("__Internal")]
        private static extern bool isVideoAvailable();
        [DllImport("__Internal")]
        private static extern bool isVideoAvailableWithTag(string tag);
        [DllImport("__Internal")]
        private static extern void showRewardVideo(int placementId);
        [DllImport("__Internal")]
        private static extern void showRewardVideoWithTag(string tag, int placementId);
        [DllImport("__Internal")]
        private static extern bool isInterstitialAvailable(string tag);
        [DllImport("__Internal")]
        private static extern void showInterstitialAd(string tag);
        [DllImport("__Internal")]
        private static extern void showInterstitialAdWithTag(string tag, int delayShowSeconds);
        [DllImport("__Internal")]
        private static extern void showInterstitialAdWithTag2(string tag, int delayShowSeconds, double delayTimeInterval);
        [DllImport("__Internal")]
        private static extern void showIconAd(float width, float xPercent, float yPercent);
        [DllImport("__Internal")]
        private static extern void showPopupIconAds();
        [DllImport("__Internal")]
        private static extern bool isNativeAvailable(string tag);
        [DllImport("__Internal")]
        private static extern void showNativeAd(string tag, float xPixel, float yPixel, string configJson);
        [DllImport("__Internal")]
        private static extern void showNativeAdWithFrame(string tag, float x, float y, float width, float height, string configJson);
        [DllImport("__Internal")]
        private static extern void closeNativeAd(string tag);
        [DllImport("__Internal")]
        private static extern void loadInterstitialAd(string tag);
        [DllImport("__Internal")]
        private static extern void closeIconAd();

        [DllImport("__Internal")]
        private static extern bool isDeliciousAdAvailable();
        [DllImport("__Internal")]
        private static extern void showDeliciousInterstitialAd(string configJson);
        [DllImport("__Internal")]
        private static extern void showDeliciousBannerAd(float x, float y, float w, float h, string configJson);
        [DllImport("__Internal")]
        private static extern void closeDeliciousBannerAd();
        [DllImport("__Internal")]
        private static extern void showDeliciousIconAd(float x, float y, float w, float h, string configJson);
        [DllImport("__Internal")]
        private static extern void closeDeliciousIconAd();

        [DllImport("__Internal")]
        private static extern void rateUs();
        [DllImport("__Internal")]
        private static extern void rateInApp();
        [DllImport("__Internal")]
        private static extern void rateUsWithStar(float star);
        [DllImport("__Internal")]
        private static extern void rateInAppWithStar(float star);

        [DllImport("__Internal")]
        private static extern bool isNetworkAvailable();
        [DllImport("__Internal")]
        private static extern void pay(int billingId);
        [DllImport("__Internal")]
        private static extern void payWithPayload(int billingId, string payload);
        [DllImport("__Internal")]
        private static extern void shippingGoods(string merchantTransactionId);

        [DllImport("__Internal")]
        private static extern void isSubscriptionActive();
        [DllImport("__Internal")]
        private static extern int[] getPurchasedIds();
        [DllImport("__Internal")]
        private static extern void clearPurchasedIds();
        [DllImport("__Internal")]
        private static extern void clearPurchasedId(int billingId);
        [DllImport("__Internal")]
        private static extern bool isAdsEnabled();
        [DllImport("__Internal")]
        private static extern void setAdsEnable(bool enable);
        [DllImport("__Internal")]
        private static extern bool hasGdpr();
        [DllImport("__Internal")]
        private static extern void resetGdpr();
        [DllImport("__Internal")]
        private static extern void restorePayments();
        [DllImport("__Internal")]
        private static extern string getPaymentDatas();
        [DllImport("__Internal")]
        private static extern string getPaymentData(int billingId);
        [DllImport("__Internal")]
        private static extern string getPopupIconAdsData();
        [DllImport("__Internal")]
        private static extern string getExtraData();
        [DllImport("__Internal")]
        private static extern string getPushData();
        [DllImport("__Internal")]
        private static extern string getConfig(int configId);
        [DllImport("__Internal")]
        private static extern void login();
        [DllImport("__Internal")]
        private static extern void logout();
        [DllImport("__Internal")]
        private static extern bool isLogin();
        [DllImport("__Internal")]
        private static extern string meFirstName();
        [DllImport("__Internal")]
        private static extern string meLastName();
        [DllImport("__Internal")]
        private static extern string meId();
        [DllImport("__Internal")]
        private static extern string meName();
        [DllImport("__Internal")]
        private static extern string me();
        [DllImport("__Internal")]
        private static extern string friends();
        [DllImport("__Internal")]
        private static extern string mePictureURL();
        [DllImport("__Internal")]
        private static extern void fetchFriends(bool invitable);
        [DllImport("__Internal")]
        private static extern void fetchScores();
        [DllImport("__Internal")]
        private static extern void invite();
        [DllImport("__Internal")]
        private static extern void share();
        [DllImport("__Internal")]
        private static extern void shareContent(string contentURL, string tag, string quote);
        [DllImport("__Internal")]
        private static extern bool isIPhoneX();
        [DllImport("__Internal")]
        private static extern void logPlayerLevel(int levelId);
        [DllImport("__Internal")]
        private static extern void logPageStart(string pageName);
        [DllImport("__Internal")]
        private static extern void logPageEnd(string pageName);
        [DllImport("__Internal")]
        private static extern void logEvent(string eventId);
        [DllImport("__Internal")]
        private static extern void logEventWithTag(string eventId, string tag);
        [DllImport("__Internal")]
        private static extern void logEventWithData(string eventId, string data);
        [DllImport("__Internal")]
        private static extern void logIvyEventWithData(string eventId, string data);
        [DllImport("__Internal")]
        private static extern void logAppsflyerEventWithData(string eventId, string data);
        [DllImport("__Internal")]
        private static extern void logFirebaseEventWithData(string eventId, string data);
        [DllImport("__Internal")]
        private static extern void logErrorInFirebase(int errorCode, string domain, string reason, string desc, string suggest);
        [DllImport("__Internal")]
        private static extern void logEventLikeGA(string category, string action, string label, int value);
        [DllImport("__Internal")]
        private static extern void logStartLevel(string level);
        [DllImport("__Internal")]
        private static extern void logFailLevel(string level);
        [DllImport("__Internal")]
        private static extern void logFinishLevel(string level);
        [DllImport("__Internal")]
        private static extern void logBuy(string itemName, int count, double price);
        [DllImport("__Internal")]
        private static extern void logUse(string itemName, int count, double price);
        [DllImport("__Internal")]
        private static extern void logBonus(string itemName, int count, double price, int trigger);
        [DllImport("__Internal")]
        private static extern void sdklog(string info);
        [DllImport("__Internal")]
        private static extern void toast(string info);

        [DllImport("__Internal")]
        private static extern void logFinishAchievement(string achievement);
        [DllImport("__Internal")]
        private static extern void logFinishTutorial(string tutorial);

        [DllImport("__Internal")]
        private static extern bool hasNotch();
        [DllImport("__Internal")]
        private static extern bool justShowFullAd();

        [DllImport("__Internal")]
        private static extern bool isGameCenterAvailable();
        [DllImport("__Internal")]
        private static extern void showLeaderboards();
        [DllImport("__Internal")]
        private static extern void showLeaderboard(int leaderboardId);
        [DllImport("__Internal")]
        private static extern void showAchievements();
        [DllImport("__Internal")]
        private static extern void submitScore(int leaderboardId, long score);
        [DllImport("__Internal")]
        private static extern long myHighScore(int leaderboardId);
        [DllImport("__Internal")]
        private static extern void submitAchievement(int achievementId, double percent);
        [DllImport("__Internal")]
        private static extern double getAchievementProgress(int achievementId);
        [DllImport("__Internal")]
        private static extern void sendMail(string address, string subject, string content, bool isHTML);
        [DllImport("__Internal")]
        private static extern int getRemoteConfigIntValue(string key);
        [DllImport("__Internal")]
        private static extern long getRemoteConfigLongValue(string key);
        [DllImport("__Internal")]
        private static extern double getRemoteConfigDoubleValue(string key);
        [DllImport("__Internal")]
        private static extern bool getRemoteConfigBoolValue(string key);
        [DllImport("__Internal")]
        private static extern string getRemoteConfigStringValue(string key);
        [DllImport("__Internal")]
        private static extern void cancelRemoteNotification(string key);
        [DllImport("__Internal")]
        private static extern void cancelLocalNotification(string key);
        [DllImport("__Internal")]
        private static extern void cancelAllLocalNotifications();
        [DllImport("__Internal")]
        private static extern string getLocalNotificationDataJson();
        [DllImport("__Internal")]
        private static extern void pushLocalNotification(string key, string title, string msg, long pushTime, int interval, bool useSound, string soundName, string userInfo);
        [DllImport("__Internal")]
        private static extern void pushLocalNotificationWithDateStr(string key, string title, string msg, string dateStr, int interval, bool useSound, string soundName, string userInfo);
        [DllImport("__Internal")]
        private static extern void pushRemoteNotification(string key, string title, string content, long pushTime, bool useLocalTimeZone, string facebookIds, string uuids, string topic, int iosBadge, bool useSound, string soundName, string dataJson);
        [DllImport("__Internal")]
        private static extern void saveBase64ImageToCameraRoll(string base64Image);
        [DllImport("__Internal")]
        private static extern void setAdsUnderAgeMode(bool value);
        [DllImport("__Internal")]
        private static extern void setUserPropertyString(string key, string value);
        [DllImport("__Internal")]
        private static extern bool hasNewVersion();
        [DllImport("__Internal")]
        private static extern bool isAIHelpInitialized();
        [DllImport("__Internal")]
        private static extern void showAIHelp(string entranceId, string meta, string tags, string msg);
        [DllImport("__Internal")]
        private static extern void showSingleFAQ(string faqId, int moment);
        [DllImport("__Internal")]
        private static extern void loadAIHelpUnreadMessageCount(bool onlyOnce);
        [DllImport("__Internal")]
        private static extern void stopLoadAIHelpUnreadMessageCount();
        [DllImport("__Internal")]
        private static extern void recheckFailedPayments();
        [DllImport("__Internal")]
        private static extern void loginAppleBeforeFirestore(bool bind);
        [DllImport("__Internal")]
        private static extern string getSignedAppleInfo();
        [DllImport("__Internal")]
        private static extern string getSignedAppleUID();
        [DllImport("__Internal")]
        private static extern void isAppleSigned();

        private static IvySdk _instance = null;
        private static bool hasInitialized = false;

        public enum PaymentResult : int
        {
            Success = 1,
            Failed,
            Cancel,
            PaymentSystemError,
            PaymentSystemValid
        }

        public enum AdEvents : int
        {
            AD_LOADED = 1,
            AD_LOAD_FAILED,
            AD_SHOW_SUCCEED,
            AD_SHOW_FAILED,
            AD_CLICKED,
            AD_CLOSED,
            AD_REWARD_USER,
        }

        public enum ADTypes : int
        {
            AD_TYPE_INTERSTITIAL = 1,
            AD_TYPE_REWARDED = 2,
            AD_TYPE_BANNER = 3,
        }

        public enum BannerAdPosition
        {
            POSITION_LEFT_TOP = 1,
            POSITION_LEFT_BOTTOM = 2,
            POSITION_CENTER_TOP = 3,
            POSITION_CENTER_BOTTOM = 4,
            POSITION_CENTER = 5,
            POSITION_RIGHT_TOP = 6,
            POSITION_RIGHT_BOTTOM = 7,
        }

        public static IvySdk Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new IvySdk();
                }
                return _instance;
            }
        }

        public void Init()
        {
            if (hasInitialized)
            {
                return;
            }
            hasInitialized = true;
            IvySdkListener.Instance.enabled = true;
#if UNITY_EDITOR
#else
                onCreate();
#endif
        }
        public bool HasBannerAd()
        {
#if UNITY_EDITOR
            return false;
#else
            return isBannerAvailable();
#endif

        }

        /**
         *  展示banner 广告
         *  @param tag          广告标签，默认为 default
         *  @param position     广告位置，参考BannerAdPosition
         *  @param placement    广告位，
         */
        public void ShowBannerAd(string tag, BannerAdPosition position, int placement)
        {
            showBanner(((int)position));
        }

        /**
         *  关闭banner 广告
         *  @param placement    广告位
         */
        public void CloseBannerAd(int placement)
        {
#if UNITY_EDITOR
        
#else
             closeBanner();
#endif
        }

        public bool HasInterstitialAd()
        {
            return isInterstitialAvailable("default");
        }

        /**
         *  展示 插屏 广告
         *  @param tag          广告标签，默认为 default
         *  @param placement    广告位，
         *  @param clientInfo   客户端自定义信息，字典结构，注意 bool值会被转换位1/0
         */
        public void ShowInterstitialAd(string tag, int placement = 0, string clientInfo = null)
        {
            showInterstitialAd("default");
        }

        public bool HasRewardedAd()
        {
            return isVideoAvailable();
        }

        /**
         *  展示 激励视频 广告
         *  @param tag          广告标签，默认为 default
         *  @param placement    广告位，可以用于标记奖励点
         *  @param clientInfo   客户端自定义信息，字典结构，注意 bool值会被转换位1/0
         */
        public void ShowRewardedAd(string tag, int placement, string clientInfo = null)
        {
            showRewardVideo(placement);
        }


        public void Pay(int id)
        {
            pay(id);
        }

        /**
         *  支付
         *  @param id           计费点位id
         *  @param payload      
         */
        public void Pay(int id, string payload)
        {
            payWithPayload(id, payload);
        }

        /**
         *  如果在使用在线计费校验时，请在客户端发放奖励时调用此接口通知服务端发货
         *  @param merchantTransactionId    预下单id
         */
        public void ShippingGoods(string merchantTransactionId)
        {
            shippingGoods(merchantTransactionId);
        }

        /**
         * 查询指定计费点位是否存在未处理支付记录
         * @param id    计费点位 id 
         */
        public void QueryPaymentOrder(int id)
        {
         
        }

        /**
         * 查询所有未处理支付记录
         */
        public void QueryPaymentOrders()
        {
            recheckFailedPayments();
        }

        /**
         *  查询指定计费点位详情
         */
        public string GetPaymentData(int id)
        {
            return getPaymentData(id);
        }

        /**
         *  查询所有计费点位详情
         */
        public string GetPaymentDatas()
        {
            return getPaymentDatas();
        }

        /**
         * 计费系统是否可用
         */
        public bool IsPaymentValid()
        {
            return true;
        }

        public void TrackEvent(string eventName, string data)
        {
            logEventWithData(eventName, data);
        }

        /**
         * 统计事件至 所有平台
         */
        public void TrackEventToConversion(string eventName, string data)
        {
            logEventWithData(eventName, data);
        }

        /**
          * 统计事件至 Firebase
          */
        public void TrackEventToFirebase(string eventName, string data)
        {
            logFirebaseEventWithData(eventName, data);
        }

        /**
          * 统计事件至 Facebook
          */
        public void TrackEventToFacebook(string eventName, string data)
        {
           
        }

        /**
          * 统计事件至 Appsflyer
          */
        public void TrackEventToAppsflyer(string eventName, string data)
        {
            logAppsflyerEventWithData(eventName, data);
        }

        /**
          * 统计事件至 自有平台
          */
        public void TrackEventToIvy(string eventName, string data)
        {
            logIvyEventWithData(eventName, data);
        }

        /**
         *  设置用户属性 至 所有平台
         */
        public void SetUserProperty(string key, string value)
        {
            setUserPropertyString(key, value);
        }

        /**
         * 获取 Firebase Remote Config 配置值
         */
        public int GetRemoteConfigInt(string key)
        {
            return getRemoteConfigIntValue(key);
        }

        /**
         * 获取 Firebase Remote Config 配置值
         */
        public long GetRemoteConfigLong(string key)
        {
            return getRemoteConfigLongValue(key);
        }

        /**
         * 获取 Firebase Remote Config 配置值
         */
        public double GetRemoteConfigDouble(string key)
        {
            return getRemoteConfigDoubleValue(key);
        }

        /**
         * 获取 Firebase Remote Config 配置值
         */
        public bool GetRemoteConfigBoolean(string key)
        {
            return getRemoteConfigBoolValue(key);
        }

        /**
         * 获取 Firebase Remote Config 配置值
         */
        public string GetRemoteConfigString(string key)
        {
            return getRemoteConfigStringValue(key);
        }

        /**
         * 登录Facebook
         */
        public void LogInFacebook()
        {
            login();
        }

        /**
         * 登出Facebook
         */
        public void LogoutFacebook()
        {
            logout();
        }

        /**
         * 查询Facebook 登录状态
         */
        public bool IsFacebookLoggedIn()
        {
            return isLogin();
        }

        /**
         * 查询Facebook用户 朋友列表
         */
        public string GetFacebookFriends()
        {
            return friends();
        }

        /**
         * 查询Facebook用户信息
         */
        public string GetFacebookUserInfo()
        {
            return me();
        }



        public void LoginAppleBeforeFirestore()
        {
            loginAppleBeforeFirestore(true);
        }

        public string GetSignedAppleInfo()
        {
            return getSignedAppleInfo();
        }

        public string GetSignedAppleUID()
        {
            return getSignedAppleUID();
        }

        public void IsAppleSigned()
        {
            isAppleSigned();
        }


        /**
         * 客服 准备状态
         */
        public bool IsHelperInitialized()
        {
            return isAIHelpInitialized();
        }

        /**
         * 是否有新的客服消息
         */
        public bool HasNewHelperMessage()
        {
            return false;
        }

        /**
         * 跳转客服页面
         * @param entranceId            自定义入口 ID
         * @param meta                  自定义用户属性，字典格式
         * @param tags                  用户标签，AIHelp需要预先在后台定义用户标签
         * @param welcomeMessage        欢迎语
         */
        public void ShowHelper(string entranceId, string meta, string tags, string welcomeMessage)
        {
            showAIHelp(entranceId, meta, tags, welcomeMessage);
        }

        /**
         * 跳转指定客服页面
         * @param faqId     指定页面id
         * @param monment   
         */
        public void ShowHelperSingleFAQ(string faqId, int moment = 3)
        {
            showSingleFAQ(faqId, moment);
        }

        /**
         * 监听未读消息
         */
        public void ListenHelperUnreadMsgCount(bool onlyOnce)
        {
            loadAIHelpUnreadMessageCount(onlyOnce);
        }

        /**
         * 停止监听未读消息
         */
        public void StopListenHelperUnreadMsgCount()
        {
            stopLoadAIHelpUnreadMessageCount();
        }

        public enum ConfigKeys
        {
            CONFIG_KEY_APP_ID = 1,              // app id
            CONFIG_KEY_LEADER_BOARD_URL = 2,
            CONFIG_KEY_API_VERSION = 3,
            CONFIG_KEY_SCREEN_WIDTH = 4,        // 屏幕宽度
            CONFIG_KEY_SCREEN_HEIGHT = 5,       // 屏幕高度
            CONFIG_KEY_LANGUAGE = 6,            // 设备语言
            CONFIG_KEY_COUNTRY = 7,             // 设备国家
            CONFIG_KEY_VERSION_CODE = 8,        //版本号
            CONFIG_KEY_VERSION_NAME = 9,        //版本名
            CONFIG_KEY_PACKAGE_NAME = 10,       // 包名
            CONFIG_KEY_UUID = 11,               // role id
            SDK_CONFIG_KEY_JSON_VERSION = 21,
        }

        public string GetConfig(ConfigKeys key)
        {
            return getConfig((int)key);
        }

        public bool IsNetworkConnected()
        {
            return isNetworkAvailable();
        }

        public void Rate()
        {
            rateUs();
        }

        //#endif

    }
}
