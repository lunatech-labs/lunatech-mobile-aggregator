class ExternalToolInfo {
  ExternalToolInfo(
      {required this.name,
      required this.androidUrl,
      required this.iosUrl,
      required this.image});

  String name;
  String androidUrl;
  String iosUrl;
  String image;
}

final List<ExternalToolInfo> externalTools = [
  _toggle,
  _expensify,
  _slack,
  _confluence,
  _gmail
];

//TODO Improve logos
final ExternalToolInfo _toggle = ExternalToolInfo(
    name: "Toggl Track",
    androidUrl:
        "https://play.google.com/store/apps/details?id=com.toggl.giskard",
    iosUrl:
        "https://apps.apple.com/us/app/expensify-receipts-expenses/id471713959",
    image:
        "https://play-lh.googleusercontent.com/PeblLXajnpQMBdnzHCQ9yRh6IZ1iOM7qqJkp306uOYlYq8djKFs2vTLO5YO265MPmcM=w240-h480-rw");

final ExternalToolInfo _expensify = ExternalToolInfo(
    name: "Expensify",
    androidUrl:
        "https://play.google.com/store/apps/details?id=com.expensify.chat",
    iosUrl:
        "https://apps.apple.com/us/app/toggl-track-hours-time-log/id1291898086?platform=iphone",
    image:
        "https://play-lh.googleusercontent.com/s-RdhKt0Puppli-DZgjT0dLsxwYr3AqFc6VWmgXM5641mkFyohapOkExeVJXxh_vIA=w480-h960-rw");

final ExternalToolInfo _slack = ExternalToolInfo(
    name: "Slack",
    androidUrl: "https://play.google.com/store/apps/details?id=com.Slack",
    iosUrl: "https://apps.apple.com/us/app/slack/id618783545",
    image:
        "https://downloadr2.apkmirror.com/wp-content/uploads/2021/05/65/609315d878257.png");

final ExternalToolInfo _confluence = ExternalToolInfo(
    name: "Confluence",
    androidUrl:
        "https://play.google.com/store/apps/details?id=com.atlassian.android.confluence.core",
    iosUrl: "https://apps.apple.com/us/app/confluence-cloud/id1006971684",
    image:
        "https://is2-ssl.mzstatic.com/image/thumb/Purple112/v4/1c/db/ee/1cdbeee7-07b7-4740-21d5-a1a2d628d8d0/AppIcon-1x_U007emarketing-0-10-0-85-220.png/246x0w.webp");

final ExternalToolInfo _gmail = ExternalToolInfo(
    name: "Gmail",
    androidUrl:
        "https://play.google.com/store/apps/details?id=com.google.android.gm",
    iosUrl: "https://apps.apple.com/us/app/gmail-email-by-google/id422689480",
    image:
        "https://play-lh.googleusercontent.com/KSuaRLiI_FlDP8cM4MzJ23ml3og5Hxb9AapaGTMZ2GgR103mvJ3AAnoOFz1yheeQBBI=w240-h480-rw");
