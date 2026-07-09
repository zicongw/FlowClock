import router from '@ohos.router';
import type { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { commentManager } from '@kit.AppGalleryKit';
import promptAction from '@ohos.promptAction';


@Entry
@Component
struct Bugabout {
    private uiContext: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;

    // 系统返回按键/侧滑返回拦截
    onBackPress(): boolean {
        // 返回上一页
        router.back();
        // 返回true表示消费本次返回事件，阻止系统默认退出
        return true;
    }

    jumpToGithub() {
        const uiContext: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
        const githubUrl = "https://github.com/zicongw/FlowClock.git";
        uiContext.openLink(githubUrl, { appLinkingOnly: false })
            .catch((err: BusinessError) => {
                //console.error("打开GitHub失败", err.code, err.message);
                promptAction.showToast({ message: "无法打开网页，请检查网络" });
            })
    }

    jumpToNotion() {
        const uiContext: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
        const notionUrl = "https://mixed-tibia-a61.notion.site/FlowClock-3981928f6f018042b579edb16475505e?source=copy_link";
        uiContext.openLink(notionUrl, { appLinkingOnly: false })
            .catch((err: BusinessError) => {
                //console.error("打开Notion失败", err.code, err.message);
                promptAction.showToast({ message: "无法打开网页，请检查网络" });
            })
    }



    jumpToStoreReview() {
        const pkg = this.uiContext.abilityInfo.bundleName;
        const want: Want = {
            action: "ohos.want.action.appdetail",
            uri: `store://appgallery.huawei.com/app/detail?id=${pkg}&action=write-review`
        };
        this.uiContext.startAbility(want).catch((err: BusinessError) => {
            //console.error("跳转商店失败 code:", err.code, "msg:", err.message);
            this.uiContext.openLink(`https://appgallery.huawei.com/app/detail?id=${pkg}&action=write-review`, { appLinkingOnly: false })
        })
    }

    build() {
        Scroll(){
        Column() {
            Row() {
                Image($r('sys.media.ohos_ic_public_arrow_left'))
                    .width(28)
                    .height(28)
                    .onClick(() => {
                        router.back()
                    })
                Text("关于专注时钟")
                    .fontSize(22)
                    .fontWeight(FontWeight.Medium)
                    .layoutWeight(1)
                    .textAlign(TextAlign.Center)
                Blank().width(28)
            }
            .width('100%')
            .padding({
                left: 16,
                right: 16,
                top: 12,
                bottom: 12
            })

            Divider().width('100%').height(1).backgroundColor('#eee')

            Blank().height(40)
            Image($r('app.media.icon'))
                .width(120)
                .height(120)
                .borderRadius(24)
            Blank().height(20)
            Text("FlowClock 专注时钟")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
            Text("version 1.0.0")
                .fontSize(14)
                .fontColor('#666')
                .margin({ top: 6 })

            Blank().height(40)
            Text("一款初二学生闲暇时间开发的简洁清新的专注计时开源App，帮助你专注学习、高效工作，远离手机干扰。")
                .fontSize(16)
                .fontColor('#333')
                .textAlign(TextAlign.Center)
                .padding({ left: 30, right: 30 })
            Text(
                "由于此应用为SwiftUI语言移植应用，所以可能会出现错误，请给我们机会，我们会慢慢改正。本应用除系统内置图标外均来自Icons8")
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333')
                .textAlign(TextAlign.Center)
                .padding({ left: 30, right: 30, top: 25 })

            Blank().height(60)
            Column({ space: 20 }) {
                Button("去应用商店写完整评价或反馈Bug")
                    .width('80%')
                    .height(48)
                    .backgroundColor('#1B5E20')
                    .fontColor('#fff')
                    .onClick(() =>
                    this.jumpToStoreReview()
                    )

                Button("去Github提交issues")
                    .width('80%')
                    .height(48)
                    .backgroundColor('#ff000000')
                    .fontColor('#fff')
                    .onClick(() =>
                    this.jumpToGithub()
                    )

                Button("去Notion提交Bug和建议")
                    .width('80%')
                    .height(48)
                    .backgroundColor('#ffc6a471')
                    .fontColor('#fff')
                    .onClick(() =>
                    this.jumpToNotion()
                    )
            }
        }
        .width('100%')
        .backgroundColor('#ffffff')
        }
        .width('100%')
        .height('100%')
    }
}