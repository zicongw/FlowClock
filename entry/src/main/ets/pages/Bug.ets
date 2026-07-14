//Bug.ets
import router from '@ohos.router';
import type { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct Bug {
    private uiContext: common.UIAbilityContext | null = null;

    aboutToAppear() {
        this.uiContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
    }

    onBackPress(): boolean {
        router.back();
        return true;
    }

    jumpToGithub() {
        if (!this.uiContext) return;
        const githubUrl = "https://github.com/zicongw/FlowClock.git";
        this.uiContext.openLink(githubUrl, { appLinkingOnly: false })
            .catch((err: BusinessError) => {
                promptAction.showToast({ message: "无法打开网页，请检查网络" });
            })
    }

    jumpToNotion() {
        if (!this.uiContext) return;
        const notionUrl = "https://mixed-tibia-a61.notion.site/FlowClock-3981928f6f018042b579edb16475505e?source=copy_link";
        this.uiContext.openLink(notionUrl, { appLinkingOnly: false })
            .catch((err: BusinessError) => {
                promptAction.showToast({ message: "无法打开网页，请检查网络" });
            })
    }

    jumpToStoreReview() {
        if (!this.uiContext) return;
        const pkg = this.uiContext.abilityInfo.bundleName;
        const want: Want = {
            action: "ohos.want.action.appdetail",
            uri: `store://appgallery.huawei.com/app/detail?id=${pkg}&action=write-review`
        };
        this.uiContext.startAbility(want).catch((err: BusinessError) => {
            this.uiContext?.openLink(`https://appgallery.huawei.com/app/detail?id=${pkg}&action=write-review`, { appLinkingOnly: false })
        })
    }

    build() {
        //【改动1：外层用固定全屏Column，不再让Scroll占满屏幕】
        Column() {
            // 1. 固定顶部导航栏：脱离Scroll，永远贴页面最上方，不会产生空白
            Row() {
                Image($r('sys.media.ohos_ic_public_arrow_left'))
                    .width(28)
                    .height(28)
                    .onClick(() => {
                        router.back()
                    })
                Text("Bug反馈")
                    .fontSize(22)
                    .fontWeight(FontWeight.Medium)
                    .layoutWeight(1)
                    .textAlign(TextAlign.Center)
                    .fontColor('#ff000000')
                Blank().width(28)
            }
            .width('100%')
            .padding({
                left: 16,
                right: 16,
                top: 16,
                bottom: 12
            })

            Divider().width('100%').height(1).backgroundColor('#eee')

            // 2. 仅下方内容放入Scroll滚动区域，导航栏不参与滚动
            Scroll() {
                Column() {
                    Column({ space: 20 }) {
                        Button("去应用商店写完整评价或反馈Bug")
                            .width('80%')
                            .height(48)
                            .backgroundColor('#1B5E20')
                            .fontColor('#fff')
                            .borderRadius(12)
                            .onClick(() => this.jumpToStoreReview())

                        Button("去Github提交issues")
                            .width('80%')
                            .height(48)
                            .backgroundColor('#ff000000')
                            .fontColor('#fff')
                            .borderRadius(12)
                            .onClick(() => this.jumpToGithub())

                        Button("去Notion提交Bug和建议")
                            .width('80%')
                            .height(48)
                            .backgroundColor('#ffc6a471')
                            .fontColor('#fff')
                            .borderRadius(12)
                            .onClick(() => this.jumpToNotion())
                    }
                    Blank().height(40)
                }
                .width('100%')
                .backgroundColor('#ffffff')
            }
            .layoutWeight(1)
            .backgroundColor('#ffffffff')
            .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#ffffff')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
}